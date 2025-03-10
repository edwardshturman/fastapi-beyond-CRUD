FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV HOST = 0.0.0.0
EXPOSE 8000

CMD [ "fastapi", "run", "src", "--port", "8000", "--host", "0.0.0.0" ]
