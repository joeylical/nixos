{ ... }:

{
  services = {
    samba = {
      enable = true;
      nsswins = true;
      nmbd.enable = true;
      winbindd.enable = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish.addresses = true;
    };

    gvfs.enable = true;
  };

  # open UDP 137 for samba
  networking.firewall.allowedUDPPorts = [ 137 ];
}
