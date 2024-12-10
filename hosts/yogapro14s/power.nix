{ config, ... }:

{
  # power management
  # powerManagement = {
  #   enable = false;
  #   # cpuFreqGovernor = "powersave";
  # };

  systemd.services.ryzenadj = {
    enable = true;
    description = "RyzenAdj Autoset";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      # ExecStart = ''/bin/sh -c "/run/current-system/sw/bin/ryzenadj -a 35 --power-saving && echo 1 > /proc/sys/vm/laptop_mode" '';
      ExecStart = ''/bin/sh -c "echo 1 > /proc/sys/vm/laptop_mode" '';
    };
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
    ];
    wants = [
      "network-online.target"
    ];
  };

  powerManagement.powertop.enable = false;

  services.logind = {
    powerKey = "suspend-then-hibernate";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend-then-hibernate";
    lidSwitchDocked = "ignore";
  };

  services.tlp = {
    enable = true;
    settings = {
      # Operation
      TLP_ENABLE = 1;
      # Audio
      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";
      # Battery Care
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 80;
      RESTORE_THRESHOLDS_ON_BAT = 0;
      NATACPI_ENABLE = 1;
      TPACPI_ENABLE = 1;
      TPSMAPI_ENABLE = 1;
      # Disks and Controllers
      DISK_DEVICES = "nvme0";
      DISK_APM_LEVEL_ON_AC = "128 128";
      DISK_APM_LEVEL_ON_BAT = "128 128";
      DISK_SPINDOWN_TIMEOUT_ON_AC = "12 12";
      DISK_SPINDOWN_TIMEOUT_ON_BAT = "12 12";
      DISK_IOSCHED = "none none";
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      AHCI_RUNTIME_PM_ON_AC = "auto";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
      AHCI_RUNTIME_PM_TIMEOUT = 15;
      # Filesystem
      DISK_IDLE_SECS_ON_AC = 0;
      DISK_IDLE_SECS_ON_BAT = 2;
      MAX_LOST_WORK_SECS_ON_AC = 15;
      MAX_LOST_WORK_SECS_ON_BAT = 60;
      # Graphics
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_DPM_STATE_ON_AC = "balanced";
      RADEON_DPM_STATE_ON_BAT = "battery";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 3;
      # Kernel
      NMI_WATCHDOG = 0;
      # Networking
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      WOL_DISABLE = "Y";
      # Platform
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      MEM_SLEEP_ON_AC = "s2idle";
      MEM_SLEEP_ON_BAT = "deep";
      # Processor
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      # CPU_SCALING_MIN_FREQ_ON_AC = "400000";
      # CPU_SCALING_MAX_FREQ_ON_AC = "4785000";
      # CPU_SCALING_MIN_FREQ_ON_BAT = "400000";
      # CPU_SCALING_MAX_FREQ_ON_BAT = "3200000";
      CPU_ENGERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENGERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      # Radio Device Switching
      DEVICES_TO_DISABLE_ON_STARTUP = "";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth wifi";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";
      # Radio Device Wizard
      # Runtime Power Management and ASPM
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      # RUNTIME_PM_DENYLIST = "04:00.0";
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "default";
      # USB
      USB_AUTOSUSPEND = 1;
    };
  };
}
