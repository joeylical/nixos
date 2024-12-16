{ specialArgs, ... }:

{
  imports = [
    ./de
    ./load_default.nix
  ];

  home.sessionVariables = {
    # XDG_CONFIG_DIRS = "/home/${specialArgs.userName}/.config/";
    NIXOS_OZONE_WL = "1";
    XMODIFIERS="@im=fcitx";
  };
}
