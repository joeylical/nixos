{ ... }:
let
  inherit (import ../../config.nix) userName;
in
{
  users.users."${userName}".extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    storageDriver = "btrfs";
  };
}
