{ pkgs, ... }:

let
  inherit (import ../../config.nix) userName;
in
{
  
  services.displayManager.autoLogin.user = userName;
  services.displayManager.sddm.settings.AutoLogin.User = userName;
}
