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
    gamescopeSession = {
      enable = true;
      args = [
        # "-pipewire-dmabuf"
        # "-tenfoot"
        "--expose-wayland"
        "-h 720 -H 1440 -F fsr"
      ];
    };
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
    (pkgs.writeTextDir "share/applications/steam_gamescope.desktop" ''
        [Desktop Entry]
        Version=1.0
        Name=Steam(gamescope)
        Comment=Steam Within Gamescope
        Exec=steam-gamescope
        Icon=steam
        Terminal=false
        Type=Application
      '')
    mangohud
    wine-wayland
    winetricks
    steam-run
  ];
}

