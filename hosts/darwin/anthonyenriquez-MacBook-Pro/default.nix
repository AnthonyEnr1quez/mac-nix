{ config, pkgs, lib, ... }: {
  hm = {
    home.packages = with pkgs; [
      cowsay
    ];

    programs.zsh = {
      profileExtra = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };

  homebrew = {
    casks = [
      "notion"
      "linear-linear"
    ];
  };
}
