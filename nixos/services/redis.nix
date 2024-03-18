{ ... }:
{
  services.redis.servers."" = {
    enable = true;
    bind = "192.168.0.200";
  };
}
