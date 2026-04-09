# 用 ashleykza 的公开 A1111 worker 镜像（DockerHub 上有，不需要 RunPod 登录）
FROM ashleykza/runpod-worker-a1111:1.0.6

# 替换 start.sh，支持从 Network Volume 加载 mopMix
COPY start.sh /start.sh
RUN chmod +x /start.sh
