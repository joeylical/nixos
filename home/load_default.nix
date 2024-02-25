{home, lib, ... }:

{
  home.activation = {
    deploy_configs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -f "$HOME/.config/.gtkrc-2.0" ]; then
        if ! [ -f "$HOME/.gtkrc-2.0" ]; then
          ln -s $HOME/.config/.gtkrc-2.0 $HOME/.gtkrc-2.0
        fi
      fi

      if [ -d "$HOME/.config/fcitx5/rime" ]; then
        if ! [ -d "$HOME/.local/share/fcitx5/rime" ]; then
          ln -s $HOME/.config/fcitx5/rime $HOME/.local/share/fcitx5/rime
        fi
      fi

      if ! [ -f "$HOME/.wallpaper/wallpaper" ]; then
        cd /etc/nixos/home/wallpapers/
        cp `find . -name "*.*"|tail -n +2|sort -R|head -n 1` ~/.wallpaper/wallpaper
      fi
    '';
  };
}
