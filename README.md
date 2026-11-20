# outils-groupe-h

Logiciels et scripts d'installation partages pour les sessions Claude (chat, Claude Code) du Groupe H.

## Convertisseur DWG vers DXF (LibreDWG 0.13.3)

Les sessions Claude sont privees et effacees a la fin: rien d'installe n'y survit. Ce depot garde la procedure.

Au debut d'une session qui doit lire des plans DWG:

```
git clone https://github.com/rhaus-prog/outils-groupe-h
bash outils-groupe-h/dwg/install.sh
dwg2dxf plan.dwg   # produit plan.dxf
```

Notes:
- Binaire precompile (Linux x86_64, LibreDWG 0.13.3): installation en quelques secondes, conversion d'un plan en moins d'une seconde.
- Si la machine est differente (Mac, ARM), le script compile depuis la release officielle LibreDWG (5 a 10 minutes).
- Les fichiers DXF produits se lisent ensuite avec Python (bibliotheque ezdxf).
- Ajouter ici tout autre outil, un dossier par outil, avec son install.sh.
