{ ... }:

let
  enable = false;
in if enable then
{
  services.onedrive.enable = true;
} else { }
