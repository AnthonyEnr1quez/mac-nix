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
      installBatSyntax = false; #TODO

      settings = {
        auto-update = "off";
        clipboard-trim-trailing-spaces = true;
        font-family = "Hack Nerd Font";
        window-title-font-family = "Hack Nerd Font";
        font-size = 18;

        macos-option-as-alt = true;
        quit-after-last-window-closed = true;
        scrollback-limit = 10000;

        theme = "catppuccin-mocha";

        # does not work with full screen apps :(
        keybind = "global:alt+space=toggle_quick_terminal";
        quick-terminal-position = "right";
        quick-terminal-animation-duration = 0;
        quick-terminal-autohide = false;
      };
    };
  };
}
