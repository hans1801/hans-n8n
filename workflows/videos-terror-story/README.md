# 🎭 YouTube Terror Story Videos

Sistema profesional de creación de contenido de terror automatizado para YouTube Shorts, Reels y TikTok. Convierte premisas simples en historias cinematográficas completas con voz, imagen y video animado en minutos.

**Automatiza tu producción de historias de terror de extremo a extremo, desde la idea hasta el montaje final**.

---

## ⚙️ Requisitos

Antes de empezar, asegúrate de cumplir con lo siguiente:

- **n8n** (servidor local o cloud)
- **Credenciales:** Google Gemini API, ElevenLabs API, Google Drive OAuth2.
- **Software:** FFmpeg (instalado en el servidor de n8n).

### 🖇️ Subflujos necesarios
Este workflow depende de varios sub-procesos. Asegúrate de tener importados y configurados los siguientes:
- 🎨 **[YT - Image Style Reference](../videos-style-reference/README.md)**
- 🎙️ **[YT - Text to Voice](../videos-voice-over/README.md)**
- 🎬 **[YT - Image to Video](../videos-style-reference/README.md)**
- 📽️ **[YT - Combine Video With Voice](../videos-voice-over/README.md)**
- 🖇️ **[YT - FFmpeg - Combine Videos Simple](../ffmpeg-basics/README.md)**
- 🎶 **[YT - FFmpeg - Mix Video & Audio](../ffmpeg-basics/README.md)**

> [!IMPORTANT]
> Asegúrate de tener las credenciales de **ElevenLabs** y **Google Gemini** correctamente conectadas en sus respectivos nodos dentro de los subflujos.

---

## 📦 Flujos incluidos

### 🎬 YT - Terror Story Video - Base
Flujo principal que genera el contenido de cada escena (guion, voz, imagen y video) y lo une en un video final con música de fondo.

### 🛠️ Uso y Configuración
Abre el nodo llamado **Config** y completa los siguientes campos:

| Parámetro | Descripción |
| :--- | :--- |
| 💡 `idea` | El concepto central o premisa de la historia (ej: "Recibir una llamada de mi propio número"). |
| 📁 `folder_name` | Nombre para la carpeta del proyecto que se creará en Drive. |
| 🎵 `bg_music_id` | ID del archivo de música de fondo .wav en Google Drive. |
| 🏗️ `ideas_hub_folder_id` | ID de la carpeta raíz donde se organizará todo el contenido. |
| 🖼️ `reference_folder_id` | ID de la carpeta con imágenes de referencia para mantener el estilo visual. |

---

### 🧠 YT - Terror Story Video - Generator
Versión avanzada que incluye un agente para la generación autónoma de ideas y producción recurrente.

### 🛠️ Uso y Configuración
1.  **Configura el nodo `Config`**:
    Abre el nodo llamado **Config** y completa los siguientes campos:

    | Parámetro | Descripción |
    | :--- | :--- |
    | 📁 `folder_name` | Nombre dinámico para la carpeta del proyecto (autogenerado por defecto). |
    | 🎵 `bg_music_id` | ID del archivo de música de fondo .wav en Google Drive. |
    | 🏗️ `ideas_hub_folder_id` | ID de la carpeta raíz donde se organizará todo el contenido. |
    | 🖼️ `reference_folder_id` | ID de la carpeta con imágenes de referencia para mantener el estilo visual. |

2.  **Activa la Automatización**:
    - Localiza el nodo **Schedule Trigger**.
    - Configura la frecuencia deseada (ej: cada 24 horas).
    - Activa el workflow para que el sistema genere y guarde videos de forma autónoma.

---


## 🧠 Proceso
1. **Generación Narrativa** → Gemini diseña 4 escenas tipo creepypasta.
2. **Producción de Activos** → Se generan imágenes, locuciones y videos animados por escena.
3. **Montaje Parcial** → FFmpeg une cada fragmento narrado.
4. **Finalización** → Se unen todas las escenas y se añade la música de fondo.

---

📺 **Tutorial:** [youtu.be/TbN-A0eXN8U](https://youtu.be/TbN-A0eXN8U)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)

---

💡 **Crea, automatiza y domina el nicho de terror con IA.**
