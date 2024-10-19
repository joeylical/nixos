{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.clr
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.sessionVariables.HSA_OVERRIDE_GFX_VERSION = "10.3.0";
}
