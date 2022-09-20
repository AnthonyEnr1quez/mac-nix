{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      # alphabotsec.vscode-eclipse-keybindings   installed manually
    ];
  };
}
