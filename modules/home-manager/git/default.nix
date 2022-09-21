{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
    userName = "AnthonyEnr1quez";

    difftastic.enable = true;

    extraConfig = {
      core = {
        editor = "vim";
      };
    };

    ignores = [
      ".DS_STORE"
    ];
  };
}
