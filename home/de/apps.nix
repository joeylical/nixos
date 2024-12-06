{ pkgs, ... }:
{
  home.packages =with pkgs; [
    p7zip
    # peazip
    firefox-wayland
    ydict
    mpv   
    vlc
    qalculate-qt
    (chromium.override {
      commandLineArgs = [
        "--enable-wayland-ime"
        "--enable-features=VaapiVideoDecodeLinuxGL"
      ];
    })
    obsidian
    rhythmbox
    audacious
    audacious-plugins
    gthumb
    stellarium
    go-musicfox
    # youtube-music
    koreader
    onlyoffice-bin
    # wpsoffice
    # onedrivegui
    spotify-qt
    thunderbird-bin

    sqlitebrowser
    jetbrains.pycharm-community
    jetbrains.idea-community

    d-spy
    openai-whisper-cpp
    playerctl

    foliate

    android-tools
    scrcpy

    mongodb-compass

    hyprshade

    zotero_7

    onedriver

    quickemu
    qemu

    cliphist
  ];

  home.file.".config/hypr/hyprshade.toml".text = ''
    [[shades]]
    name = "blue-light-filter"
    start_time = 21:00:00
    end_time = 07:00:00   # optional if you have more than one shade with start_time
  '';
  home.file.".config/hypr/shaders/blue-light-filter.glsl".source =
    "${pkgs.hyprshade.outPath}/share/hyprshade/shaders/blue-light-filter.glsl";
  

  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override{
      commandLineArgs = "--enable-wayland-ime";
    }).fhs;
  };
}
