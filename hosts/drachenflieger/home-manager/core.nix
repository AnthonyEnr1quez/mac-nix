{ config, pkgs, lib, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ant";
  home.homeDirectory = "/Users/ant";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.exa.enable = true;

  ## lets add some packages
  home.packages = with pkgs; [
    bottom
    git
    bat
    # bash ?
    # coreutils ?
    # gawk
    # htop
    # gnu-sed
    # zlib
    go_1_19


    unar
    postman
    # jetbrains.idea-community
    # docker
    #postman, enable unfree
    discord
    #element-desktop
    #slack
    # jetbrains.goland

    kubectl
    # kubelogin
    # kubectx - manage with zsh?
    # kubernetes-helm-wrapped?
    # git-crypt
    #gnupg
    #gopass
    #postgresql
    #pgadmin4
    #iterm2 - do I need it?
  ];
}
