{ pkgs, ... }: {
  imports = [
    ./firefox
    ./git
    ./ide
    ./k9s
    ./kitty
    ./langs
    ./ssh
    ./zsh
  ];

  home = {
    stateVersion = "24.05";

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
    eza.enable = true;
    vim.enable = true;

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    fd.enable = true;

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
