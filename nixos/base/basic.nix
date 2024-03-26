{ pkgs, ... }:

let
  inherit (import ../../config.nix) userName;
in
{
  nixpkgs.config.allowUnfree = true;
  
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
      loginShellInit = "neofetch --disable packages editor resolution de wm wm_theme theme icons cursor";
    };
  };

  users.users."${userName}" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };

  users.defaultUserShell = pkgs.zsh;

  security.sudo.wheelNeedsPassword = false;

  systemd.tmpfiles.rules = [
    "d /storage/ 0777 nixos users"
  ];
}
