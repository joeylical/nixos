{ ... }:
{
  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    # proxy = {
    #   default = "";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };
}
