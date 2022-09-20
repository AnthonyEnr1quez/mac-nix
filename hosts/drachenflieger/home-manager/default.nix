{ config, pkgs, ... }: {
  imports = [
    ./core.nix
    ./git
    ./ide
    ./ssh
    ./zsh
  ];
}
