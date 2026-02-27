# 💀 YT - Skeleton Videos

Sistema automatizado para crear YouTube Shorts virales protagonizados por un esqueleto en situaciones extremas (POV).

**De una simple idea a un video cinematográfico viral en segundos utilizando IA Generativa**.

---

## 📦 Flujos incluidos

### 🦴 YT - Skeleton Video - Base
Genera un video completo (guion, audio, imágenes y video) a partir de una idea manual configurada en el flujo.

**Uso:**
1. Define la **idea** en el nodo Config.
2. Ejecuta el workflow.
3. El video final se guarda automáticamente en Google Drive.

**Ideal para:** Creadores que quieren control total sobre el tema del video.

---

### 🧠 YT - Skeleton Video - Idea Generator
Versión 100% autónoma que utiliza un agente de IA para "soñar" ideas virales extremas y producirlas sin intervención humana.

**Uso:**
1. Configura el **Schedule Trigger** (ej. diario).
2. El Agente de IA genera una idea bajo la premisa "¿Qué pasaría si...?".
3. Producción automática y envío a Drive.

**Ideal para:** Canales de YouTube Shorts automatizados (Faceless Channels).

---

## ⚙️ Requisitos
- **n8n** (Instancia activa)
- **Credenciales:**
  - Google Gemini (Cerebro y Prompts)
  - Google Drive (Almacenamiento de recursos y video final)
  - ElevenLabs (Voz del narrador)
  - Runway Gen-3 Alpha (Motor de video - a través de sub-workflows)
- **Software:** FFmpeg (incluido en los workflows de soporte)

**Workflows de soporte (importar primero):**
- **[YT - Image Style Reference](../videos-style-reference/README.md)**: `Generación de imágenes con estilo consistente`
- **[YT - Text to Voice](../videos-voice-over/README.md)**: `Conversión de guion a audio`
- **[YT - Image to Video](../videos-style-reference/README.md)**: `Animación de escenas`
- **[YT - Combine Video With Voice](../videos-voice-over/README.md)**: `Montaje de escenas individuales`
- **[YT - FFmpeg - Combine Videos Simple](../ffmpeg-basics/README.md)**: `Unión final de clips`

> [!NOTE]
> Los links de soporte apuntan a las carpetas base del repositorio de Readmes para referencia de estructura.

---

## 🚀 Configuración
1. **Importa** todos los workflows de soporte mencionados arriba.
2. **Conecta** tus credenciales en cada nodo correspondiente.
3. **Configura** el nodo **Config** en el workflow principal:

**YT - Skeleton Video - Base:**
```javascript
{
  "idea": "¿Qué pasa si corres sin parar por 100 días?",
  "ideas_hub_folder_id": "ID_DE_TU_CARPETA_EN_DRIVE",
  "reference_folder_id": "ID_DE_CARPETA_CON_IMAGEN_REFERENCIA"
}
```

---

## 🧠 Proceso
1. **Agente de IA** → Analiza la idea y genera un arco narrativo de 4 escenas ("¿Qué pasaría si...?").
2. **Setup de Drive** → Crea carpetas temporales para organizar audios, imágenes y clips.
3. **Generación Paralela** → Produce simultáneamente las 4 escenas (Voz -> Imagen -> Video).
4. **Montaje Técnico** → Combina cada video con su audio correspondiente.
5. **Render Final** → Procesa todos los clips con FFmpeg y genera el video viral.

---

📺 **Tutorial:** [youtu.be/TbN-A0eXN8U](https://youtu.be/TbN-A0eXN8U)  
🔔 **Canal:** [Hans Acha](https://www.youtube.com/@Hans-Acha)

---

💡 **Crea contenido viral masivo sin tocar un editor de video.**
