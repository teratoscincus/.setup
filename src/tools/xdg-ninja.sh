#!/usr/bin/env bash

if command -v xdg-ninja &>/dev/null; then
    exit
fi

repo_dest="$XDG_DATA_HOME"/xdg-ninja
if [[ ! -d "$repo_dest" ]]; then
    git clone git@github.com:b3nj5m1n/xdg-ninja.git "$repo_dest"
fi

# Place executable in $PATH
wrapper="$HOME"/.local/bin/xdg-ninja

cat >"$wrapper" <<EOM
bash $repo_dest/xdg-ninja.sh  --skip-unsupported
EOM

chmod +x "$wrapper"

# Clean up
unset repo_dest wrapper
