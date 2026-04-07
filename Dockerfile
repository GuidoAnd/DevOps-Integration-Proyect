## Builder && Compiler
FROM python:3.14-slim AS builder 

WORKDIR /media/app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --user -r requirements.txt

## Optimized Image

FROM python:3.14-slim AS runtime

WORKDIR /media/app

COPY --from=builder /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH
ENV FLASK_ENV=production

COPY app/ /media/app
COPY tests/ tests/

EXPOSE 6000

CMD ["python", "app.py"]