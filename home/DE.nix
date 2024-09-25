{config, pkgs, lib, ... }:

let
  inherit (import ../config.nix) userName;

in
{
  imports = [
    ./de
    ./load_default.nix
  ];

  home.sessionVariables = {
    # XDG_CONFIG_DIRS = "/home/${userName}/.config/";
    NIXOS_OZONE_WL = "1";
    XMODIFIERS="@im=fcitx";
  };
}
