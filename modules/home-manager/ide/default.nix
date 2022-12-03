{ config, pkgs, ... }: {
  # TODO default dummy sha: AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
  programs.vscode = {
    enable = true;

    userSettings = {
      "workbench.colorTheme" = "Owlet (Default)";
      "files.autoSave" = "afterDelay";
      "editor.fontSize" = 14;
      "editor.tabSize" = 2;
      "diffEditor.ignoreTrimWhitespace" = false;
      "update.mode" = "none";
    };

    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      golang.go
      mkhl.direnv
      _2gua.rainbow-brackets
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
      {
        name = "astro-vscode";
        publisher = "astro-build";
        version = "0.28.0";
        sha256 =  "ff4VcgLtaDu8pM2Y+HvvJRxcgsy78T2CILarUMqyuJ0=";
      }
    ];
  };
}
