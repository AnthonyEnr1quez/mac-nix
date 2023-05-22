# Source: https://github.com/Atemu/home-manager/blob/e6d905336181ed8f98d48a1f6c9965b77f18e304/modules/targets/darwin.nix
# Ref: https://github.com/LnL7/nix-darwin/issues/214
# Ref: https://github.com/nix-community/home-manager/issues/1341
# Ref: https://github.com/nix-community/home-manager/issues/1341#issuecomment-1301534516
# Ref (using aliases instead): https://github.com/midchildan/dotfiles/blob/472258f8f07b81829c87baf69d7fcf4294cf1aab/home/modules/linkapps.nix
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
    # Install MacOS applications to the user environment.
    HM_APPS="$HOME/Applications/Home Manager Apps"

    # Reset current state
    [ -e "$HM_APPS" ] && $DRY_RUN_CMD rm -r "$HM_APPS"
    $DRY_RUN_CMD mkdir -p "$HM_APPS"

    # .app dirs need to be actual directories for Finder to detect them as Apps.
    # In the env of Apps we build, the .apps are symlinks. We pass all of them as
    # arguments to cp and make it dereference those using -H
    $DRY_RUN_CMD cp --archive -H --dereference ${appEnv}/Applications/* "$HM_APPS"
    $DRY_RUN_CMD chmod +w -R "$HM_APPS"
  '';
}
