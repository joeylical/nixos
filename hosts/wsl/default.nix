{ pkgs, ... }:
let
  inherit (import ../../config.nix) userName;
in {
  imports = [
  ];

  wsl = {
    enable = true;
    defaultUser = "${userName}";
  };
  
  networking.hostName = "wsl"; # Define your hostname.
  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib";
    CUDA_PATH = "${pkgs.cudatoolkit}";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };
  
  environment.systemPackages = [
    pkgs.cudatoolkit
  ];
}

