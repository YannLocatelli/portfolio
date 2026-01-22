#!/usr/bin/env bash
set -e

PROJECT_ID="${PROJECT_ID:?❌ PROJECT_ID manquant}"
BUCKET_NAME="${BUCKET_NAME:?❌ BUCKET_NAME manquant}"
KEY_FILE="/key.json"

export CLOUDSDK_CORE_PROJECT="$PROJECT_ID"

# Auth explicite (POINT CLÉ)
echo "🔐 Activation du Service Account"
gcloud auth activate-service-account \
  --key-file="$KEY_FILE" \
  --project="$PROJECT_ID"

# Appliquer le CORS
echo "🚀 Application du CORS sur gs://${BUCKET_NAME}"
gsutil cors set cors.json "gs://${BUCKET_NAME}"

# Vérification
echo "📦 CORS actuel :"
gsutil cors get "gs://${BUCKET_NAME}"

echo "✅ Terminé"
