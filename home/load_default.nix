{home, lib, specialArgs, ... }:

{
  home.activation = {
    deploy_configs = lib.hm.dag.entryAfter ["writeBoundary"]
      (if specialArgs.desktop_env then ''
        if [ -f "$HOME/.config/.gtkrc-2.0" ]; then
          if ! [ -f "$HOME/.gtkrc-2.0" ]; then
            ln -s $HOME/.config/.gtkrc-2.0 $HOME/.gtkrc-2.0 || echo
          fi
        fi

        if [ -d "$HOME/.config/fcitx5/rime" ]; then
          if ! [ -d "$HOME/.local/share/fcitx5/rime" ]; then
            ln -s $HOME/.config/fcitx5/rime $HOME/.local/share/fcitx5/rime || echo
          fi
        fi

        if ! [ -f "$HOME/.wallpaper/wallpaper" ]; then
          mkdir -p ~/.wallpaper/
          cp `find . -name "*.*"|tail -n +2|sort -R|head -n 1` ~/.wallpaper/wallpaper
        fi

        cd /etc/nixos/home/defaults
        cp -r -n * $HOME/.config/ >/dev/null 2>&1 || echo
        cd -
      '' else "" + ''
        if ! [ -f "$HOME/.p10k.zsh" ]; then
          cp /etc/nixos/home/de/p10k.zsh $HOME/.p10k.zsh
        fi
      '');
  };
}
