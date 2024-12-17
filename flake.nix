{
  description = "NixOS";

  nixConfig = {
    substituters = [
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org" 
      # "https://llama-cpp.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "llama-cpp.cachix.org-1:H75X+w83wUKTIPSO1KWy9ADUrzThyGs8P5tmAbkWhQc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
  };

  outputs = inputs@{
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      nixneovimplugins,
      # nix-vscode-extensions,
      ...
  }: 
  let
    inherit (import ./config.nix) userName city timeZone;
    mkConfig = flags: {
      system = "x86_64-linux";

      specialArgs = {
        userName=userName;
        city=city;
        timeZone=timeZone;
      };

      modules = [
        ./nixos

        ./nixos/module/docker.nix
        ( if flags.btrfs then {
            nixpkgs.config.virtualisation.docker.storageDriver = "btrfs";
          } else {})

        ( if flags.epp then
           ./nixos/module/epp.nix
          else {})

        ( if flags.rocm then
          ./nixos/module/rocmrt.nix
          else {})

        ( if flags.zerotier then
          ./nixos/module/zerotier.nix
          else {})

        ( if flags.desk_env then
          ./nixos/de
          else {})

        (./hosts + ("/" + flags.host))

        ( if flags.host == "wsl" then
          nixos-wsl.nixosModules.wsl
          else {})

        {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              nixneovimplugins.overlays.default
            ];};}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = inputs // {
                desktop_env=flags.desk_env; 
                userName=userName;
                city=city;
                timeZone=timeZone;
          };
          home-manager.users."${userName}" = import ./home;
        }];};
  in
  {
    nixosConfigurations = {

      laptop = nixpkgs.lib.nixosSystem (mkConfig {
        desk_env = true;
        btrfs = true;
        rocm = true;
        epp = true;
        zerotier = true;
        host = "yogapro14s";
      });

      wsl = nixpkgs.lib.nixosSystem (mkConfig {
        desk_env = false;
        btrfs = false;
        # rocm = true;
        rocm = false;
        epp = false;
        zerotier = false;
        host = "wsl";
      });

      homeserver = nixpkgs.lib.nixosSystem (mkConfig {
        desk_env = false;
        btrfs = true;
        rocm = true;
        epp = true;
        zerotier = true;
        host = "homeserver";
      });

      packages.x86_64-linux.default = "laptop";
    };
  };
}
