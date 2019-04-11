#!/bin/bash

key=$(dirname "$0")/ssh/id_ed25519
if [[ ! -f "$key" ]]; then
ssh-keygen -t ed25519 -N '' -f "$key"
fi
ssh-add "$key"
