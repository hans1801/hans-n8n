# 🎭 Stories with Animated Objects

Plantillas de **n8n** para generar **videos cortos con objetos animados** para Shorts, Reels y TikTok.

**De idea → video final** completamente automatizado.

---

## 📦 Flujos incluidos

### 🎬 Base

Ejecuta **manualmente** con tu propia idea.

**Uso:**
1. Define tu `idea` en el nodo Config
2. Ejecuta el flujo
3. Obtén tu video final

**Ideal para:** probar ideas específicas.

---

### 🔄 Generator

Genera videos **automáticamente** sin intervención.

**Uso:**
1. Define el `nicho` en el nodo Config (finanzas, salud, cocina, tecnología, etc.)
2. Configura Schedule Trigger (diario, semanal...)
3. El flujo genera todo automáticamente:
   - Ideas originales basadas en el nicho
   - Storyboard de 3 escenas
   - Imágenes y animaciones
   - Video final

**Ideal para:** producción continua de contenido.

> [!TIP]
> **Funciona con cualquier nicho.** Solo cambia el campo `nicho` y la IA generará ideas relevantes automáticamente.

---

## ⚙️ Requisitos

- n8n
- Google Drive
- Google Gemini
- FFmpeg

**Workflows de soporte (importar primero):**
- **[videos-style-reference](../videos-style-reference/README.md)**: `YT - Image Style Reference` + `YT - Image to Video`
- **[ffmpeg-basics](../ffmpeg-basics/README.md)**: `YT - FFmpeg - Combine Videos Simple`

---

## 🚀 Configuración

**1. Importa** los 3 workflows de soporte

**2. Conecta** credenciales:
- Google Gemini API
- Google Drive OAuth2

**3. Configura** el nodo Config:

**Base:**
```javascript
idea: "Tu historia"
ideas_hub_folder_id: "ID carpeta Drive"
style_reference_images_folder_id: "ID carpeta estilo"
```

**Generator:**
```javascript
nicho: "finanzas" // o salud, cocina, tecnología, etc.
ideas_hub_folder_id: "ID carpeta Drive"
ideas_sheet_id: "ID Google Sheet para registro"
style_reference_images_folder_id: "ID carpeta estilo"
```

---

## 🧠 Proceso

1. **Storyboard** → IA genera 3 escenas
2. **Imágenes** → Con style reference
3. **Animación** → Movimiento + diálogo
4. **Video final** → Combinado con FFmpeg

---

📺 **Tutorial:** [youtu.be/xxxxxx](https://youtu.be/xxxxxx)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)

---

💡 **Base** = ideas manuales | **Generator** = producción automática por nicho
