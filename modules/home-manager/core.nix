{ config, pkgs, lib, ... }: {
  home = {
    username = "ant";
    homeDirectory = "/Users/ant";

    stateVersion = "22.11";

     packages = with pkgs; [
      # ansible
      # coreutils
      discord
      # element-desktop
      # git-crypt
      # gnused TODO figure out how to install as gsed (homebrew?)
      # gopass
      # iterm2
      # jetbrains.goland
      # jetbrains.idea-community
      kubectl
      kubectx
      # kubelogin
      # kubernetes-helm-wrapped
      # pgadmin4
      postman
      # slack
      unar
      zlib
    ];
  };

  programs = {
    home-manager.enable = true;

    bat.enable = true;
    exa.enable = true;
    vim.enable = true;

    # TODO explore more
    # direnv.enable = true;
    # firefox.enable = true;
    # go.enable = true;

    # gnupg.enable = true;
    # jq.enable = true;
    
    # ## compare
    # htop.enable = true;
    # btm.enable = true;
  };
}
