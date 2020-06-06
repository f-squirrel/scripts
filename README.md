This repository contains a set of dotfiles for nvim, neovim-qt and tmux.

Supported OS: Ubuntu, macOS


# Installation

## Dev station

```sh
cd
curl -O https://raw.githubusercontent.com/f-squirrel/scripts/master/deployment/bootstrap.sh
sudo bash ./bootstrap.sh -b master -l
```

## Remote dev station

```sh
cd
curl -O https://raw.githubusercontent.com/f-squirrel/scripts/master/deployment/bootstrap.sh
sudo bash ./bootstrap.sh -b master -r
```

## Docker image
### Pull docker image with dev environment
```sh
docker pull fsquirrel/dev_env:latest
```

### Build docker image with dev environment
```sh
docker build https://raw.githubusercontent.com/f-squirrel/scripts/master/deployment/Dockerfile -t dev_env:latest
```

# Usage

## Run locally
`gvim`

## Remote server
Run `rgvim -h` for the details
