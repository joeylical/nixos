{ ... }:
{
  services.mongodb = {
    enable = false;
  };

  networking.firewall.allowedTCPPorts = [ 27017 ];
}
