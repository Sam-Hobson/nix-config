# This is my nix config!

Make sure to have `nix` and `home-manager` installed.

To get started, clone my `.dotfiles` and `nix-config` configurations:
```sh
nix-shell -p git --run '
  cd ~ &&
  git clone git@github.com:Sam-Hobson/.dotfiles.git &&
  git clone git@github.com:Sam-Hobson/nix-config.git
'
```

To use the nix configuration, do:
```sh
cd ~/nix-config/

sudo nixos-rebuild switch --upgrade --flake .

nix flake update

home-manager switch --flake .
```
