{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    difftastic.enable = true;

    extraConfig = {
      core = {
        editor = "vim";
      };
      commit.gpgSign = true;
      gpg = {
        format = "ssh";
        ssh.defaultKeyCommand = "ssh-add -L";
        ssh.allowedSignersFile = toString (pkgs.writeText "allowed_signers" ''
        '');
      };
      user.signingkey = "~/.ssh/id_ed25519_github.pub";
    };

    ignores = [
      ".DS_STORE"
    ];
  };
}
