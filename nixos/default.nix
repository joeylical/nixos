{ config, pkgs, ... }:

let 
  inherit (import ../config.nix) timeZone city;
in
{
  imports = [
    ./base
  ];

  # Time Zone
  time.timeZone = timeZone;

  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment.sessionVariables = {
    CITY = city;
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    
    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";

    NIXPKGS_ALLOW_UNFREE = "1";
  };

  system.autoUpgrade = {
    enable = true;
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

