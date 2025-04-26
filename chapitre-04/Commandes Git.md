# Chapitre 4

Ce fichier rassemble les commandes Git abordées dans le chapitre 4.

## Commandes Git

### Clonage et interaction avec un dépôt distant Git

- Cloner un dépôt distant en local via SSH ou HTTPS

```bash
git clone <URL_dépôt_distant>
```
  
- Renommer et ajouter l'URL de l'alias "origin"

```bash
git remote rename origin old_origin
git remote add origin <URL_dépôt_distant>
```
  
- Configurer " origin " pour recevoir le contenu et les tags d'un dépôt local

```bash
git push --set-upstream origin --all
git push --set-upstream origin --tags 
```

- Faire afficher "origin" :

```bash
git remote show origin
```

### Opérations push et pull dans Git

- Envoyer les modifications d'un dépôt local vers un dépôt distant :

```bash
git push
```

- Récupérer les derniers commits d'un dépôt distant :

```bash
git fetch
```
  
- Faire afficher les changements d'un commit

```bash
git show <hash_du_commit>
```

- Fusionner le contenu du dépôt distant (après un git fetch) :

```bash
git merge origin/main
```
  
- Mettre à jour un dépôt local à partir d'un dépôt distant :

```bash
git pull
```

### Créer des étiquettes (tags) Git

- Créer une étiquette annotée :

```bash
git tag —a <nom_tag> —m "<message>"
```

- Créer une étiquette légère :

```bash
git tag <nom_tag>
```
  
- Envoyer les tags vers un dépôt distant :

```bash
git push --tags
```
