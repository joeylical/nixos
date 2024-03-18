{ pkgs, ... }:
{
  home.packages =with pkgs; [
    p7zip
    peazip
    firefox-wayland
    ydict
    mpv   
    vlc
    qalculate-qt
    chromium
    obsidian
    rhythmbox
    audacious
    audacious-plugins
    gthumb
    stellarium
    go-musicfox
    koreader
    # onlyoffice-bin
    # wpsoffice
    onedrivegui
    spotify-qt
    thunderbird-bin

    sqlitebrowser
    jetbrains.pycharm-community
    jetbrains.idea-community

    dfeet
    openai-whisper-cpp
    yt-dlp
    ffmpeg
    playerctl

    foliate

    android-tools
    scrcpy

    mongodb-compass
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };
}
