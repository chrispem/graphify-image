FROM python:3.12-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir "graphifyy[mcp,sql]"

COPY index.sh /index.sh
RUN chmod +x /index.sh

ENTRYPOINT ["python", "-m", "graphify.serve"]
