{ config, pkgs, ... }:

let
  enable = true;
in
{
  virtualisation.waydroid.enable = enable;
}
