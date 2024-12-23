{ config, pkgs, ... }: {
  catppuccin = {
    flavor = "mocha";

    bat.enable = true;
    fzf.enable = true;
    # k9s.enable = true; # TODO
    kitty.enable = true;
  };
}
