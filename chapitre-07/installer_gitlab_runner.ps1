# Créer un nouveau répertoire et se déplacer dedans
New-Item —Type Directory nom_repertoire
Set-Location -Path emplacement_repertoire

# Récupérer le binaire de GitLab Runner
Invoke-WebRequest -Uri " https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe" -OutFile "gitlab-runner.exe"

# Installer le GitLab Runner
.\gitlab-runner.exe install

# Démarrer le GitLab Runner
.\gitlab-runner.exe start

# Vérifier le statut du Gitlab Runner
.\gitlab-runner.exe status

# Enregistrer le GitLab Runner
.\gitlab-runner.exe register --url https://gitlab.com --token glrt-xxxxxxxxxxx