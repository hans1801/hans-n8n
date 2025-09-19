# 🤖 Chatwoot Chatbot - Multi-Agents (State Manager Templates)

Este repositorio contiene **plantillas JSON** y guías rápidas para configurar y gestionar una **máquina de estados** en Chatwoot mediante n8n.  

Incluye:  
- ⚙️ **Configuración principal de Chatwoot**  
- 🛠️ **Herramienta Gestor de Estados (State Manager)**  

---

## 📂 Plantillas incluidas
- `YT - Multi-agente.json` → Estados base y conexión con Chatwoot.  
- `YT - Handle Label.json` → Representación de la máquina de estados en formato JSON.  

---

## ⚙️ Configuración básica

1. **Crea los estados en Chatwoot**  
2. **Actualiza los nodos con la herramienta Gestor de Estados**:  
   - `Obtener label actual`  
   - `Siguientes Labels`  
   - `Actualizar Label`  
   - `Nuevos Siguientes Labels`  
3. **Actualiza tu `api_access_token` de Chatwoot** en los nodos **HTTP Requests**  
4. **Configura el Switch** con los estados definidos  
5. **Actualiza tus credenciales de PostgreSQL**  
6. **Configura el Webhook URL en Chatwoot**

---

## 🛠️ Herramienta Gestor de Estados

1. **Actualiza los nodos principales**:  
   - `Label Settings`  
   - `Set Start Label`  
2. **Configura `Label Settings`** como la representación de una **máquina finita de estados en JSON**  
3. **Actualiza tu `api_access_token` de Chatwoot** en los nodos **HTTP Requests**
