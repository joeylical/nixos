{ specialArgs, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    # package = specialArgs.waybar.packages.${pkgs.system}.waybar;
    systemd = {
      enable = true;
    };

    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        height = 25;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "custom/darkmode"
          "custom/weather"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "tray"
          "group/group-power"
        ];
        "hyprland/window" = {
          format = "";
        };

        "hyprland/workspaces" = {
          format = "{id}";
          onclick = "active";
        };

        "clock" = {
          "format"= "{:%m-%d %H:%M}";
          "locale"= "C";
        };

        "custom/darkmode" = {
          format="󰔎";
          "on-click" = "change_mode.py toggle";
        };
        "custom/weather" = {
          format = "{}";
          "return-type" = "json";
          "exec" = "/run/current-system/sw/bin/python /etc/profiles/per-user/nixos/bin/getweather1.py";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          "format-icons" = {
            "activated" = "󰒳";
            "deactivated" = "󰒲";
          };
        };

        "battery" = {
          bat = "BAT0";
          interval = 5;
          format = "󰂀";
          "format-charging" = "󰂄";
          "format-not-charging" = "󰚥";
          "format-plugged" = "󰚥";
          "format-icons" = [
            "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"
          ];
          tooltip = true;
          "tooltip-format" = "{capacity}% {timeTo}";
        };

        pulseaudio = {
          format = "{icon}";
          "format-muted" = "󰝟";
          "format-icons" = {
            headphone = "";
            "hands-free" = "󱡏";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
          "ignored-sinks" = ["Easy Effects Sink"];
        };

        tray = {
          "icon-size" = 12;
          spacing = 2;
        };

        "group/group-power" = {
          orientation = "inherit";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = true;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/quit" = {
          format = "󰗼";
          tooltip = false;
          "on-click" = "hyprctl dispatch exit";
        };

        "custom/lock" = {
          format = "󰍁";
          tooltip = false;
          "on-click" = "lockscreen";
        };

        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          "on-click" = "reboot";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          "on-click" = "shutdown now";
        };
      };
    };
    style = ''
      * {
        all: unset;
        font-family: DroidSans Nerd Font;
        font-size: 12px;
        letter-spacing: 1px;
      }
 
      #waybar {
        background-color: @theme_bg_color; 
        color: @theme_fg_color;
        margin: 0px 4px;
        padding: 0px 4px;
        transition: 0.5s;
      }

      #waybar.empty {
        background-color: transparent;
        transition: 0.5s;
      }


      #waybar.floating:not(.solo) {
        background-color: transparent;
        transition: 0.5s;
      }

      #workspaces {
        /* background-color: transparent; */
        margin: 0px 4px;
        padding: 0px 0px;
      }

      #workspaces button {
        /* all: unset; */
        /* box-shadow: inset 0 -3px transparent;  Use box-shadow instead of border so the text isn't offset */
        padding: 0px 4px;
        margin: 4px 6px;
        border-style: solid;
        border-color: transparent;
        border-width: 1px;
        /* border-radius: 2px; */
        /* background-color: alpha(@theme_fg_color, 0.1); */
      }

      #workspaces button.active {
        opacity: 1;
        /* color: @theme_selected_fg_color; */
        /* background-color: @theme_selected_bg_color; */
        border-top-color: @theme_text_color;
      }

      #workspaces button:hover {
        opacity: 1;
        /* color: @theme_selected_fg_color; */
        /* background-color: mix(@theme_selected_bg_color, @theme_bg_color, 0.2); */
        border-top-color: @theme_text_color;
      }
      
      #clock {
        font-weight: 600;
      }

      #group-group-power,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-power,
      #custom-darkmode,
      #custom-weather,
      #idle_inhibitor,
      #battery,
      #pulseaudio,
      #tray {
        margin-right: 8px;
      }

      #tray menu {
        background-color: @theme_bg_color;
        color: @theme_fg_color;
        padding: 10px 0px;
        border-radius: 5px;
        border: 1px solid mix(@theme_bg_color, @theme_fg_color, 0.6);
      }

      #tray menu menuitem {
        padding: 4px 10px;
      }

      #tray menu separator {
        margin: 0px 2px;
        border-bottom: 1px solid mix(@theme_bg_color, @theme_fg_color, 0.2);
      }

      #tray menu menuitem:hover {
        background-color: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }

      tooltip {
        color: @theme_text_color;
        /*color: @theme_fg_color;*/
        background-color: @theme_bg_color;
        text-shadow: none;
        padding: 2px;
        margin: 0px;
        border-radius: 5px;
        border: 1px solid mix(@theme_bg_color, @theme_fg_color, 0.6);
      }

      tooltip label {
        color: @theme_text_color;
        /*font-size: medium;*/
        padding: 0px;
        margin: 0px;
      }
    '';
  };
}
