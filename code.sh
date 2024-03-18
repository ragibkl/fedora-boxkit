#!/usr/bin/env bash

ID=$(echo -n ${CONTAINER_ID:-default} | od -An -t x1 | tr -d ' ' | cat)

if [ -z "$1" ]; then
    distrobox-host-exec code --folder-uri vscode-remote://attached-container+${ID}
else
    DIR=$(pwd)/$1
    distrobox-host-exec code --folder-uri vscode-remote://attached-container+${ID}/$DIR
fi
