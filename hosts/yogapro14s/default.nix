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
      "quiet"
      "splash"
      "amd_pstate=active"
      "amdgpu.abmlevel=0"
      "mem_sleep_default=deep"
      "pcie_aspm.policy=powersupersave"
      "acpi.prefer_microsoft_dsm_guid=1"
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

    plymouth = {
      enable = true;
      extraConfig = ''
      [Daemon]
      DeviceScale=250
      '';
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    initrd.systemd.enable = true;
  };

  hardware.cpu.amd.ryzen-smu.enable = true;

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


  services = {
    libinput.enable = true;
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = true;
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

  # xserver
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    dpi = 250;
    displayManager = {
      gdm = {
        enable = false;
        wayland = true;
        autoLogin.delay = 1;
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
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  # sound
  # sound.enable = true;
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
    # linuxKernel.packages.linux_zen.amdgpu-pro
    linuxKernel.packages.linux_zen.nvidia_x11
    ryzenadj
  ];
  # all video drivers
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

}


