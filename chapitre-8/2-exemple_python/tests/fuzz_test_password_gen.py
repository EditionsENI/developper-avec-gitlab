import os
import sys
import atheris

# Ajoute le chemin du répertoire racine du projet
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from exemple_python.password_gen import generer_mot_de_passe

def TestOneInput(data):
    try:
        longueur = min(int(data) if data.isdigit() else len(data), 100)  # Limiter à 100 caractères max
        generer_mot_de_passe(longueur)
    except Exception as e:
        print(f"Exception: {e}")

def main():
    atheris.Setup(sys.argv, TestOneInput, enable_python_coverage=True)  # Activer la couverture Python
    atheris.Fuzz()

if __name__ == "__main__":
    main()
