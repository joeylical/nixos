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
          "custom/weather"
          "custom/tdp"
          "custom/darkmode"
          "idle_inhibitor"
          "pulseaudio"
          "battery"
          # "network"
          # "bluetooth"
          "tray"
          "custom/power"
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

        "custom/tdp" = {
          format = "{}";
          exec = "cat /tmp/tdp.txt || echo unset";
          signal = 1;
          interval = "once";
          menu = "on-click";
          "menu-file" = "$HOME/.config/waybar/tdp.xml";
          "menu-actions" = {
            "5w" = "sudo ryzenadj -a 5000 -b 5000 -c 5000 && echo 5w > /tmp/tdp.txt && pkill -RTMIN+1 waybar";
            "15w" = "sudo ryzenadj -a 15000 -b 15000 -c 10000 && echo 15w > /tmp/tdp.txt && pkill -RTMIN+1 waybar";
            "25w" = "sudo ryzenadj -a 25000 -b 25000 -c 15000 && echo 25w > /tmp/tdp.txt && pkill -RTMIN+1 waybar";
            "35w" = "sudo ryzenadj -a 35000 -b 35000 -c 20000 && echo 35w > /tmp/tdp.txt && pkill -RTMIN+1 waybar";
            "65w" = "sudo ryzenadj -a 65000 -b 65000 -c 28000 && echo 65w > /tmp/tdp.txt && pkill -RTMIN+1 waybar";
          };
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

        network= {
            # interface = "*";
            format = "{}";
            "format-wifi"= "{essid}";
            "format-ethernet"= "󰈀";
            "format-linked" = "󱛅";
            "format-disconnected"= "󰖪"; 
            "tooltip-format"= "{ifname} via {gwaddr} 󰊗";
            "tooltip-format-wifi"= "{essid} ({signalStrength}%) ";
            "tooltip-format-ethernet"= "{ifname} 󰈀";
            "tooltip-format-disconnected"= "Disconnected";
            "max-length"= 50;
        };

        bluetooth = {
          "format" = "{}";
          "format-disabled" = "󰂲";
          "format-on" = "";
          "format-off" = "󰂲";
          "format-connected" = "󰂱";
          "tooltip-format" = "{controller_alias}\t{controller_address}";
          "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        };

        tray = {
          "icon-size" = 12;
          spacing = 2;
        };

        "custom/power" = {
          "format" = "⏻";
            "tooltip"= false;
            "menu"= "on-click";
            "menu-file"= "$HOME/.config/waybar/power_menu.xml";
            "menu-actions"= {
              "shutdown"= "systemctl poweroff";
              "reboot"= "systemctl reboot";
              "suspend"= "systemctl suspend";
              "hibernate"= "systemctl hibernate";
            };
        };

        # "group/group-power" = {
        #   orientation = "inherit";
        #   drawer = {
        #     "transition-duration" = 500;
        #     "children-class" = "not-power";
        #     "transition-left-to-right" = true;
        #   };
        #   modules = [
        #     "custom/power"
        #     "custom/quit"
        #     "custom/lock"
        #     "custom/reboot"
        #   ];
        # };
        #
        # "custom/quit" = {
        #   format = "󰗼";
        #   tooltip = false;
        #   "on-click" = "hyprctl dispatch exit";
        # };
        #
        # "custom/lock" = {
        #   format = "󰍁";
        #   tooltip = false;
        #   "on-click" = "lockscreen";
        # };
        #
        # "custom/reboot" = {
        #   format = "󰜉";
        #   tooltip = false;
        #   "on-click" = "reboot";
        # };
        #
        # "custom/power" = {
        #   format = "";
        #   tooltip = false;
        #   "on-click" = "shutdown now";
        # };
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
        color: @theme_text_color;
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
      #custom-tdp,
      #idle_inhibitor,
      #battery,
      #pulseaudio,
      #network,
      #bluetooth,
      #tray {
        margin-right: 8px;
      }

      menu {
        background-color: @theme_bg_color;
        color: @theme_text_color;
        padding: 10px 0px;
        border-radius: 5px;
        border: 1px solid mix(@theme_bg_color, @theme_fg_color, 0.6);
      }

      menu menuitem {
        padding: 4px 10px;
      }

      menu separator {
        margin: 0px 2px;
        border-bottom: 1px solid mix(@theme_bg_color, @theme_fg_color, 0.2);
      }

      menu menuitem:hover {
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

  home.file = {
    ".config/waybar/tdp.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <interface>
        <object class="GtkMenu" id="menu">

        <child>
          <object class="GtkMenuItem" id="5w">
            <property name="label">tdp: 5w</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="15w">
            <property name="label">tdp: 15w</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="25w">
            <property name="label">tdp: 25w</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="35w">
            <property name="label">tdp: 35w</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="65w">
            <property name="label">tdp: 65w</property>
          </object>
        </child>
      </object>
    </interface>
    '';
    ".config/waybar/power_menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <interface>
        <object class="GtkMenu" id="menu">

        <child>
          <object class="GtkMenuItem" id="suspend">
            <property name="label">Suspend</property>
              </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="hibernat">
            <property name="label">Hibernate</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="shutdown">
            <property name="label">Shutdown</property>
          </object>
        </child>

        <child>
          <object class="GtkMenuItem" id="reboot">
            <property name="label">Reboot</property>
          </object>
        </child>
      </object>
    </interface>
    '';
  };
}
