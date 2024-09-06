# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "homeserver"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
    randomEncryption.enable = true;
  }];

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  services.samba = {
    enable = true;
    nsswins = true;
    enableNmbd = true;
    enableWinbindd = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = homeserver
      netbios name = homeserver
      protocol = SMB3
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/storage/";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "nixos";
        "force group" = "users";
      };
    };
  };

  services.avahi = {
      enable = true;
      nssmdns4 = true;
      publish.addresses = true;
    };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
      };
    };
  };
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
