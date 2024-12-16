{ specialArgs, ... }:
{
  users.users."${specialArgs.userName}".extraGroups = [ "docker" ];
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
