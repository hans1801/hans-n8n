# n8n + FFmpeg + Whisper
Guía para añadir **Whisper** a n8n.

> [!IMPORTANT]
> **Prerrequisito:** Haber configurado [n8n-ffmpeg](../n8n-ffmpeg). Este README solo cubre la integración de Whisper para la transcripción de audio.

---

## 📂 Estructura del proyecto

Para habilitar Whisper junto a la instalación de [n8n-ffmpeg](../n8n-ffmpeg), la estructura debe incluir la carpeta `whisper`:

```text
n8n_project/
├── 📁 whisper/                # Microservicio de transcripción
│   ├── Dockerfile            # Configuración de la imagen Whisper
│   └── app.py                # Lógica de la API (Audio → Texto)
├── Dockerfile                 # Dockerfile de n8n con FFmpeg
└── docker-compose.yml         # Orquestación de ambos servicios
```

---

## ⚙️ Configuración de docker-compose.yml

Añade el servicio de **Whisper** a tu archivo `docker-compose.yml` actual:

```yaml
services:
  # ... otros servicios (n8n, postgres, redis)

  whisper:
    build: ./whisper
    container_name: whisper
    ports:
      - "8000:8000"
    volumes:
      - ./shared_data:/data
```

---

## 🎙️ Instalación Automática (Whisper)

Ejecuta este comando en la raíz de tu proyecto para crear la carpeta `whisper/` y sus archivos necesarios automáticamente:

```bash
sudo mkdir -p whisper && cat <<'EOF' | sudo tee whisper/Dockerfile > /dev/null
FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias básicas y ffmpeg
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar Whisper y FastAPI + Uvicorn
RUN pip install --no-cache-dir openai-whisper fastapi uvicorn python-multipart

# Copiar app
COPY app.py .

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
EOF

cat <<'EOF' | sudo tee whisper/app.py > /dev/null
from fastapi import FastAPI, UploadFile, File, Form  # Añadimos Form
import whisper
from whisper.utils import get_writer
import shutil
import os

app = FastAPI()
model = whisper.load_model("tiny")


def get_whisper_output(result, format_type, output_dir, max_line_width, max_line_count):
    writer = get_writer(format_type, output_dir)
    temp_base = "result"

    # Parámetros dinámicos recibidos desde la API
    writer_args = {
        "max_line_width": max_line_width,
        "max_line_count": max_line_count,
        "highlight_words": False,
    }

    writer(result, temp_base, **writer_args)

    file_path = os.path.join(output_dir, f"{temp_base}.{format_type}")
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    if os.path.exists(file_path):
        os.remove(file_path)
    return content


@app.post("/transcribe")
async def transcribe(
    file: UploadFile = File(...),
    max_line_width: int = Form(30),  # Parámetro opcional con default 30
    max_line_count: int = Form(1),  # Parámetro opcional con default 1
):
    file_location = f"/tmp/{file.filename}"
    try:
        with open(file_location, "wb") as f:
            shutil.copyfileobj(file.file, f)

        result = model.transcribe(file_location, word_timestamps=True, verbose=False)

        output_dir = "/tmp"
        # Pasamos los parámetros a la función de salida
        srt_content = get_whisper_output(
            result, "srt", output_dir, max_line_width, max_line_count
        )
        vtt_content = get_whisper_output(
            result, "vtt", output_dir, max_line_width, max_line_count
        )
        txt_content = result["text"]

        os.remove(file_location)

        return {
            "filename": file.filename,
            "text_plain": txt_content,
            "srt": srt_content,
            "vtt": vtt_content,
            "language": result.get("language"),
            "settings": {
                "max_line_width": max_line_width,
                "max_line_count": max_line_count,
            },
        }
    finally:
        # ESTO SE EJECUTA SIEMPRE, aunque haya un error arriba
        if os.path.exists(file_location):
            os.remove(file_location)
EOF
```

---

### Build & Run

Para aplicar los cambios y levantar el nuevo servicio de Whisper:

```bash
sudo docker compose down
sudo docker compose build n8n
sudo docker compose build whisper
sudo docker compose up -d
```

Para levantar solo whisper

```bash
sudo docker compose build whisper
sudo docker compose up -d
```

---

### Verificación

Valida que el servicio de Whisper con el siguiente comando:
```bash
curl http://localhost:8000/docs
```


---

## ✅ Resumen

* **FFmpeg**: Debe existir **dentro del contenedor de n8n** para ser ejecutado por nodos.
* **Whisper**: Se ejecuta como un **servicio independiente** en el puerto 8000.
* Este setup permite transcribir audios y añadir subtítulos a videos de forma automatizada.
