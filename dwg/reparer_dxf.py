"""Repare un DXF produit par dwg2dxf (LibreDWG 0.13.3) avant lecture avec ezdxf.

Defaut corrige : un long texte (MTEXT) est parfois coupe sur plusieurs lignes sans
code de groupe, ce qui rend le fichier illisible ("Invalid group code").
La ligne orpheline est recollee a la valeur precedente. Le dessin n'est pas modifie.

Usage : python -I reparer_dxf.py entree.dxf sortie.dxf   (sortie peut etre egale a entree)
"""
import sys


def reparer(src, dst):
    with open(src, "rb") as f:
        data = f.read()
    sep = b"\r\n" if b"\r\n" in data[:4096] else b"\n"
    lignes = data.split(sep)
    if lignes and lignes[-1] == b"":
        lignes.pop()
    sortie, i, corrigees = [], 0, 0
    while i < len(lignes):
        code = lignes[i]
        try:
            int(code.strip())
        except ValueError:
            if sortie:
                sortie[-1] += code
                corrigees += 1
            i += 1
            continue
        sortie.append(code)
        if i + 1 < len(lignes):
            sortie.append(lignes[i + 1])
        i += 2
    with open(dst, "wb") as f:
        f.write(sep.join(sortie) + sep)
    return corrigees


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("Usage : python -I reparer_dxf.py entree.dxf sortie.dxf")
    print("lignes reparees :", reparer(sys.argv[1], sys.argv[2]))
