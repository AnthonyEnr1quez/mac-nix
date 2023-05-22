{ config, pkgs, lib, ... }: {
  hm = {
    imports = [ ./apps.nix ];

    home.packages = with pkgs; [
      discord
    ];
  };
}
