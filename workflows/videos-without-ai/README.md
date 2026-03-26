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
Este flujo transforma una imagen estática en un clip de video (`mp4`), ofreciendo una versión **Simple** (sin movimiento) y una **Advanced** (con efectos de cámara).

#### 🛠️ Configuración (Nodos Config)

| Parámetro | Descripción | Valor Sugerido |
| :--- | :--- | :--- |
| `path` | Carpeta local donde se descargan y procesan los archivos. | `./.n8n-files/temp/image-to-video` |
| `filename_prefix` | Prefijo para el archivo de video generado. | `video_` |
| `video_extension` | Formato del video (ej. `mp4`, `mkv`). | `mp4` |
| `fps` | Cuadros por segundo (fluidez). | `30` |
| `seconds` | Duración total del video en segundos. | `5` |
| `zoom_in` | (Solo Advanced) % del tiempo inicial para zoom-in (0 a 1.0). | `0.2` |
| `zoom_out` | (Solo Advanced) % del tiempo final para zoom-out (0 a 1.0). | `0.2` |
| `rotation_deg` | (Solo Advanced) Grados máximos de oscilación. | `1` |
| `rotation_speed`| (Solo Advanced) Segundos por cada ciclo de rotación. | `3` |

#### 🧠 Funcionamiento
1. **Descarga**: Obtiene la imagen desde Google Drive usando el `input_image_id`.
2. **Renderizado**: Ejecuta FFmpeg aplicando filtros de `zoompan` y `rotate` para simular movimiento de cámara realista.
3. **Entrega**: El clip se guarda en el disco local listo para ser usado por otros subflujos.

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
