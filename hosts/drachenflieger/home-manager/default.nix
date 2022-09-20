{ config, pkgs, ... }: {
  imports = [
    ./core.nix
    ./git
  ];
}