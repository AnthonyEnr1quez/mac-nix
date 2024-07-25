{ host, config, pkgs, lib, ... }: {
  hm = {
    home = {

      packages = with pkgs; [
        htop
        neofetch
        cowsay
      ];

      activation.installExtensions = with lib.hm.dag.entryAfter [ "writeBoundary" ]; ''
        if [ -L /home/ant/.vscode-server/extensions ] ; then
            rm -r /home/ant/.vscode-server/extensions
        fi
        ln -s /home/ant/.vscode/extensions /home/ant/.vscode-server

        if [ -L /home/ant/.vscode-server/data/Machine/settings.json ] ; then
            rm -r /home/ant/.vscode-server/data/Machine/settings.json
        fi
        ln -s /home/ant/.config/Code/User/settings.json /home/ant/.vscode-server/data/Machine/settings.json
      '';

    };

    programs.vscode = {
      package = pkgs.vscode;

      userSettings."editor.fontFamily" = "Hack";
    };

    # wont bind correctly through hm setting
    programs.zsh.initExtra = ''
      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down
    '';

    programs.go = {
        enable = true;
        package = pkgs.go_1_22.overrideAttrs (_: rec {
          version = "1.22.5";
          src = pkgs.fetchurl {
            url = "https://go.dev/dl/go${version}.src.tar.gz";
            hash = "sha256-rJxyPyJJaa7mJLw0/TTJ4T8qIS11xxyAfeZEu0bhEvY=";
          };
        });
        goPath = "go";
        goPrivate = [ "github.com/moov-io/*" "github.com/moovfinancial/*" ];
      };
  };
}
