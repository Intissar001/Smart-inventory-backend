FROM python:3.10-slim
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libxcb1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# ✅ EXPOSE doit correspondre au port que Railway attend
EXPOSE 8080

ENV YOLO_CONFIG_DIR=/tmp/Ultralytics
ENV PORT=8080

CMD ["sh", "-c", "uvicorn detect_api:app --host 0.0.0.0 --port ${PORT:-8080}"]
