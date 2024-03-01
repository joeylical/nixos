{ config, pkgs, ... }:

let
  enable = false;
in
{
  virtualisation.waydroid.enable = enable;
}
