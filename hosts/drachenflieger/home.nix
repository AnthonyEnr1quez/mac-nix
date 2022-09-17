{ config, pkgs, ... }: ### This is home manager config

{
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

  ## lets add some packages
  home.packages = with pkgs; [
    bottom
    git
    bat
  ];

  ## git config
  programs.git = {
    enable = true;
    userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
    userName = "AnthonyEnr1quez";
  };

  ## ssh
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519_github
    '';
  };
}