FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ ./app/

ENV PORT=8000
ENV GREETING="Hello, Docker!"
ENV STORAGE="sqlite"
ENV DATA_FILE="/data/counter.db"

CMD ["python", "app/app.py"]