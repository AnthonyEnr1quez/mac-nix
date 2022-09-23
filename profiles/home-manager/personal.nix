{ config, lib, pkgs, ... }: {
  ## TODO, there has to be a cleaner way
  home.packages = 
    # if (config.networking.hostname == "nixos") then
    # macbook
    if pkgs.stdenvNoCC.isDarwin then
      with pkgs; [
        discord
        postman
      ]
    #wsl
    else
      with pkgs; [
        htop
        neofetch
      ];

  programs.git = {
    userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
    userName = "AnthonyEnr1quez";
  };

  home.file = lib.mkIf (pkgs.stdenvNoCC.isLinux) {
    ".vscode-server/server-env-setup".source = ../../modules/nixos/server-env-setup;
  };
}
