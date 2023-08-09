{ pkgs, ... }: {
  imports = [
    ./git
    ./ide
    ./ssh
    ./zsh
  ];

  home = {
    stateVersion = "23.05";

    packages = with pkgs; [
      # ansible
      # coreutils
      # cachix
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

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    # TODO explore more
    # firefox.enable = true;
    # go.enable = true;

    # gnupg.enable = true;
    # jq.enable = true;

    # ## compare
    # htop.enable = true;
    # btm.enable = true;
  };
}
