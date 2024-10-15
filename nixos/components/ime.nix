{ config, pkgs, ... }:
{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-rime
          fcitx5-chinese-addons
          libsForQt5.fcitx5-qt
        ];
      };
    };
  };
}
