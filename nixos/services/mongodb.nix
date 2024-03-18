{ ... }:
{
  services.mongodb = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 27017 ];
}
