{ pkgs, ... }:

let
  enable = true;
in if enable then
{
  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    rocmPackages.clr
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
} else { }
