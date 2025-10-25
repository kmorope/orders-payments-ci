#!/bin/bash
set -e
export DOCKER_BUILDKIT=1

echo "🧪 Ejecutando pruebas de ambos microservicios..."
docker compose --profile test up --abort-on-container-exit --exit-code-from orders-tests