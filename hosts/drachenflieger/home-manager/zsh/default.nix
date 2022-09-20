{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 100000;
      size = 100000;
    };

    initExtra = ''
      ## TODO remove abbr and move to shell aliases? maybe
      # git
      abbr gcm="git commit -m"
      abbr gcam="git add . && git commit -m"
      abbr gf="git fetch --all"
      abbr gfo="git fetch origin && git checkout main && git rebase origin/main"
      abbr gfu="git fetch upstream && git checkout main && git rebase upstream/main"
      abbr gitpurge="git fetch --all -p; git branch -vv | grep \": gone]\" | awk \"{ print \$1 }\" | xargs -n 1 git branch -D"
      abbr gp="git push"
      abbr gpsu="git branch --show-current| xargs git push --set-upstream origin"
      abbr gs="git status -sb"

      # maven
      abbr mcc="mvn clean compile"
      abbr mci="mvn clean install"
      abbr mcp="mvn clean package -DskipTests"
      abbr mcs="mvn clean site"
      abbr mec="mvn eclipse:clean"
      abbr mee="mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true -Declipse.useProjectReferences=false -U"
      abbr mfr="mvn release:prepare -DdryRun=true"
      abbr mr="mvn release:prepare"
      abbr mrb="mvn clean eclipse:clean; mvn install -DskipTests; mvn eclipse:eclipse"
      abbr mqi="mvn clean install -DskipTests"

      # IDEA todo setup cross platform
      #abbr idea="open -na \"IntelliJ IDEA.app\" --args \"\$@\""

      # modern unix https://github.com/ibraheemdev/modern-unix
      # abbr cat="bat"
      # abbr ls="exa -1"
                              '';

    oh-my-zsh = {
      enable = true;
      theme = "crunch";
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
      # {
      #   name = "agkozak-zsh-prompt";
      #   src = fetchFromGitHub {
      #     owner = "agkozak";
      #     repo = "agkozak-zsh-prompt";
      #     rev = "v3.7.0";
      #     sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
      #   };
      #   file = "agkozak-zsh-prompt.plugin.zsh";
      # }
    ];
  };
}
