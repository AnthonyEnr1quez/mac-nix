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
      pull.ff = "only";
      push.autoSetupRemote = true;
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
