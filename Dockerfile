FROM registry.runpod.net/runpod-workers-worker-a1111-main-dockerfile:022c30933

# 替换 start.sh，支持从 Network Volume 加载 mopMix
COPY start.sh /start.sh
RUN chmod +x /start.sh
