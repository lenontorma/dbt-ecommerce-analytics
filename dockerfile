# Dockerfile
FROM python:3.10-slim

WORKDIR /usr/app

# Instala o 'git' (necessário para dbt deps) e 'postgresql-client' (para psql, opcional)
RUN apt-get update && apt-get install -y \
    git \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copia e instala as dependências Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt