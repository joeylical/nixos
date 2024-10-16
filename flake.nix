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
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";      # 使用 nixos-unstable 分支
    home-manager.url = "github:nix-community/home-manager";
    #　follows 是　inputs 中的继承语法
    # 这里使　home-manager 的　nixpkgs 这个 inputs 与当前　flake 的　inputs.nixpkgs 保持一致，避免依赖的　nixpkgs 版本不一致导致问题
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # 添加wsl2支持
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";

    llama-cpp.url = "github:ggerganov/llama.cpp";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # waybar.url = "github:Alexays/Waybar";

    # vscode 插件库
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs@{
      self,
      nixpkgs,
      home-manager,
      nixneovimplugins,
      # nix-vscode-extensions,
      ...
  }: 
  let
    inherit (import ./config.nix) userName;
  in
  {

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/yogapro14s
          ./nixos
          ./nixos/components
          ./nixos/phy/rocmrt.nix
          ./nixos/phy/docker.nix
          # ./nixos/services/zerotier.nix
          ./nixos/services/epp.nix

          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                nixneovimplugins.overlays.default
                inputs.llama-cpp.overlays.default
              ];
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home 的参数
            home-manager.extraSpecialArgs = inputs // {desktop_env=true;} ;
            home-manager.users."${userName}" = import ./home;
          }
        ];
      };
      # end of laptop

      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = with nixpkgs; [
          # add wsl modules
          inputs.nixos-wsl.nixosModules.wsl
          ./nixos
          # ./nixos/phy/docker.nix

          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                nixneovimplugins.overlays.default
                inputs.llama-cpp.overlays.default
              ];
            };

            wsl = {
              enable = true;
              defaultUser = "${userName}";
            };
            
            networking.hostName = "wsl"; # Define your hostname.
            environment.sessionVariables = {
              LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
            };
            # environment.sessionVariables = {
            #   LD_LIBRARY_PATH = "/usr/lib/wsl/lib:${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib";
            #   CUDA_PATH = "${pkgs.cudatoolkit}";
            #   EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
            #   EXTRA_CCFLAGS = "-I/usr/include";
            # };
            #
            # environment.systemPackages = [
            #   pkgs.cudatoolkit
            # ];
            users.users."${userName}".extraGroups = [ "docker" ];
            virtualisation.docker = {
              enable = true;
              enableOnBoot = false;
              # setSocketVariable = true;
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs // {desktop_env=false;} ;
            home-manager.users."${userName}" = import ./home;
          }
        ];
      };
      # end of wsl

      homeserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/homeserver
          ./nixos
          ./nixos/phy/rocmrt.nix
          ./nixos/phy/docker.nix
          ./nixos/services

          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                nixneovimplugins.overlays.default
                inputs.llama-cpp.overlays.default
              ];
            };
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home 的参数
            home-manager.extraSpecialArgs = inputs // {desktop_env=false;} ;
            home-manager.users."${userName}" = import ./home;
          }
        ];
      };
      # end of miniserver

      packages.x86_64-linux.default = "laptop";
    };
  };
}
