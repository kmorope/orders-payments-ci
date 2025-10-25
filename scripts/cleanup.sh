#!/bin/bash
echo "🧹 Limpiando contenedores y redes..."
docker compose down -v --remove-orphans