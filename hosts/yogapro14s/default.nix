{ config, pkgs, environment, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hidpi.nix
      ./power.nix
    ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [
      "nouveau"
    ];
    initrd.kernelModules = [
      "amdgpu"
    ];
    # initrd.secrets = {
    #   "/crypto_keyfile.bin" = null;
    # };
    kernelParams = [
      "amd_pstate=active"
    ];

    loader = {
      timeout=1;
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        consoleMode = "0"; # standard 80x25
      };
    };
  };

  # swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 8 * 1024;
    randomEncryption.enable = false;
  }];

  # Network
  networking.hostName = "laptop";
  
  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
	      Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  services.blueman.enable = true;
  environment.etc = {
  };


  # xserver
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    libinput.enable = true;
    dpi = 250;
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
      };
      gdm = {
        enable = false;
        wayland = true;
        autoLogin.delay = 1;
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "${pkgs.sddm-chili-theme}";
        settings = {
          Autologin = {
            Session = "hyprland.desktop";
          };
        };
      };
    };
  };
  environment.variables = {
  };

  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
	      xdg-desktop-portal-hyprland
      ];
    };
  };

  # more hardware settings
  hardware = {
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
            bluez_monitor.properties = {
              ["bluez5.enable-sbc-xq"] = true,
              ["bluez5.enable-msbc"] = true,
              ["bluez5.enable-hw-volume"] = true,
              ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
            }
          '')
      ];
    };
  };

  # hardware Nvidia
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      amdgpuBusId = "PCI:4:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    powerManagement = {
      enable = true;
      finegrained = true;
    };
  };

  # all packages
  environment.systemPackages = with pkgs; [
    blueman
    bluez
    linuxKernel.packages.linux_zen.amdgpu-pro
    linuxKernel.packages.linux_zen.nvidia_x11
    ryzenadj
  ];
  # all video drivers
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

}


