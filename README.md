# portfolio

Répertoire pour le portfolio de Yann Locatelli

<details>
<summary>Setup</summary>

Configurer IAM sur Google Cloud

- Administrateur Firebase App Check
- Administrateur Firebase Hosting
- Administrateur Storage
- Agent du service administrateur le SDK Admin Firebase
- Créateur de jetons du compte de service
- Éditeur

Télécharger clé dans le Compte de Service (format .json)

Dans Github -> Repository -> Secrets -> Actions -> Repository secrets, ajouter le contenu du .json

## Firestore

Lancer une seule fois

``` sh
docker build -t firebase-storage-cors ./scripts/setup_firebase_web

docker run --rm \
  -e PROJECT_ID=portfolio-76903 \
  -e BUCKET_NAME=portfolio-76903.firebasestorage.app \
  -v "$(pwd)/secrets/portfolio-76903-3d6de65300e1.json:/key.json:ro" \
  firebase-storage-cors
```

</details>
