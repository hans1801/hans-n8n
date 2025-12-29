# n8n + FFmpeg (Docker Compose)

Guía para agregar FFmpeg a n8n usando Docker.

---

## ¿Por qué Dockerfile?

* **FFmpeg no es un servicio**, es un binario que se ejecuta.
* El nodo **Execute Command** corre **dentro del contenedor de n8n**.
* La imagen `n8nio/n8n:stable` **no trae ffmpeg**.

👉 Necesitamos una **imagen custom** de n8n que incluya ffmpeg.

---

## 1) Estructura del proyecto

Solo añadimos **un archivo nuevo** al mismo nivel que `docker-compose.yml`:

```
n8n_project/
├── Dockerfile        ← NUEVO
├── docker-compose.yml
├── data/
├── redis-data/
└── postgres-vector-data/
```

---

## 2) Dockerfile (n8n + FFmpeg)

`Dockerfile`:

```dockerfile
# Stage 1: FFmpeg estático
FROM mwader/static-ffmpeg:8.0 AS ffmpeg

# Stage 2: n8n
FROM n8nio/n8n:stable

USER root
COPY --from=ffmpeg /ffmpeg /usr/local/bin/
COPY --from=ffmpeg /ffprobe /usr/local/bin/
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe
USER node
```

---

## 3) docker-compose.yml (ÚNICO CAMBIO)

En el servicio `n8n`, **reemplaza esta línea**:

```yaml
image: n8nio/n8n:stable
```

**por esta configuración**:

```yaml
build:
  context: .
  dockerfile: Dockerfile
image: n8n-with-ffmpeg:stable
```

🔹 **No cambies nada más del servicio** (ports, env, volumes, depends_on, etc).

Esto indica a Docker que:

* construya una imagen nueva usando el `Dockerfile`
* use esa imagen (`n8n-with-ffmpeg`) al levantar el contenedor

---

## 4) Build & Up

```bash
sudo docker compose build --no-cache n8n
sudo docker compose up -d
```

---

## 5) Verificación rápida

```bash
sudo docker exec -it n8n ffmpeg -version
```

Si ves la versión → **listo** ✅

---

## Resumen

* Dockerfile = define **qué trae la imagen** (ffmpeg).
* docker-compose = define **cómo se ejecuta** n8n.
* FFmpeg debe existir **en el contenedor**, no como servicio.

Minimal, reproducible y listo para producción.
