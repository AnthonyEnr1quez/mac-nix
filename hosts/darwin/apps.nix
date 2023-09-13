# Source: https://github.com/nix-community/home-manager/issues/1341#issuecomment-1714800288
# Ref: https://github.com/LnL7/nix-darwin/issues/214
{ config, lib, pkgs, ... }:
let
  appEnv = pkgs.buildEnv {
    name = "home-manager-applications";
    paths = config.home.packages;
    pathsToLink = "/Applications";
  };
in
{
  home.activation.addApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    toDir="$HOME/Applications/Home Manager Apps"
    fromDir="${appEnv}/Applications/"

    [ -e "$toDir" ] && $DRY_RUN_CMD rm -r "$toDir"
    $DRY_RUN_CMD mkdir "$toDir"

    (
      cd "$fromDir"
      for app in *.app; do
        $DRY_RUN_CMD /usr/bin/osacompile -o "$toDir/$app" -e 'do shell script "open '$fromDir/$app'"'
        icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
        $DRY_RUN_CMD mkdir -p "$toDir/$app/Contents/Resources"
        $DRY_RUN_CMD cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"
      done
    )
  '';
}
