{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    cowsay
    neofetch
  ];
}