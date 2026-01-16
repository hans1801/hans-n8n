# 🎧 ASMR Videos – n8n Templates

Este repositorio contiene un **sistema completo de automatización para generar videos ASMR con IA**, listo para usar con **n8n**, **Google Gemini**, **Google Drive**, **Google Sheets** y **FFmpeg**.

Todos los flujos y archivos de ejemplo están organizados dentro de la carpeta:

```
videos-ASMR/
```

El objetivo es que puedas **importar las plantillas**, conectar tus credenciales y empezar a generar **Shorts y videos largos ASMR** de forma totalmente automática.

---

## 🧩 ¿Qué incluye este folder?

Dentro de `videos-ASMR` encontrarás **5 flujos principales** y **Google Sheets de ejemplo** para control y registro.

### 🔀 1. Random ASMR Generator (Subflujo)

Selecciona **aleatoriamente** qué plantilla ASMR se ejecuta.

Ideal para:

* Variar contenido automáticamente
* Escalar a múltiples temáticas sin duplicar lógica

---

### 🧪 2. AI Laboratory ASMR – Short Video

Genera **videos ASMR cortos (9:16)** con estética de laboratorio.

* Usa parámetros dinámicos (sustancia, líquido, reacción, transformación)
* Guarda el video en Google Drive
* Registra el resultado en Google Sheets

---

### 🍓 3. AI Fruit ASMR – Short Video

Genera **Shorts ASMR de frutas** enfocados en cortes, texturas e interiores.

* Diseñado para Shorts / Reels / TikTok
* Totalmente automatizado
* Registro automático en Sheets

---

### 🧪 4. AI Laboratory ASMR – Long Video

Construye un **video ASMR largo** a partir de múltiples Shorts de laboratorio.

Flujo general:

* Generación creativa de temática con IA
* Creación de varios Shorts coherentes
* Unión de clips con transiciones (FFmpeg)
* Registro final en Google Sheets

---

### 🍓 5. AI Fruit ASMR – Long Video

Genera **videos ASMR largos de frutas** combinando múltiples clips cortos.

* Temática coherente por ejecución
* Shorts agrupados automáticamente
* Video largo final con transiciones suaves

---

## 📊 Google Sheets de ejemplo

El repositorio incluye **Google Sheets de ejemplo** que puedes:

* Duplicar en tu propia cuenta
* Usar para control de IDs
* Registrar estado, parámetros y URLs de los videos generados

Cada flujo usa la variable:

```text
google_sheet_id
```

que se define en el nodo **Config** de cada plantilla.

---

## ⚙️ Configuración general

1. Importa todos los flujos en n8n
2. Duplica los Google Sheets de ejemplo en tu cuenta
3. Configura las credenciales:

   * Google Gemini
   * Google Drive
   * Google Sheets
4. Ajusta la variable `google_sheet_id` en cada flujo
5. Ejecuta manualmente o con Schedule Trigger

---

📺 **Guía paso a paso completa en video:**
👉 [Cómo configurar todo el sistema](https://youtu.be/xxxxxx)

🔔 **Más automatizaciones y flujos avanzados** en el canal:
👉 [Hans Acha – Canal Oficial](https://www.youtube.com/@Hans-Acha)

---

💡 Este sistema está diseñado para:

* Escalar a nuevas temáticas ASMR
* Reutilizar plantillas
* Automatizar canales completos de ASMR

Solo importa, conecta y deja que el sistema genere contenido 🎥✨
