{ specialArgs, ... }:

{
  imports = [
    ./base
  ];

  # Time Zone
  time.timeZone = specialArgs.timeZone;

  # i18n
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  environment.sessionVariables = {
    CITY = specialArgs.city;
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

  nix.settings.trusted-users = [
    "root"
    "nixos"
  ];
}

