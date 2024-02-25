{config, ... }:

let
  enable = true;
in if enable then
{
  services = {
    samba = {
      enable = true;
      nsswins = true;
      enableNmbd = true;
      enableWinbindd = true;
    };

    avahi = {
      enable = true;
      nssmdns = true;
      publish.addresses = true;
    };

    gvfs.enable = true;
  };

  # open UDP 137 for samba
  networking.firewall.allowedUDPPorts = [ 137 ];
} else { }
