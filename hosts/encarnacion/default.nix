{ config, pkgs, lib, ... }: {
  hm = {
    # imports = [ ./apps.nix ../../modules/home-manager/kitty ];
    imports = [ ../../modules/home-manager/kitty ];


    disabledModules = [ "targets/darwin/linkapps.nix" ];

    home.packages = with pkgs; [
      postman
    ];

    programs.vscode = {
      package = pkgs.vscodium;

      userSettings."editor.fontFamily" = "Hack Nerd Font Mono";
    };

  };
}
