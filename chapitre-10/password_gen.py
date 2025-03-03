import random
import string

def generer_mot_de_passe(longueur: int = 16) -> str:
    # Lettres majuscules, minuscules et chiffres
    caracteres: str = string.ascii_letters + string.digits
    mot_de_passe: str = ''.join(random.choice(caracteres) for _ in range(longueur))
    return mot_de_passe

if __name__ == "__main__":
    longueur: int = int(input("Entrez la longueur souhaitée pour le mot de passe : "))
    print("Mot de passe généré :", generer_mot_de_passe(longueur))
