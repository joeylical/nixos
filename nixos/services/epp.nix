{ pkgs, lib, config, ... }:
let
  enable = (config.networking.hostName == "homeserver" ||
              config.networking.hostName == "laptop");
in
lib.mkIf enable {
  services.auto-epp = {
    enable = true;
  };
}

