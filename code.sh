#!/usr/bin/env bash

ID=$(echo -n ${CONTAINER_ID:-default} | od -An -t x1 | tr -d ' ' | cat)
DIR=$(pwd)/$1

distrobox-host-exec code --folder-uri vscode-remote://attached-container+${ID}/$DIR
