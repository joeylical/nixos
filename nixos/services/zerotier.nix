{ pkgs, lib, config, ... }:
let
  enable = (config.networking.hostName == "homeserver" ||
              config.networking.hostName == "laptop");
in
lib.mkIf enable {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "d3ecf5726d73560a"
    ];
  };
}

