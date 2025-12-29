# Stage 1: Get FFmpeg from a trusted source
FROM mwader/static-ffmpeg:8.0 AS ffmpeg

# Stage 2: Use the official n8n v2 stable image
FROM n8nio/n8n:stable

USER root

# Copy the ffmpeg binaries from the first stage into n8n
COPY --from=ffmpeg /ffmpeg /usr/local/bin/
COPY --from=ffmpeg /ffprobe /usr/local/bin/

# Set permissions so the 'node' user can run them
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

USER node

