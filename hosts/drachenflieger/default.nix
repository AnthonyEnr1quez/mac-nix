{ config, pkgs, lib, ... }: {
  hm = {
    imports = [ ./apps.nix ];

    home.packages = with pkgs; [
      discord
      postman
    ];

    programs.vscode.package = pkgs.vscodium;
  };
}
