{ config, pkgs, lib, environment, nixneovimplugins, ... }:
{
  config = let
  in {
    home.packages =with pkgs; [
      (neovim-qt.override { neovim = config.programs.neovim.finalPackage; })
      neovide
      ansible-language-server
      nil
      lazygit
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    systemd.user.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      extraConfig = lib.fileContents ./basic.vim;
      plugins = [
        {
          plugin = pkgs.vimPlugins.nvim-tree-lua;
          config = lib.fileContents ./plugs/nvimtree.vim;
        }

        {
          plugin = pkgs.vimPlugins.vim-startify;
          config = "let g:startify_lists = [ { 'type': 'commands',  'header': ['   Commands']}, ]";
        }

        # LSP start
        # todo: scatter the configs
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-path
        pkgs.vimPlugins.cmp-cmdline
        pkgs.vimPlugins.cmp-vsnip
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.cmp-nvim-lsp
        {
          plugin = pkgs.vimPlugins.nvim-cmp;
          config = lib.fileContents ./plugs/completion.vim;
        }
        # LSP END
        
        # colorscheme
        pkgs.vimPlugins.tokyonight-nvim
        pkgs.vimPlugins.onedark-nvim
        pkgs.vimPlugins.vim-one
        pkgs.vimPlugins.material-nvim
        pkgs.vimPlugins.nvim-web-devicons

        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        
        {
          plugin = pkgs.vimPlugins.lualine-nvim;
          type = "lua";
          config = "require('lualine').setup()";
        }

        {
          plugin = pkgs.vimPlugins.blamer-nvim;
          config = "let g:blamer_enabled = 1";
        }
        
        {
          plugin = pkgs.vimPlugins.glance-nvim;
          config = lib.fileContents ./plugs/glance.vim;
        }

        {
          plugin = pkgs.vimPlugins.nvim-comment;
          config = lib.fileContents ./plugs/comment.vim;
        }
        {
          plugin = pkgs.vimPlugins.toggleterm-nvim;
          config = lib.fileContents ./plugs/toggleterm.vim;
        }
        {
          plugin = pkgs.vimPlugins.bufferline-nvim;
          config = lib.fileContents ./plugs/bufferline.vim;
        }
        {
          plugin = pkgs.vimPlugins.symbols-outline-nvim;
          config = lib.fileContents ./plugs/symoutline.vim;
        }
        # https://github.com/folke/which-key.nvim
        pkgs.vimPlugins.which-key-nvim

        {
          plugin = pkgs.vimPlugins.flash-nvim;
          config = lib.fileContents ./plugs/flash.vim;
        }

        {
          plugin = pkgs.vimPlugins.ansible-vim;
        }

        {
          plugin = pkgs.vimPlugins.telescope-nvim;
          config = lib.fileContents ./plugs/telescope.vim;
        }
        pkgs.vimPlugins.yuck-vim
        pkgs.vimPlugins.vim-vsnip
        pkgs.vimExtraPlugins.sqls-nvim
        pkgs.vimPlugins.orgmode
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.lazygit-nvim
      ];
    };
  };
}

