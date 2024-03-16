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
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "custom/weather"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          "tray"
        ];
        "hyprland/workspaces" = {
          format = "{id}";
          onclick = "active";
        };

        "clock" = {
          "format"= "{:%m-%d %H:%M}";
          "locale"= "C";
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
            "hands-free" = "";
            headset = "";
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
      };
    };
    style = ''
      * {
        all: unset;
        font-family: DroidSans Nerd Font;
        font-size: 12px;
        letter-spacing: 1px;
      }
 
      #waybar.empty #clock {
        background-color: red;
        color: blue;
        transition: 0.5s;
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


      #waybar.floating {
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
        padding: 0px 8px;
        margin: 2px 2px;
        border-radius: 5px;
        /* background-color: alpha(@theme_fg_color, 0.1); */
      }

      #workspaces button.active {
        opacity: 1;
        color: @theme_selected_fg_color;
        background-color: @theme_selected_bg_color;
      }

      #workspaces button:hover {
        opacity: 1;
        color: @theme_selected_fg_color;
        background-color: mix(@theme_selected_bg_color, @theme_bg_color, 0.2);
      }
      
      #clock {
        font-weight: 600;
      }

      #custom-weather,
      #idle_inhibitor,
      #battery,
      #pulseaudio,
      #tray {
        margin-right: 8px;
      }

      tooltip {
        color: @theme_text_color;
        /*color: @theme_fg_color;*/
        background-color: @theme_bg_color;
        text-shadow: none;
        padding: 8px;
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
