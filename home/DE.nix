{ lib, specialArgs, ... }:

if specialArgs.desktop_env then {
  imports = [
    ./de
  ];

  home.sessionVariables = {
    # XDG_CONFIG_DIRS = "/home/${specialArgs.userName}/.config/";
    NIXOS_OZONE_WL = "1";
    XMODIFIERS="@im=fcitx";
    ADW_DISABLE_PORTAL = "1";
  };
} else {}
