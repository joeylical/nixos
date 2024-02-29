{config, pkgs, lib, ... }:

let
  inherit (import ../config.nix) userName;

  blinkConfig = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
    --enable-wayland-ime
    --gtk-version=4
  '';
in
{
  imports = [
    ./de
    ./load_default.nix
  ];

  home.file = {
    ".config/chromium-flags.conf".text = blinkConfig;
    ".config/electron25-flags.conf".text = blinkConfig;
  };

  home.sessionVariables = {
    # XDG_CONFIG_DIRS = "/home/${userName}/.config/";
    NIXOS_OZONE_WL = "1";
  };
}
