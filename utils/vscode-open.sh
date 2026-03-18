#!/usr/bin/env bash
if [ -d .devcontainer ]; then
    devcontainer open .
else
    code .
fi
