# 🎞️ Video Automation (No-AI) – n8n Templates

Sistema avanzado de flujos n8n para generar videos dinámicos de alta calidad a partir de imágenes estáticas y audio, utilizando **FFmpeg** de forma local para un control total sin depender de APIs de IA externas.

---

## ⚙️ Requisitos Generales

- **n8n** (servidor local o Docker con acceso a carpetas locales).
- **FFmpeg** instalado y disponible en el PATH del sistema.
- **Credenciales:** Google Drive OAuth2 API.

> [!IMPORTANT]
> FFmpeg es el motor principal. Asegúrate de que n8n tenga permisos para ejecutar comandos y acceder a la carpeta temporal definida en la configuración (`path`).

---

## 📦 Flujos Detallados

### 🖼️ 1. YT - FFmpeg - Image to Video
Este flujo permite transformar una imagen estática en un clip de video (`mp4`), ofreciendo una versión **Basic** (estática) y una **Advanced** (con efectos de cámara dinámicos).

#### 🛠️ Configuración (Nodos Config)

| Parámetro | Descripción | Valor Sugerido |
| :--- | :--- | :--- |
| `input_image_id` | ID del archivo de imagen en Google Drive. | `17gSNcr...` |
| `path` | Carpeta local para el procesamiento (debe existir). | `./.n8n-files/ffmpeg-temp/image-to-video` |
| `filename_prefix` | Prefijo para los archivos generados. | `image_to_video_` |
| `video_extension` | Extensión del video de salida (ej. `mp4`). | `mp4` |
| `fps` | Cuadros por segundo (fluidez). | `30` |
| `seconds` | Duración total del video en segundos. | `5` |
| `zoom_in` | (Advanced) % del tiempo inicial para zoom-in (0.0 - 1.0). | `0.2` |
| `zoom_out` | (Advanced) % del tiempo final para zoom-out (0.0 - 1.0). | `0.2` |
| `rotation_deg` | (Advanced) Grados máximos de inclinación. | `1` |
| `rotation_speed`| (Advanced) Segundos por cada ciclo de rotación. | `3` |

#### 🧠 Funcionamiento
1. **Limpieza**: El flujo limpia la carpeta temporal configurada en `path` para evitar conflictos.
2. **Descarga**: Obtiene la imagen desde Google Drive utilizando el `input_image_id`.
3. **Renderizado (Basic)**: Crea un video estático repitiendo el frame de la imagen durante los segundos definidos.
4. **Renderizado (Advanced)**: Aplica filtros de `zoompan` (movimiento Ken Burns) y `rotate` (oscilación sinusoidal) para un acabado profesional.
5. **Entrega**: El archivo resultante queda alojado en el sistema local para ser consumido por otros procesos.

---

### 🎙️ 2. YT - FFmpeg - Image and Audio to Video
Genera un video completo sincronizado cuya duración se ajusta automáticamente al archivo de audio proporcionado, aplicando un efecto Ken Burns fluido.

#### 🛠️ Configuración (Nodo Config)

| Parámetro | Descripción | Valor Sugerido |
| :--- | :--- | :--- |
| `path` | Ruta de workspace local para el procesamiento de archivos. | `./.n8n-files/temp/audio-video` |
| `filename_prefix`| Prefijo nominativo para el video final. | `final_vid_` |
| `zoom_amount` | Intensidad del zoom (escala de acercamiento). | `0.2` |
| `zoom_in` / `out` | % de la duración total destinada a cada fase de zoom. | `0.2` |
| `fps` | Cuadros por segundo del video resultante. | `30` |
| `rotation_deg` | Grados de inclinación para el efecto de movimiento. | `1` |
| `rotation_speed` | Velocidad de oscilación sinusoidal en segundos. | `3` |

#### 🧠 Funcionamiento
1. **Descarga Dual**: Obtiene la imagen y el audio de Google Drive de forma asíncrona.
2. **Cálculo de Tiempos**: Usa `ffprobe` para medir el audio y calcular el número exacto de frames necesarios.
3. **Renderizado**: Aplica fórmulas matemáticas complejas en FFmpeg para el escalado dinámico.
4. **Finalización**: Sube el video resultante automáticamente a la carpeta de Google Drive especificada.

---

## 📂 Recursos Adicionales

### [Adapted Past Automations](./adapted-past-automation/README.md)
Versiones adaptadas de proyectos clásicos (Skeleton, Stickman, Terror) para funcionar con este motor de automatización local.

---

| Canal Oficial | Tutorial Completo |
| :--- | :--- |
| 🔔 [Hans Acha](https://www.youtube.com/@Hans-Acha) | 📺 [Ver Guía en YouTube](https://youtu.be/xxxxxx) |

---

💡 **El poder de la automatización local: videos profesionales sin cuotas de IA ni límites.**
