FROM python:3.13.5-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

COPY requirement.txt .

RUN apt-get update && \
    apt-get install -y gcc libpq-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get remove -y gcc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . .

EXPOSE 5000

ENV FLASK_APP=run.py
ENV FLASK_ENV=production

CMD ["flask", "run", "--host=0.0.0.0"]
