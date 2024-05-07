{ pkgs, lib, config, ... }:
let
  enable = (false && (config.networking.hostName == "homeserver" ||
              config.networking.hostName == "laptop"));
in
lib.mkIf enable {
  services.auto-epp = {
    enable = true;
  };
}

