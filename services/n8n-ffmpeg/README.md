# n8n + FFmpeg (Docker Compose)

Guía para **agregar FFmpeg a n8n** usando Docker, de forma reproducible y lista para producción.

---

## ⚙️ Configuración previa de n8n

Antes de instalar **FFmpeg**, asegúrate de que **n8n pueda ejecutar comandos del sistema**.

FFmpeg se ejecuta desde n8n mediante el nodo **Execute Command**, el cual corre **dentro del contenedor de n8n**.

---

### Compatibilidad por versión

* **n8n 1.x** → No requiere configuración adicional.
* **n8n 2.x** → El nodo **Execute Command** está deshabilitado por defecto.

---

### Habilitar Execute Command (n8n 2.x)

Agrega la siguiente variable de entorno en tu `docker-compose.yml` o archivo `.env`:

```env
NODES_EXCLUDE="[]"
```

Ejemplo en `docker-compose.yml`:

```yaml
environment:
  - NODES_EXCLUDE=[]
```

Esto indica que **no se excluye ningún nodo**, habilitando el uso de **Execute Command**.

---

### Reiniciar y validar

```bash
sudo docker compose down
sudo docker compose up -d
```

Luego, entra a n8n y verifica que el nodo **Execute Command** esté disponible.

---

## 🎬 Instalación de FFmpeg en n8n

---

### ¿Por qué usar un Dockerfile?

* **FFmpeg no es un servicio**, es un binario que se ejecuta por comandos.
* El nodo **Execute Command** corre **dentro del contenedor de n8n**.
* La imagen oficial `n8nio/n8n:stable` **no incluye FFmpeg**.

👉 Necesitamos una **imagen personalizada de n8n** que incluya FFmpeg.

---

### 1) Estructura del proyecto

Solo se agrega **un archivo nuevo** al mismo nivel que `docker-compose.yml`:

```
n8n_project/
├── Dockerfile        ← NUEVO
├── docker-compose.yml
├── data/
├── redis-data/
└── postgres-vector-data/
```

---

### 2) docker-compose.yml (único cambio)

En el servicio `n8n`, **reemplaza**:

```yaml
    image: n8nio/n8n:stable
```

por:

```yaml
    build:
      context: .
      dockerfile: Dockerfile
    image: n8n-with-ffmpeg
```

🔹 No modifiques ningún otro parámetro del servicio (`ports`, `env`, `volumes`, etc.).

Esto le indica a Docker que:

* construya una imagen personalizada usando el `Dockerfile`
* use esa imagen (`n8n-with-ffmpeg`) al levantar el contenedor

Nota: guarda el valor del tag que usabas, por ejemplo aqui seria `stable`

---

### 3) Dockerfile (n8n + FFmpeg)

Crea un archivo `Dockerfile`:

```dockerfile
# Stage 1: FFmpeg estático
FROM mwader/static-ffmpeg:8.0 AS ffmpeg

# Stage 2: n8n (usa el tag guardado)
FROM n8nio/n8n:stable

USER root
COPY --from=ffmpeg /ffmpeg /usr/local/bin/
COPY --from=ffmpeg /ffprobe /usr/local/bin/
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
USER node
```

---

### 4) Build & Run

```bash
sudo docker compose down
sudo docker compose build n8n
sudo docker compose up -d
```

---

### 5) Verificación rápida

```bash
sudo docker exec -it n8n ffmpeg -version
```

Si se muestra la versión de FFmpeg → ✅ instalación correcta.

---

## ✅ Resumen

* `Dockerfile` → define **qué trae la imagen** (FFmpeg).
* `docker-compose` → define **cómo se ejecuta** n8n.
* FFmpeg debe existir **dentro del contenedor**, no como servicio separado.

Minimal, reproducible y listo para producción.
