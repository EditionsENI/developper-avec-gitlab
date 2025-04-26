# Chapitre 3

Ce fichier rassemble les commandes Git abordées dans le chapitre 3.

## Commandes

### Configuration et initialisation de Git

- Faire afficher la version de Git :

```bash
git --version
```

- Configurer le nom d'utilisateur de Git :

```bash
git config --global user.name "Prénom Nom"                 
```

- Ajouter le mail de l'utilisateur de Git :

```bash
git config --global user.email " mon_mail@it-connect.com"
```

- Initialiser un dépôt Git

```bash
git init
```

### Le workflow Git

- Déplacer un (ou plusieurs) fichier(s) ou modifications dans l'espace de staging :

```bash
# 1 fichier dans l'espace de travail
git add "<nom_fichier>" 

# Tous les fichiers de l'espace de travail
git add  .
git add -A   
```

- Faire afficher le statut des fichiers dans Git :

```bash
git status    
```

- Créer un snapshot des changements (contenu de l'espace de staging) et les conserver dans la base de données /.git :

```bash
git commit -m "<message>"

# Combiner git add et git commit
git commit -am "<message>"    
```

- Faire afficher les changements entre le répertoire de travail et l'espace de staging :

```bash
git diff      
```

- Retirer les fichiers ou modifications de l'espace de staging :

```bash
git reset     
```

- Supprimer les fichiers ou modifications de l’espace de staging et du répertoire de travail :

```bash
git rm 
```

- Faire afficher l'information sur les derniers commits

```bash
git log
```

- Restaurer un commit antérieur (version antérieure du dépôt) :

```bash
git reset --hard <hash du commit>
```

- Supprimer le dernier commit avec justification :

```bash
git revert —e HEAD
```

- Supprimer l'avant dernier commit avec justification :

```bash
git revert —e HEAD~1
```

- Supprimer un commit à partir de son hash avec justification :

```bash
git revert -e <hash du commit>
```

- Supprimer le dernier commit sans justification :

```bash
git revert —n HEAD
```

- Supprimer l'avant dernier commit sans justification :

```bash
git revert —n HEAD~1
```

- Supprimer un commit à partir de son hash sans justification :

```bash
git revert —n 
```

- Faire afficher l'historique des derniers commits :

```bash
git show
```

### Travailler avec les branches dans Git

```bash
- Faire afficher les branches :
git branch
```

- Créer une nouvelle branche :

```bash
git branch <nom_branche>                   
```

- Créer une nouvelle branche et se déplacer dessus en même temps :

```bash
git checkout -b <nom_branche>
```

- Se déplacer sur une autre branche :

```bash
git checkout <nom_branche>
```

- Supprimer une branche :

```bash
git branch -d <nom_branche>
```

### Les fusions ou merge dans Git

- Fusionner une branche avec la branche en cours ("fast-forward merge" ou "three-way merge") :

```bash
git merge <nom_branche> 
```

- Fusionner une branche avec la branche en cours sans conserver l'historique de la branche secondaire ("squash and merge") :

```bash
git merge --squash <nom_branche> 

# suivi de :
git commit —m "<message>" 
```

- Réappliquer les commits d'une branche sur une autre (rebase) :

```bash
git rebase <nom_branche_cible>

# pour fusionner après : 
git merge
```
