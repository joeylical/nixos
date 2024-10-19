{ config, ... }:
let
  inherit (import ../../config.nix) userName;
  driver = if config.networking.hostName == "wsl" then
      null
    else
      "btrfs";
in
{
  users.users."${userName}".extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    storageDriver = driver;
  };
}
