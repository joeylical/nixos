{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      hinting.style = "full";
      hinting.autohint = true;
      subpixel.rgba = "rgb";
      subpixel.lcdfilter = "default";
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "NotoMono Nerd Font"
          "WenQuanYi Micro Hei Mono"
          "Ubuntu"
        ];
        sansSerif = [
          "NotoSans Nerd Font"
          "Source Han Sans SC"
          "WenQuanYi Micro Hei"
          "Ubuntu"
        ];
        serif = [
          "NotoSerif Nerd Font"
          "Source Han Serif SC"
          "Ubuntu"
        ];
     };
    };
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      hack-font
      inter
      liberation_ttf
      roboto
      sarasa-gothic
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      source-han-mono
      source-han-sans
      source-han-serif
      wqy_microhei
      wqy_zenhei
      lxgw-wenkai
      lxgw-neoxihei
      vistafonts-chs
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.caskaydia-mono
      nerd-fonts.caskaydia-cove
    ];
  };
}

