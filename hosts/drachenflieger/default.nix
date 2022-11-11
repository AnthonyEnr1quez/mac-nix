{ config, pkgs, lib, ... }: {
  hm = {
    imports = [ ./apps.nix ../../modules/home-manager/kitty ];

    home.packages = with pkgs; [
      discord
      postman
    ];

    programs.vscode = {
      package = pkgs.vscodium;

      userSettings."editor.fontFamily" = "Hack Nerd Font Mono";
    };

  };
}
