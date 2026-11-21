#!/usr/bin/env bash
# Tetofeed — Plymouth Boot Splash — install.  ./install.sh
set -euo pipefail
HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
DST=/usr/share/plymouth/themes/tetofeed
[[ $EUID -eq 0 ]] || { echo "run with sudo: sudo ./install.sh" >&2; exit 1; }
rm -rf "$DST"; mkdir -p "$DST"
cp "$HERE"/*.png "$HERE"/tetofeed.plymouth "$HERE"/tetofeed.script "$DST"/
chmod -R a+rX "$DST"
if command -v dracut >/dev/null && ! command -v mkinitcpio >/dev/null; then
    plymouth-set-default-theme tetofeed
    if command -v dracut-rebuild >/dev/null; then dracut-rebuild; else dracut -f; fi
else
    plymouth-set-default-theme -R tetofeed
fi
echo "Installed; you will see it at next boot."
