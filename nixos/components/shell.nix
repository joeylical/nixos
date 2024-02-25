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
    eww-wayland
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
