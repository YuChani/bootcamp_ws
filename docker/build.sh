#!/usr/bin/env bash
set -euo pipefail

# setting
IMAGE_NAME="cvrl_bootcamp"
TAG="latest"

# local
SCRIPT_DIR="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd -P)"

# Dockerfile auto find
if [[ -f "$REPO_ROOT/Dockerfile" ]]; then
  DOCKERFILE="$REPO_ROOT/Dockerfile"
elif [[ -f "$REPO_ROOT/docker/Dockerfile" ]]; then
  DOCKERFILE="$REPO_ROOT/docker/Dockerfile"
else
  echo " Dockerfile not found in $REPO_ROOT or $REPO_ROOT/docker"
  exit 1
fi

# build
echo "[build.sh] Building image: ${IMAGE_NAME}:${TAG}"
echo "[build.sh] Using Dockerfile: $DOCKERFILE"

docker build \
  -t "${IMAGE_NAME}:${TAG}" \
  -f "$DOCKERFILE" \
  "$REPO_ROOT"

echo "[build.sh] Build complete: ${IMAGE_NAME}:${TAG}"

