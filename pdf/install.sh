#!/usr/bin/env bash
# Installe pypdf (lecture du texte des PDF) pour l'utilisateur courant.
# Sous Windows (PowerShell) : python -m pip install --user pypdf
python3 -m pip install --user --break-system-packages pypdf || python3 -m pip install --user pypdf
echo "Usage : python3 -I extraire_pdf.py fichier.pdf sortie.txt"
