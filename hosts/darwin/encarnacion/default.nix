{ config, pkgs, lib, ... }: {
  hm = {
    home.packages = with pkgs; [
      cowsay
    ];
  };
}
