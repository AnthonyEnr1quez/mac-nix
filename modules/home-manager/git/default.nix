{ config, pkgs, ... }: {
  programs.git = {
    enable = true;

    difftastic.enable = true;

    extraConfig = {
      commit = {
        gpgSign = true;
      };
      core = {
        editor = "vim --nofork";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = toString (pkgs.writeText "allowed_signers" "");
      };
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };

    signing = {
      key = "~/.ssh/id_ed25519_github.pub";
    };

    ignores = [
      ".DS_STORE"
    ];

    aliases = {
      main-branch = "!git symbolic-ref refs/remotes/origin/HEAD | cut -d '/' -f3,4";
      com = "!f(){ git checkout $(git main-branch) $@;}; f";
    };
  };
}
