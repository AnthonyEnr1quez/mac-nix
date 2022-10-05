{ config, pkgs, ... }: {
  imports = [ ./apps.nix ];

  hm = {
    home.packages = with pkgs; [
      discord
      postman
    ];
  };
}
