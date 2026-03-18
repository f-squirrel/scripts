#!/usr/bin/env bash
if git diff --quiet; then
    echo "No changes." | less -R
else
    git diff | delta --width "$(tput cols)" | less -R
fi
