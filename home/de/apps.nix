{ pkgs, ... }:
{
  home.packages = [
  ];

  # home.file.".config/hypr/hyprshade.toml".text = ''
  #   [[shades]]
  #   name = "blue-light-filter"
  #   start_time = 21:00:00
  #   end_time = 07:00:00   # optional if you have more than one shade with start_time
  # '';

  home.file.".config/hypr/shaders/blue-light-filter.glsl".source =
    "${pkgs.hyprshade.outPath}/share/hyprshade/shaders/blue-light-filter.glsl";
  

  programs.vscode = {
    enable = true;
    package = (pkgs.vscode.override{
      commandLineArgs = "--enable-wayland-ime";
    }).fhs;
  };
}
