{ pkgs, ... }: {
  imports = [
    ./core.nix
    ./brew.nix
  ];
}