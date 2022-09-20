{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
    userName = "AnthonyEnr1quez";

    difftastic.enable = true;

    ignores = [
      ".DS_STORE"
    ];
  };
}
