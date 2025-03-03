# Créer un nouveau répertoire et se déplacer dedans
mkdir -p /usr/local/bin/nom_repertoire && cd /usr/local/bin/nom_repertoire

# Récupérer le binaire de GitLab Runner
curl -L --output gitlab-runner.exe https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe

# Rendre le fichier exécutable
chmod +x gitlab-runner.exe

# Démarrer le GitLab Runner
gitlab-runner.exe start

# Vérifier le statut du Gitlab Runner
gitlab-runner.exe status

# Enregistrer le GitLab Runner
./gitlab-runner.exe register --url https://gitlab.com --token glrt-xxxxxxxxxxx