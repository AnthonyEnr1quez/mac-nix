{ config, pkgs, ... }: {
  catppuccin.flavor = "mocha";

  # todo, probably should be where we enable these
  programs = {
    bat.catppuccin.enable = true;
    fzf.catppuccin.enable = true;
    # k9s.catppuccin.enable = true;
    kitty.catppuccin.enable = true;
  };
}
