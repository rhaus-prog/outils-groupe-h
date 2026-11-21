# Extrait le texte d'un PDF page par page (reperes "=== PAGE n ===").
# Usage : python3 -I extraire_pdf.py fichier.pdf sortie.txt
# Contourne la limite du connecteur Drive (10 Mo, texte tronque) : copier d'abord
# le PDF en local, puis le lire ici. Ne lit que le texte (pas les images).
# Prerequis : pip install --user pypdf (voir install.sh)
import os, sys
sys.path += [p for p in (os.path.join(os.environ.get('APPDATA', ''), 'Python', 'Python312', 'site-packages'), os.path.expanduser('~/.local/lib/python3.12/site-packages')) if os.path.isdir(p)]
from pypdf import PdfReader
def txt(p): return p.extract_text() or ''
src, dst = sys.argv[1], sys.argv[2]
r = PdfReader(src)
open(dst, 'w', encoding='utf-8').write(''.join('\n=== PAGE %d ===\n%s\n' % (i, txt(p)) for i, p in enumerate(r.pages, 1)))
print(os.path.basename(src), len(r.pages), 'pages ->', dst)
