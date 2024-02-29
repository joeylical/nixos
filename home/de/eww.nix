{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./eww;
  };
  
  # xdg.configFile."eww".source = ./eww;
  # xdg.configFile."eww".recursive = true;
  # xdg.configFile."eww".enable = true;
}
