{ lib, specialArgs, ... }:

{
  imports = [
    ./shell
    ./neovim
    ./scripts
    ./load_default.nix
    ./DE.nix
  ];

  programs.home-manager.enable = true;

  home.username = specialArgs.userName;
  home.homeDirectory = lib.mkForce "/home/${specialArgs.userName}";

  home.packages = [
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

