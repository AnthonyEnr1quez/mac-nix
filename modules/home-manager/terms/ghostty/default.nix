{ lib, config, pkgs, ... }:
let
  name = "ghostty";
in
let
  cfg = config.${name};

  inherit (lib) mkIf mkEnableOption;
in
{
  options.${name} = {
    enable = mkEnableOption name;
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        theme = "catppuccin-mocha";
        font-size = 18;
      };
    };
  };
}
