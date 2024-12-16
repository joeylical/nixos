{ pkgs, lib, config, ... }:
{
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "d3ecf5726d73560a"
    ];
  };
}

