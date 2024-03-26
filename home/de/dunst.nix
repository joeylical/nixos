{ ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Noto Sans CJK SC";
        background = "#ffffff";
        foreground = "#0a0a0a";
        frame_width = 1;
        frame_color = "#202020";
        corner_radius = 12;
        height = 500;
        layer = "overlay";
      };
      "urgency_critical" = {
        foreground = "#5c57ff";
        frame_color = "#5c57bb";
      };
    };
  };
}
