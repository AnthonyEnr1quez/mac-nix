{ pkgs, ... }: {
  temp = import ./tmp.nix { inherit pkgs; };
  mf = import ./mf { inherit pkgs; };
}