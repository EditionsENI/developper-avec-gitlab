import pytest
from exemple_python.password_gen import generer_mot_de_passe

# Test du bon fonctionnement avec une longueur valide
def test_longueur_mot_de_passe():
    mdp = generer_mot_de_passe(12)  # Test avec une longueur de 12 caractères
    assert isinstance(mdp, str)  # Vérifie que le mot de passe est une chaîne
    assert len(mdp) == 12  # Vérifie que la longueur est correcte

# Test avec une entrée invalide (chaîne de caractères au lieu d’un entier)
def test_entree_non_numerique():
    with pytest.raises(TypeError):  # Vérifie que la fonction lève une erreur
        generer_mot_de_passe("abc")  # Passage d'une chaîne au lieu d'un entier

# Test avec une longueur excessive
def test_longueur_trop_grande():
    mdp = generer_mot_de_passe(1000)  # Demande un mot de passe de 1000 caractères
    assert isinstance(mdp, str)  # Vérifie que le mot de passe est une chaîne
    assert len(mdp) == 1000  # Vérifie que la longueur demandée est bien respectée
