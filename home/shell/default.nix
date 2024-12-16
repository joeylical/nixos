{config, pkgs, ... }:
{
  config = {
    home = {
      packages = with pkgs; [
        zsh-powerlevel10k
        
        direnv

        # neofetch

        ranger
      ];

      sessionVariables = {
      };
    };

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "terraform"
          "systemadmin"
        ];
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
      initExtra = ''
        eval "''$(direnv hook zsh)"
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ~/.p10k.zsh
        export PATH=/run/wrappers/bin/:$PATH
      '';
      shellAliases = {
        # "ns" = "nix-shell --run zsh";
        "icat" = "kitty +kitten icat";
      };
    };
  };
}
