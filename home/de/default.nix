{ pkgs, ... }:

let
  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      # gsettings set $gnome_schema gtk-theme 'Dracula'
      import-gsettings
    '';
  };
in
{
  imports = [
    # user applications
    ./apps.nix
    ./hyprland.nix
  ];

  # basic DE tools
  home.packages =with pkgs; [
    configure-gtk

    flat-remix-gtk
    bibata-cursors
    yaru-theme
    paper-icon-theme
    papirus-icon-theme

  ];



  services.easyeffects.enable = true;
}
