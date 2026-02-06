-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
    theme_toggle = { "ayu_light", "vesper" },

	hl_override = {
		Comment = { italic = true },
	 ["@comment"] = { italic = true },
	},
}

M.nvdash = { load_on_startup = not vim.g.vscode, header = {
"                                                                     ",
"       ████ ██████           █████      ██                     ",
"      ███████████             █████                             ",
"      █████████ ███████████████████ ███   ███████████   ",
"     █████████  ███    █████████████ █████ ██████████████   ",
"    █████████ ██████████ █████████ █████ █████ ████ █████   ",
"  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
" ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
"                                                                       ",
"                                                                       ",
"                                                                       "
  }}
M.ui = {
       tabufline = {
          lazyload = false
      },
}

if vim.g.vscode then
    M.ui.statusline = {
        theme = "vscode_colored",
    }
end

return M
