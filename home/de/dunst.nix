{ ... }:

{
  # font=sans 10
  # background-color=#e6e6fadd
  # text-color=#333333ff
  # border-color=#b3b3ffdd
  # border-radius=4
  # height=500
  # # avoid covering firefox's tabs and buttons
  # outer-margin=75,0,0,0
  # layer=overlay
  #
  # [urgency=high]
  # text-color=#ff5c57ff
  # border-color=#ff5c57bb
  #
  # [mode=locked]
  # layer=top
  #
  # [mode=dnd]
  # invisible=1

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "sans 10";
        background-color = "#e6e6fadd";
        text-color = "#333333ff";
        border-color = "#b3b3ffdd";
        border-radius = 4;
        height = 500;
        outer-margin = "75,0,0,0";
        layer = "overlay";
      };
      "urgency=high" = {
        text-color = "#ff5c57ff";
        border-color = "#ff5c57bb";
      };
    };
  };
}
