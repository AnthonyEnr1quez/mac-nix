{ host, config, pkgs, ... }: {
  hm = {
    home = {
      file = { ".vscode-server/server-env-setup".source = ./server-env-setup; };

      packages = with pkgs; [
        htop
        neofetch
        cowsay
      ];
    };

    # wont bind correctly through hm setting
    programs.zsh.initExtra = ''
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down
    '';
  };
}
