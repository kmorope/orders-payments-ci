#!/bin/bash
set -e
export DOCKER_BUILDKIT=1

echo "🛠️  Construyendo imágenes..."
docker compose build

echo "🚀 Levantando servicios (orders + payments)..."
docker compose up -d

echo "✅ Servicios activos:"
docker ps

echo
echo "🌐 Orders MS -> http://localhost:3000"
echo "🌐 Payments MS -> http://localhost:3001"