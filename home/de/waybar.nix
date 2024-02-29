{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainbar = {
        layer = "top";
        position = "top";
        height = 12;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
        ];
        "hyprland/workspaces" = {
          format = "{id}";
          onclick = "active";
        };
        "clock" = {
          "format"= "{:%m-%d %H:%M}";
          "locale"= "C";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: Material Design Icons, JetBrainsMono Nerd Font;
        font-size: 12px;
        /* font-weight: bold; */
      }

      window#waybar {
        background-color: @theme_bg_color;
        transition-property: background-color;
      }

      #workspaces {
        /* background-color: transparent; */
        margin: 0px 0px;
        padding: 0px 0px;
      }
    '';
  };
}
