{ host, config, pkgs, lib, ... }: {
  hm = {
    home = {

      packages = with pkgs; [
        htop
        neofetch
        cowsay
      ];

      # TODO for settings file too?
      activation.installExtensions = with lib.hm.dag.entryAfter [ "writeBoundary" ]; ''
        if [ -L /home/ant/.vscode-server/extensions ] ; then
            rm -r /home/ant/.vscode-server/extensions
        fi
        ln -s /home/ant/.vscode/extensions /home/ant/.vscode-server
      '';

    };

    programs.vscode.package = pkgs.vscode;

    # wont bind correctly through hm setting
    programs.zsh.initExtra = ''
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down
    '';
  };
}
