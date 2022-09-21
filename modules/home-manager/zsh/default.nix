{ config, pkgs, ... }: {
  # see also https://github.com/Yumasi/nixos-home/blob/master/zsh.nix#L89
  home.file = {
    ".config/zsh/zsh_abbr".source = ./zsh_abbr;
  };

  programs.zsh = {
    enable = true;

    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      path = "/Users/ant/.config/zsh/zsh_history";
      save = 100000;
      size = 100000;
      share = true;
    };
    historySubstringSearch = {
      enable = true;
    };

    initExtra = builtins.readFile ./zshrc_extra;

    sessionVariables = {
      ABBR_USER_ABBREVIATIONS_FILE = "/Users/ant/.config/zsh/zsh_abbr";
    };

    shellAliases = {
      # https://github.com/ibraheemdev/modern-unix
      cat = "bat";
      ls= "exa -1";
    };

    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
      "......" = "../../../../..";
    };

    plugins = [
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
      }
      {
        name = "zsh-abbr";
        src = pkgs.fetchFromGitHub {
          owner = "olets";
          repo = "zsh-abbr";
          rev = "v4.8.0";
          sha256 = "diitszKbu530zXbJx4xmfOjLsITE9ucmWdsz9VTXsKg=";
        };
        file = "zsh-abbr.plugin.zsh";
      }
      {
        name = "sudo";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "plugins/sudo/sudo.plugin.zsh";
      }
      {
        name = "git";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/git.zsh";
      }
      {
        name = "prompt_info_functions";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/prompt_info_functions.zsh";
      }
      {
        name = "theme-and-appearance";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "lib/theme-and-appearance.zsh";
      }
      {
        name = "crunch";
        src = pkgs.fetchFromGitHub {
          owner = "ohmyzsh";
          repo = "ohmyzsh";
          rev = "7dcabbe6826073ef6069c8a4b6f9a943f00d2df0";
          sha256 = "Mk2GQh7Yh0cyklSEIutIIUEQNMAcPC1i3QT5K6lCEt8=";
        };
        file = "themes/crunch.zsh-theme";
      }
      # TODO
      # {
      #   name = "kube-ps1 ";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "jonmosco";
      #     repo = "kube-ps1 ";
      #     rev = "c432ec18b81a03cff835678298650dca74731945";
      #     sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      #   };
      #   file = "kube-ps1.sh";
      # }
    ];
  };
}
