FROM python:3.10-slim

WORKDIR /app

# Installation des dépendances système pour OpenCV
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libxcb1 \
    && rm -rf /var/lib/apt/lists/*

# Copie et installation des dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie du reste du code
COPY . .

# Exposition du port (indicatif)
EXPOSE 8000

ENV YOLO_CONFIG_DIR=/tmp/Ultralytics

# ✅ Format exec avec sh -c pour que $PORT soit interprété
CMD ["sh", "-c", "uvicorn detect_api:app --host 0.0.0.0 --port ${PORT:-8000}"]
