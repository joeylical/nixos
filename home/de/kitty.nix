{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "CaskaydiaCove Nerd Font Mono";
      size = 12;
    };
    shellIntegration = {
      # mode = "no-rc";
      enableZshIntegration = true;
    };
    settings = {
      bold_font = "CaskaydiaCove Nerd Font Mono";
      bold_italic_font = "CaskaydiaCove Nerd Font Mono Italic";
      enable_audio_bell = false;
      linux_display_server = "wayland";
      shell = "zsh -i";
      window_padding_width = 8;
      include = "theme";
    };
  };

  home.file = {
    # ".config/kitty/theme".text = "${pkgs.kitty-themes.out}/share/kitty-themes/themes/Tomorrow.conf";
  };
}
