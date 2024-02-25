{ pkgs, ... }:

let
  inherit (import ../../config.nix) userName;
in
{
  
  services.xserver.displayManager.autoLogin.user = userName;
  services.xserver.displayManager.sddm.settings.AutoLogin.User = userName;
}
