{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    # package = pkgs.steam.override {
    #  # withPrimus = true;
    #  withJava = true;
    #  # extraPkgs = pkgs: [ bumblebee glxinfo ];
    # };
    extest.enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "-pipewire-dmabuf"
      "-tenfoot"
    ];
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--adaptive-sync" # VRR support
      # "--mangoapp" # performance overlay
      "--rt"
      "--steam"
    ];
  };

  # programs.java.enable = true; 

  environment.systemPackages = with pkgs; [
    mangohud
    wine-wayland
    winetricks
    steam-run
  ];
}

