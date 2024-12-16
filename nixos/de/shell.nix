{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wayland
    hyprland-protocols
    networkmanagerapplet
    rime-data
    xdg-utils # for opening default programs when clicking links
    cifs-utils
    wlr-randr
    swaylock-effects
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    gtk2
    gtk3
    gtk4
    wl-clipboard
    glib
    mtpfs

    wofi
    # rofi-wayland
    # dmenu-rs
    # networkmanager_dmenu
    dunst
    waybar
    hyprpaper
    wlogout
    swayidle
    swayosd
    wlsunset
    avizo
    libsForQt5.polkit-qt
    libsForQt5.polkit-kde-agent
    themechanger
    font-manager
    grim
    slurp
    libnotify
    notify-osd

    pavucontrol
    gnome-text-editor
    btop
    libva-utils

    wezterm
    kitty
    kitty-img
    kitty-themes

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

    cliphist

    remmina
  ];

  environment.sessionVariables.PATH = "${pkgs.libsForQt5.polkit-kde-agent.out}/libexec";


  programs = {
    xwayland.enable = true;
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
    dconf.enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xfce.thunar-media-tags-plugin
    ];
  };

  services.tumbler.enable = true; # Thumbnail support for images
}
