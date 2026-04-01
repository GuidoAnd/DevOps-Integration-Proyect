FROM nginx:alphine.1 AS Builder 

WORKDIR /media/app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --user -r requirements.txt


FROM nginx:alphine.1 AS Runtime

WORKDIR /media/app

COPY --from=Builder /root/.local /root/.local

