#!/usr/bin/env bash
set -euo pipefail

IMAGE=${IMAGE:-cvrl_bootcamp:latest}   # build image name
CONTAINER_NAME=${CONTAINER_NAME:-bootcamp_dev}

# run.sh 
SCRIPT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
PROJ_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

# GPU flag
GPU_FLAGS=()
if command -v nvidia-smi >/dev/null 2>&1; then
  GPU_FLAGS=(--gpus all -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all)
fi

# GUI
xhost +local:root >/dev/null 2>&1 || true

echo "[run.sh] IMAGE=$IMAGE"
echo "[run.sh] PROJ_ROOT=$PROJ_ROOT"
echo "[run.sh] CONTAINER_NAME=$CONTAINER_NAME"

# start container
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}\$"; then
  if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}\$"; then
    echo "[run.sh]  Attaching to running container: $CONTAINER_NAME"
    exec docker exec -it "$CONTAINER_NAME" bash
  else
    echo "[run.sh]  Restarting stopped container: $CONTAINER_NAME"
    docker start -ai "$CONTAINER_NAME"
  fi
else
  echo "[run.sh]  Creating new container: $CONTAINER_NAME"
  docker run -it \
    --name "$CONTAINER_NAME" \
    --net=host \
    "${GPU_FLAGS[@]}" \
    -e DISPLAY="$DISPLAY" \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v "$HOME/.ssh":/root/.ssh:ro \
    -v "$PROJ_ROOT/docker":/root/bootcamp/docker \
    -w /root/bootcamp \
    "$IMAGE"
fi

