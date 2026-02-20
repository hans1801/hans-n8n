# 🎙️ YT - Voice Over

Sistema automatizado en **n8n** para la generación de locuciones profesionales y su integración automática con clips de video.

**De guion a video final con voz premium totalmente automatizado.**

---

## 📦 Flujos incluidos

### 🗣️ YT - Text to Voice
Convierte fragmentos de texto en audio de alta fidelidad utilizando la API de ElevenLabs.

**Uso:**
1. Recibe `text`, `file_name` y `output_folder_id`.
2. Genera el audio con la voz configurada.
3. Lo sube a la carpeta especificada en Google Drive.

**Ideal para:** Creación de assets de audio individuales.

---

### 🎬 YT - Combine Video With Voice
Fusiona clips de video existentes con archivos de audio usando FFmpeg localmente.

**Uso:**
1. Descarga el video y audio de Google Drive.
2. Mezcla ambos canales asegurando la sincronización.
3. Sube el resultado combinado de vuelta a Drive.

**Ideal para:** Edición técnica automatizada sin intervención manual.

---

### 🔄 YT - Automate Video Voice
Flujo maestro que orquesta la producción masiva de partes de un video.

**Uso:**
1. Define las carpetas de trabajo en el nodo Config.
2. Itera sobre una lista de textos y IDs de video.
3. Genera la voz, combina con el video y une todas las partes al final.

**Ideal para:** Producción en serie de Shorts, Reels y TikToks narrados.

---

## ⚙️ Requisitos
- **n8n** (Instancia con acceso a comandos de terminal)
- **Credenciales:** ElevenLabs API, Google Drive OAuth2
- **Software:** FFmpeg instalado en el sistema

**Workflows de soporte:**
- **[ffmpeg-basics](../ffmpeg-basics/README.md)**: `YT - FFmpeg - Combine Videos Simple` (Referencia externa)

---

## 🚀 Configuración
1. **Importa** los 3 archivos `.json` en n8n.
2. **Conecta** tus credenciales de ElevenLabs y Google Drive.
3. **Configura** los nodos Config en cada flujo:

**YT - Automate Video Voice:**
```javascript
{
  voices_folder_id: "ID_CARPETA_VOCES",
  video_voice_folder_id: "ID_CARPETA_VIDEO_VOZ",
  final_video_folder_id: "ID_CARPETA_FINAL"
}
```

---

## 🧠 Proceso
1. **Locución** → El sistema toma el guion y genera audios MP3 realistas.
2. **Mezcla** → Cada clip de video se une con su audio correspondiente.
3. **Render Final** → Se concatenan todas las partes para generar el video completo.
4. **Almacenamiento** → Todo el proceso se gestiona y guarda en Google Drive.

---

📺 **Tutorial:** [youtu.be/xxxxxx](https://youtu.be/xxxxxx)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)

---

💡 **Automatiza tu narración y escala tu producción de contenido faceless.**
