{ pkgs, ... }: {
  temp = import ./tmp.nix { inherit pkgs; };
}