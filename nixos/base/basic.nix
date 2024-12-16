{ pkgs, specialArgs, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    file
    pstree
    lsof
    socat
    killall

    zlib
    zlib-ng

    unzip
    ripgrep
    marksman

    bc
    jq

    ansible
    sqlite

    yt-dlp
    ffmpeg

    lm_sensors

    devenv
  ];

  programs = {
    git = {
      enable = true;
      config = {
        safe.directory = "*";
      };
    };
    zsh = {
      enable = true;
      # loginShellInit = "neofetch --disable packages editor resolution de wm wm_theme theme icons cursor";
    };
  };

  users.users."${specialArgs.userName}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  users.defaultUserShell = pkgs.zsh;

  security.sudo.wheelNeedsPassword = false;

  systemd.tmpfiles.rules = [
    "d /storage/ 0777 nixos users"
  ];
}
