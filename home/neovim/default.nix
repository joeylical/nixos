{ config, pkgs, lib, environment, nixneovimplugins, ... }:
{
  config = {
    home.packages =with pkgs; [
      (neovim-qt.override { neovim = config.programs.neovim.finalPackage; })
      neovide
      nil
      lazygit
      luajit
      # luajitPackages.lua-lsp
      lua-language-server
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
      extraLuaConfig = ''
        vim.g.mapleader = ','
      '';
      plugins = [
        {
          plugin = pkgs.vimPlugins.nvim-tree-lua;
          type = "lua";
          config = lib.fileContents ./plugs/nvimtree.lua;
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
          type = "lua";
          config = lib.fileContents ./plugs/completion.lua;
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
          config = ''
            require('lualine').setup({
              options={
                disabled_filetypes={
                  statusline={'NvimTree'},
                  winbar={'NvimTree'}
                }
              }
            })
          '';
        }

        {
          plugin = pkgs.vimPlugins.blamer-nvim;
          config = "let g:blamer_enabled = 1";
        }
        
        {
          plugin = pkgs.vimPlugins.glance-nvim;
        }

        {
          plugin = pkgs.vimPlugins.nvim-comment;
          type = "lua";
          config = lib.fileContents ./plugs/comment.lua;
        }
        {
          plugin = pkgs.vimPlugins.toggleterm-nvim;
          type = "lua";
          config = lib.fileContents ./plugs/toggleterm.lua;
        }
        {
          plugin = pkgs.vimPlugins.bufferline-nvim;
          type = "lua";
          config = lib.fileContents ./plugs/bufferline.lua;
        }
        {
          plugin = pkgs.vimPlugins.outline-nvim;
          type = "lua";
          config = lib.fileContents ./plugs/outline.lua;
        }
        # https://github.com/folke/which-key.nvim
        {
          plugin = pkgs.vimPlugins.which-key-nvim;
          type = "lua";
          config = lib.fileContents ./plugs/which-key.lua;
        }

        {
          plugin = pkgs.vimPlugins.flash-nvim;
          type = "lua";
          config = lib.fileContents ./plugs/flash.lua;
        }

        {
          plugin = pkgs.vimPlugins.telescope-nvim;
        }
        pkgs.vimPlugins.vim-vsnip
        pkgs.vimExtraPlugins.sqls-nvim
        pkgs.vimPlugins.orgmode
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.lazygit-nvim
        pkgs.vimPlugins.bufdelete-nvim
      ];
    };
  };
}

