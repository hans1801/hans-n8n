# ✏️ Stickman Videos Automation

Sistema avanzado para transformar ideas abstractas en vídeos de motivación viral al estilo **stickman minimalist**. Proyecta historias que rompen el patrón mental del espectador y generan una identificación inmediata a través de un storytelling disruptivo.

**De una simple idea a un video vertical de alto impacto con IA y n8n**.

---

## ⚙️ Requisitos

Antes de empezar, asegúrate de cumplir con lo siguiente:

- **n8n** (servidor local o cloud)
- **Credenciales:** Google Gemini API (PaLM), Google Drive OAuth2.
- **Software:** FFmpeg (instalado en el servidor de n8n).

### 🖇️ Subflujos necesarios
Este workflow depende de varios sub-procesos. Asegúrate de tener importados y configurados los siguientes:
- 🎨 **[YT - Image Style Reference](../videos-style-reference/README.md)**
- 🎙️ **[YT - Text to Voice](../videos-voice-over/README.md)**
- 🎬 **[YT - Image to Video](../videos-style-reference/README.md)**
- 📽️ **[YT - Combine Video With Voice](../videos-voice-over/README.md)**
- 🖇️ **[YT - FFmpeg - Combine Videos Simple](../ffmpeg-basics/README.md)**
- 🎶 **[YT - FFmpeg - Mix Video & Audio](../ffmpeg-basics/README.md)**
- 📝 **[YT - Add Subtitles to video](../../services/n8n-whisper-ffmpeg/README.md)** 

> [!IMPORTANT]
> Asegúrate de tener las credenciales de **Google Gemini** correctamente conectadas en sus respectivos nodos dentro de los subflujos.

---

## 📦 Flujos incluidos

### 🎬 YT - Stickman Video - Base
Genera un video completo de 4 escenas a partir de una idea de usuario. Ideal para flujos de trabajo semi-automáticos donde el control de la idea inicial es primordial.

### 🛠️ Uso y Configuración
Abre el nodo llamado **Config** y completa los siguientes campos:

| Parámetro | Descripción |
| :--- | :--- |
| 💡 `idea` | El concepto central o premisa (ej: "Tu salario no te hará rico"). |
| 📁 `folder_name` | Nombre para la carpeta del proyecto que se creará en Drive. |
| 🎵 `bg_music_id` | ID del archivo de música de fondo .wav en Google Drive. |
| 🏗️ `ideas_hub_folder_id` | ID de la carpeta raíz donde se organizará todo el contenido. |
| 🖼️ `reference_folder_id` | ID de la carpeta con imágenes de referencia para el estilo stickman. |

---

### 🚀 YT - Stickman Video - Generator
Versión automatizada con integración de subtítulos dinámicos. Este flujo está diseñado para escalar la producción de contenido manteniendo la coherencia visual minimalista.

### 🛠️ Uso y Configuración
1.  **Configura el nodo `Config`**:
    Abre el nodo llamado **Config** y completa los siguientes campos:

    | Parámetro | Descripción |
    | :--- | :--- |
    | 📁 `folder_name` | Nombre dinámico para la carpeta del proyecto (autogenerado por defecto). |
    | 🎵 `bg_music_id` | ID del archivo de música de fondo .wav en Google Drive. |
    | 🏗️ `ideas_hub_folder_id` | ID de la carpeta raíz donde se organizará todo el contenido. |
    | 🖼️ `reference_folder_id` | ID de la carpeta con imágenes de referencia para el estilo stickman. |

2.  **Activa la Automatización**:
    - Localiza el nodo **Schedule Trigger** (si está presente) o configura el disparador deseado.
    - Activa el workflow para que el sistema genere y guarde videos de forma autónoma.

---

## 🧠 Proceso
1. **Narrativa Disruptiva** → El agente Gemini transforma la idea en un arco de 4 escenas (Curiosidad, Identificación, Contraste, Resultado).
2. **Generación de Assets** → Creación paralela de prompts visuales, voice overs y videos minimalistas (stickman en blanco/negro con acentos de color).
3. **Ensamblado Técnico** → Mezcla de video con voz, concatenación de escenas y adición de música ambiental vía FFmpeg.
4. **Finalización** → (Solo Generator) Incrustación de subtítulos y almacenamiento organizado en Google Drive.

---

📺 **Tutorial:** [youtu.be/WTDUC0dgPjY](https://youtu.be/WTDUC0dgPjY)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)

---

💡 **Automatiza hoy mismo y convierte tus ideas en visuales virales que detengan el scroll.**
