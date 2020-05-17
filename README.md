This repository contains a set of dotfiles for nvim, neovim-qt and tmux.
Suppoerted OS: Ubuntu


# Usage

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

## Build docker container with dev environment
```sh
cd
git clone git@github.com:f-squirrel/scripts.git
cd scripts/deployment
docker build -f ./Dockerfile . -t dep:latest
```
