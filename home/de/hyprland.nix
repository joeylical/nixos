{specialArgs, pkgs, ... }:
{
  wayland.windowManager.hyprland.enable = true;

  # wayland.windowManager.hyprland.package =
  #   specialArgs.hyprland.packages.${pkgs.system}.hyprland;
  
  # wayland.windowManager.hyprland.plugins = [
  #   # fixme
  #   # specialArgs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  # ];

  home.packages = [
    pkgs.hyprland-autoname-workspaces
  ];

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$screen_file" = "$HOME/screen_$(date +'%Y-%m-%d_%H-%M-%S').png";
    monitor = [
      "eDP-1,3072x1920@60,auto,2"
      # "eDP-1,3072x1920@60,auto,2"
    ];

    general = {
      border_size = 1;
      "col.active_border" = "rgba(0a0a0a44)";
      "col.inactive_border" = "rgba(00000000)";
      gaps_in = 0;
      gaps_out = 0;
      layout = "master";
    };

    decoration = {
      blur = {
        enabled = false;
        passes = 1;
        size = 10;
      };
      "col.shadow" = "rgba(0a0a0a44)";
      drop_shadow = true;
      rounding = 5;
      shadow_range = 40;
      shadow_render_power = 5;
      dim_inactive = false;
      dim_strength = "0.05";
    };

    animations = {
      enabled = true;
      animation = [
        "windows, 1, 3, default"
        "windowsOut, 1, 3, default, popin 80%"
        "border, 1, 5, default"
        "borderangle, 1, 5, default"
        "fade, 1, 3, default"
        "workspaces, 1, 3, default"
      ];
    };

    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    xwayland = {
      force_zero_scaling = true;
    };

    gestures = {
      workspace_swipe = false;
    };
    
    input = {
      touchpad = {
        natural_scroll = true;
        scroll_factor = "1.0";
      };
      follow_mouse = true;
      kb_layout = "us";
      sensitivity = "0.5";
    };

    master = {
      # new_is_master = false;
      no_gaps_when_only = true;
    };

    misc = {
      disable_hyprland_logo = true;
      vrr = 1;
      vfr = true;
    };

    bind = [
      "$mod, E, exec, thunar"
      "$mod, R, exec, pkill wofi || wofi -n --show drun"
      "$mod, O, exec, MESA_LOADER_DRIVER_OVERRIDE=radeonsi kitty --single-instance"
      "$mod CTRL, O, exec, MESA_LOADER_DRIVER_OVERRIDE=radeonsi kitty --class floating --single-instance"
      "$mod, C, killactive"
      "$mod, M, togglefloating"
      "$mod, P, pseudo"
      "$mod, N, exec, setwp"
      "$mod, F, exec, themechanger && configure-gtk"
      "$mod, LEFT, movefocus, l"
      "$mod, RIGHT, movefocus, r"
      "$mod, UP, movefocus, u"
      "$mod, DOWN, movefocus, d"
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, d"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, light_wrap 20+"
      ", XF86MonBrightnessDown, exec, light_wrap 20-"
      " ALT, XF86MonBrightnessUp, exec, light_wrap 3+"
      " ALT, XF86MonBrightnessDown, exec, light_wrap 3-"
      "$mod, T, exec, hyprctl getoption 'device:syna2ba6:00-06cb:cec0-touchpad:enabled'|grep -q 'int: 1' && (hyprctl keyword 'device:syna2ba6:00-06cb:cec0-touchpad:enabled' false && pkill -RTMIN+10 waybar) || (hyprctl keyword 'device:syna2ba6:00-06cb:cec0-touchpad:enabled' true && pkill -RTMIN+10 waybar)"
      "$mod CTRL, L, exec, lockscreen"
      ", XF86Calculator, exec, qalculate-qt"
      ''$mod SHIFT, s, exec, grim -g "$(slurp -d)" $screen_file''
      "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod CTRL, mouse:272, resizewindow"
    ];

    env = [
      "XCURSOR_SIZE, 24"
    ];

    exec-once = [
      "configure-gtk"
      "paper"
      "fcitx5 -d"
      "dunst"
      "nm-applet --indicator"
      "blueman-applet"
      "polkit-kde-authentication-agent-1"
      "hyprctl keyword 'device:syna2ba6:00-06cb:cec0-touchpad:enabled' false"
      "easyeffects -q -l speaker"
      "swayidle -w timeout 60 lockscreen timeout 120 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep lockscreen"
      "pkexec swayosd-libinput-backend"
      # "hyprland-autoname-workspaces"
      # "hyprshade auto"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];

    windowrule = [
      "noblur, ^(firefox)$"
    ];

    windowrulev2 = [
      "float, class:(firefox), title:(Picture-in-Picture)"
      "size 640 360, class:(firefox), title:(Picture-in-Picture)"
      "float, class:(firefox), title:(File Upload)"
      "size 640 360, class:(firefox), title:(File Upload)"
      "float, class:(pavucontrol), title:(Volume Control)"
      "float, class:(.blueman-manager-wrapped)"
      "float, class:(.blueman-services-wrapped)"
      "float, class:(org.fcitx.), title:(Fcitx Configuration)"
      "float, class:(python3), title:(OneDriveGUI Setup Wizard)"
      "float, class:(python3), title:(OneDriveGUI)"
      "float, class:(), title:(Qalculate!)"
      "size 560 680, class:(), title:(Qalculate!)"
      "float, class:(nm-connection-editor)"
      "float, class:(thunar), title:(Bulk Rename - Rename Multiple Files)"
      "float, class:(thunar), title:(File Operation Progress)"
      "float, class:(obsidian), title:(Open folder as vault)"
      "float, class:(com.github.wwmm.easyeffects), title:(Easy Effects)"
      "float, class:(mpv), title:((.*) - mpv)"
      "size 1280 720, class:(mpv), title:((.*) - mpv)"
      "float, class:(audacious), title:(Audacious Settings)"
      "float, class:(gthumb), title:(.*)"
      "size 1000 680, class:(gthumb), title:(.*)"
      "float, class:(floating)"
      "center, class:(floating)"
      "size 1024 640, class:(floating)"
      "noshadow, floating:0"
      "float, class:(.themechanger-wrapped)"
      "float, class:(org.gnome.TextEditor)"
      "float, class:(peazip)"
      "float, class:(GoldenDict-ng)"
      "float, class:(shutdown.py)"
      "float, class:(reboot.py)"
      "float, class:(org.kde.polkit-kde-authentication-agent-1)"
      "float, class:(yesplaymusic)"
      "float, class:(onedriver)"
      "float, class:(QQ)"
      # "center, floating:1"
      "float,class:^(Zotero)$,title:Zotero Settings"
      "center,class:^(Zotero)$,title:Zotero Settings"
      "noanim,class:^(Zotero)$,title:Zotero Settings"
      # "maxsize 400 100,class:^(Zotero)$,title:Zotero Settings"
    ];
  };

  home.file = {
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.wallpaper/wallpaper
      wallpaper = eDP-1,~/.wallpaper/wallpaper
      wallpaper = DP-1,~/.wallpaper/wallpaper
      ipc = on
    '';
    # ".config/hyprland-autoname-workspaces/config.toml".text = builtins.readFile
    # ./hyprland-autoname-workspaces.toml;
  };
}
