{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

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
