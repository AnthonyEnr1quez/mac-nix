{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    difftastic.enable = true;

    extraConfig = {
      core = {
        editor = "vim";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = toString (pkgs.writeText "allowed_signers" "");
      };
    };

    signing = {
      key = "~/.ssh/id_ed25519_github.pub";
      signByDefault = true;
    };

    ignores = [
      ".DS_STORE"
    ];
  };
}
