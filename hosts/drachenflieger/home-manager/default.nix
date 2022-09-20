{ config, pkgs, ... }: {
  imports = [
    ./core.nix
    ./apps.nix
    ./git
    ./ide
    ./ssh
    ./zsh
  ];
}
