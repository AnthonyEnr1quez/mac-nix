{ config, pkgs, ... }: {
  imports = [
    ./core.nix
    ./programs/git.nix
  ];
}