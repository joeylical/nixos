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

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # vscode 插件库
    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  # outputs 的参数都是 inputs 中定义的依赖项，可以通过它们的名称来引用。
  # 不过 self 是个例外，这个特殊参数指向 outputs 自身（自引用），以及 flake 根目录
  # 这里的 @ 语法将函数的参数 attribute set 取了个别名，方便在内部使用
  outputs = inputs@{
      self,
      nixpkgs,
      home-manager,
      # nix-vscode-extensions,
      ...
  }: 
  let
    inherit (import ./config.nix) userName;
  in
  {
    nixosConfigurations = {
      # 这里使用了 nixpkgs.lib.nixosSystem 函数来构建配置，后面的 attributes set 是它的参数
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # modules 中每个参数，都是一个 NixOS Module <https://nixos.org/manual/nixos/stable/index.html#sec-modularity>
        # NixOS Module 可以是一个 attribute set，也可以是一个返回 attribute set 的函数
        # 如果是函数，那么它的参数就是当前的 NixOS Module 的参数.
        # 根据 Nix Wiki 对 NixOS modules 的描述，NixOS modules 函数的参数可以有这四个（详见本仓库中的 modules 文件）：
        #
        #  config: The configuration of the entire system
        #  options: All option declarations refined with all definition and declaration references.
        #  pkgs: The attribute set extracted from the Nix package collection and enhanced with the nixpkgs.config option.
        #  modulesPath: The location of the module directory of NixOS.
        #
        # nix flake 的 modules 系统可将配置模块化，提升配置的可维护性
        # 默认只能传上面这四个参数，如果需要传其他参数，必须使用 specialArgs
        modules = [
          ./hosts/yogapro14s
          ./nixos
          ./nixos/components

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

        modules = [
          # add wsl modules
          inputs.nixos-wsl.nixosModules.wsl
          ./nixos

          {
            wsl = {
              enable = true;
              defaultUser = "${userName}";
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

      packages.x86_64-linux.default = "laptop";
    };
  };
}
