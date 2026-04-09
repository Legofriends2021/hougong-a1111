FROM registry.runpod.net/runpod-workers-worker-a1111-main-dockerfile:022c30933

COPY start.sh /start.sh
RUN chmod +x /start.sh
