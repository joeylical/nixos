# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    # { device = "/dev/disk/by-uuid/4318e623-29a2-463d-821d-3a6504a0cc24";
    { device = "/dev/disk/by-uuid/0ab60edd-ac1c-4a87-b77f-676fe5df2149";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" "nodiratime" "discard"];
    };

  # boot.initrd.luks.devices."luks-fb70fe28-bd6e-493d-80ed-9d079a03eab3".device = "/dev/disk/by-uuid/fb70fe28-bd6e-493d-80ed-9d079a03eab3";
  boot.initrd.luks.devices."luks-2e94505e-11ab-4c21-ad7a-301dc2b0be36".device = "/dev/disk/by-uuid/2e94505e-11ab-4c21-ad7a-301dc2b0be36";

  fileSystems."/boot" =
    # { device = "/dev/disk/by-uuid/6FD4-C388";
    { device = "/dev/disk/by-uuid/A2C3-C990";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/data" =
    { device = "/dev/disk/by-uuid/A074FA3374FA0BB2";
      fsType = "ntfs-3g"; 
      options = [ "rw" "uid=1000" "noatime" "nodiratime" "discard"];
    };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0f4u1u3c2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
