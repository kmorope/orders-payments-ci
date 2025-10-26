#!/bin/bash
set -e
export DOCKER_BUILDKIT=1

CLUSTER_NAME="ms-demo"
NAMESPACE="apps"

echo "🔧 Verificando cluster kind..."
if ! kind get clusters | grep -q "$CLUSTER_NAME"; then
  echo "⏳ Creando cluster kind: $CLUSTER_NAME"
  kind create cluster --name "$CLUSTER_NAME"
fi

echo "📦 Creando namespace (si no existe)..."
kubectl get ns "$NAMESPACE" >/dev/null 2>&1 || kubectl create ns "$NAMESPACE"

echo "🏗️  Construyendo imágenes desde los repos públicos..."
docker build -t orders:dev https://github.com/llipiterdev/orders-ms.git#main
docker build -t payments:dev https://github.com/llipiterdev/payments-ms.git#main

echo "🚚 Cargando imágenes en kind..."
kind load docker-image orders:dev --name "$CLUSTER_NAME"
kind load docker-image payments:dev --name "$CLUSTER_NAME"

echo "✅ Despliegue completado. Servicios activos:"
kubectl -n "$NAMESPACE" get svc