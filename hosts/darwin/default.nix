{ host, config, pkgs, lib, ... }: {
  host.name = host;

  imports = [ ./${host} ];

  hm = {
    imports = [
      ../../modules/home-manager/kitty
      ../../modules/home-manager/catppuccin
    ];

    firefox-dev = {
      enable = true;
    };

    programs.vscode = {
      package = pkgs.vscodium;

      userSettings."editor.fontFamily" = "Hack Nerd Font Mono";
    };

    programs.zsh.profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
