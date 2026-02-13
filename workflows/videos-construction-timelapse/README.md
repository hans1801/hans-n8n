# 🏗️ Construction Videos (Architectural Timelapse)

Sistema de automatización en **n8n** para generar videos de **transformación arquitectónica** hiperrealistas (Shorts/Reels) utilizando Inteligencia Artificial Generativa.

**De un espacio vacío a un interior de lujo en segundos.**

---

## 🎬 Flujos Principales

### 🛋️ [YT - Construction Timelapse - Base](YT%20-%20Construction%20Timelapse%20-%20Base.json)
Producción **manual/dirigida**. Ideal para arquitectos que tienen una idea específica del diseño a visualizar.
*   **Entrada:** Define tu `idea` en el nodo **Config**.
*   **Resultado:** Storyboard, imágenes secuenciales y video de morphing fusionado.

### 🤖 [YT - Construction Timelapse - Generator](YT%20-%20Construction%20Timelapse%20-%20Generator.json)
Producción **100% automática** y masiva. Gestiona ideas virales, carpetas en Drive y registra progreso en Sheets.
*   **Entrada:** Define el `build_type` (ej: "estadios", "cocinas modernas").
*   **Resultado:** Generación de contenido "faceless" listo para publicar.

---

## ⚙️ Sub-flujos de Soporte (Importar Primero)

Para que los flujos principales funcionen, debes importar estos dos motores:

1.  **[YT - Generate Sequential Image](YT%20-%20Generate%20Sequential%20Image.json)**: Motor de imágenes con **Gemini** que mantiene coherencia visual entre frames.
2.  **[YT - Start-End Image to Video](YT%20-%20Start-End%20Image%20to%20Video.json)**: Motor de video con **Google Veo** que crea transiciones suaves (morphing).

> [!IMPORTANT]
> También requiere el workflow base de **[ffmpeg-basics](../ffmpeg-basics/README.md)** para la unión final de clips y mezcla de audio.

---

## 🚀 Configuración Inicial

1.  **Credenciales**: Configura **Google Gemini API**, **Google Drive** y **Google Sheets** en n8n.
2.  **IDs de Carpeta**: En los nodos `Config`, especifica los IDs de tus carpetas de Google Drive donde se guardarán los resultados.
3.  **Hojas de Cálculo**: (Solo para Generator) Configura el ID del Google Sheet para el seguimiento de ideas.

---

## 🧠 ¿Cómo funciona?

1.  **Idea/Script**: La IA (Gemini) propone una evolución arquitectónica lógica.
2.  **Storyboard**: Se definen 4 etapas clave (Obra -> Preparación -> Acabado -> Final).
3.  **Producción Visual**: Generación secuencial de imágenes y videos de morphing (Veo).
4.  **Render Final**: Unión automática de clips con FFmpeg incluyendo música/SFX.

---

📺 **Tutorial Completo:** [youtu.be/xxxxxx](https://youtu.be/xxxxxx)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)
