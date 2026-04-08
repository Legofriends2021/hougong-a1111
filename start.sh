#!/usr/bin/env bash

echo "Worker Initiated"

# 如果 Volume 里有 mopMix，用它；否则用内置的 Deliberate
CKPT_PATH="/workspace/stable-diffusion-webui/models/Stable-diffusion/mopMix_omnia_2503808.safetensors"
DEFAULT_CKPT="/model.safetensors"

if [ -f "$CKPT_PATH" ]; then
    echo "Found mopMix in Volume, using it"
    CKPT_ARG="$CKPT_PATH"
else
    echo "mopMix not found, using default"
    CKPT_ARG="$DEFAULT_CKPT"
fi

echo "Starting WebUI API with checkpoint: $CKPT_ARG"
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"
export PYTHONUNBUFFERED=true
python /stable-diffusion-webui/webui.py \
  --xformers \
  --no-half-vae \
  --skip-python-version-check \
  --skip-torch-cuda-test \
  --skip-install \
  --ckpt "$CKPT_ARG" \
  --ckpt-dir /workspace/stable-diffusion-webui/models/Stable-diffusion \
  --opt-sdp-attention \
  --disable-safe-unpickle \
  --port 3000 \
  --api \
  --nowebui \
  --skip-version-check \
  --no-hashing \
  --no-download-sd-model &

echo "Starting RunPod Handler"
python -u /handler.py
