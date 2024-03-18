{ ... }:
{
  services.redis.servers."" = {
    enable = true;
    user = "redis";
  };

  networking.firewall.allowedTCPPorts = [ 6379 ];
}
