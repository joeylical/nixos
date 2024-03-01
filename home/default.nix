{ config, pkgs, lib, environment, specialArgs, ... }:

let
  inherit (import ../config.nix) userName;
in
{
  imports = [
    ./shell
    ./neovim
    ./scripts
  ] ++ (if specialArgs.desktop_env then [
    ./DE.nix
  ] else []);

  programs.home-manager.enable = true;

  home.username = userName;
  home.homeDirectory = lib.mkForce "/home/${userName}";

  home.packages =with pkgs; [
  ];


  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "C.UTF-8";
  };

  systemd.user.sessionVariables = {
    LANG = "C.UTF-8";
    # XDG_DATA_HOME   = "$HOME/.local/share";
  };

  programs.git = {
    enable = true;
    userName = "Joey Li";
    userEmail = "ljyhd2024@gmail.com";
  };

  home.stateVersion = "23.11"; # Please read the comment before changing.
}

