FROM python:3.11-slim

WORKDIR /app

# Instalar dependencias básicas y ffmpeg
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar Whisper y FastAPI + Uvicorn
RUN pip install --no-cache-dir openai-whisper fastapi uvicorn python-multipart

# Copiar app
COPY app.py .

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
