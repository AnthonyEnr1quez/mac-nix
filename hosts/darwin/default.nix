{ host, config, pkgs, lib, ... }: {
  host.name = host;

  imports = [ ./${host} ];

  hm = {
    imports = [ ../../modules/home-manager/kitty ./apps.nix ];

    disabledModules = [ "targets/darwin/linkapps.nix" ];

    programs.vscode = {
      package = pkgs.vscodium;

      userSettings."editor.fontFamily" = "Hack Nerd Font Mono";
    };
  };
}
