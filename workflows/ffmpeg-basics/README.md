# 🎬 n8n + FFmpeg Basics - Templates

Plantillas de **n8n** para **automatizar edición de video y audio usando FFmpeg**.

👉 **Video explicativo paso a paso en YouTube:**
🔗 [https://youtu.be/3TgRRVtNUAs](https://youtu.be/3TgRRVtNUAs)

---

## ✅ Requisitos

Antes de usar las plantillas necesitas:

* **n8n** instalado
* **FFmpeg** instalado

Si aún no los tienes, revisa los **videos de instalación** enlazados en la descripción del tutorial de YouTube.

---

## ⚙️ Configuración rápida

### n8n versión 2.x

Asegúrate de tener esta variable de entorno:

```env
NODES_EXCLUDE="[]"
```

Esto habilita el nodo **Execute Command**, necesario para ejecutar FFmpeg.

### n8n versión 1.x

No necesitas hacer nada. El nodo ya viene habilitado.

---

## 📦 Importar plantillas

Si al importar una plantilla:

* Ves nodos defectuosos
* Hay diferencias por versión

👉 No te preocupes.

Puedes abrir el **JSON de la plantilla** para:

* Identificar el nodo
* Ver campos, valores y opciones

En el video se revisa cada flujo **nodo por nodo**.

---

## 🔁 Uso recomendado

Las plantillas están pensadas como **sub-workflows**, para que puedas reutilizarlas en distintos flujos.

En el tutorial se usa **Google Drive** para:

* Guardar archivos generados
* Ver el proceso paso a paso

Se trabaja principalmente con:

* ID del folder
* ID de los archivos

Estos IDs se obtienen desde:

* El flujo padre en n8n
* La URL de Google Drive

Más adelante puedes simplificar usando **almacenamiento local**.

---

## 🏗️ Estructura de los flujos

Todas las plantillas siguen esta estructura:

1. Setup inicial
2. Descarga de archivos
3. **Ejecución del comando FFmpeg** (parte clave)
4. Subida del resultado
5. Limpieza del disco local (necesaria para evitar problemas de espacio)

---

## 🚀 Listo

Con esto ya tienes todo preparado.

Ahora sí, **empieza a usar las plantillas 🚀**

Si te resulta útil, deja una ⭐ en el repositorio y revisa el video para el paso a paso completo.
