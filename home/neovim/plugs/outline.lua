local out = require('outline')

out.setup({
    outline_window = {
    -- Where to open the split window: right/left
    -- position = 'right',
    -- The default split commands used are 'topleft vs' and 'botright vs'
    -- depending on `position`. You can change this by providing your own
    -- `split_command`.
    -- `position` will not be considered if `split_command` is non-nil.
    -- This should be a valid vim command used for opening the split for the
    -- outline window. Eg, 'rightbelow vsplit'.
    -- Width can be included (with will override the width setting below):
    -- Eg, `topleft 20vsp` to prevent a flash of windows when resizing.
    split_command = nil,
  },

  symbol_folding = {
    -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
    autofold_depth = 1,
    -- When to auto unfold nodes
    auto_unfold = {
      -- Auto unfold currently hovered symbol
      hovered = true,
      -- Auto fold when the root level only has this many nodes.
      -- Set true for 1 node, false for 0.
      only = true,
    },
    markers = { '', '' },
  },

  providers = {
    priority = { 'lsp', 'coc', 'markdown', 'norg' },
    -- Configuration for each provider (3rd party providers are supported)
    lsp = {
      -- Lsp client names to ignore
      blacklist_clients = {},
    },
    markdown = {
      -- List of supported ft's to use the markdown provider
      filetypes = {'markdown'},
    },
  },
})

-- function ToggleOutline()
--     if out.has_provider() then
--         if not out.is_open() then
--             vim.cmd('OutlineOpen!')
--         else
--             out.refresh()
--         end
--     else
--         out.close()
--     end
-- end
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     callback = ToggleOutline
-- })
