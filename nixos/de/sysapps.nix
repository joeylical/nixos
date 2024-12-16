{ pkgs, ... }:
{
  boot.tmp.cleanOnBoot = true;

  services = {
    dbus.enable = true;
    upower.enable = true;
    logrotate.checkConfig = false;
  };

  environment.systemPackages = with pkgs; [
    light
    brightnessctl
    pciutils
    wirelesstools

    acpi
    powertop
    powerstat
    lshw
    evtest
    ntfs3g

    usbutils
  ];
}
