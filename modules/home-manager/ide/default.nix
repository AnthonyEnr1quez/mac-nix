{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.colorTheme" = "Owlet (Default)";
      "files.autoSave" = "afterDelay";
      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      "diffEditor.ignoreTrimWhitespace" = false;
      "update.mode" = "none";
      "redhat.telemetry.enabled" = false;
    };

    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      golang.go
      mkhl.direnv
      _2gua.rainbow-brackets
      astro-build.astro-vscode
      ms-kubernetes-tools.vscode-kubernetes-tools
      redhat.vscode-yaml
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-eclipse-keybindings";
        publisher = "alphabotsec";
        version = "0.16.1";
        sha256 = "VK4OS7fvpJsHracfHdC7blvh6qV0IJse4vdRud/yT/o=";
      }
      {
        name = "owlet";
        publisher = "itsjonq";
        version = "0.1.22";
        sha256 = "LUlMX8HAw/34PGQEAwI0y4K0pJ1nilv2oVycC7+zeR4=";
      }
      {
        name = "vscode-json5";
        publisher = "mrmlnc";
        version = "1.0.0";
        sha256 = "XJmlUuKiAWqzvT7tawVY5NHsnUL+hsAjJbrcmxDe8C0=";
      }
    ];
  };
}
