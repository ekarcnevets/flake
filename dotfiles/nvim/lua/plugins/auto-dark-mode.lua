return {
  "f-person/auto-dark-mode.nvim",
  lazy = false,
  config = function()
    vim.g.toggle_theme_icon = ""

    -- In NvChad v2.5+, use require("nvconfig") instead of core.utils
    local config = require("nvconfig")

    require('auto-dark-mode').setup({
      update_interval = 1000,
      set_light_mode = function()
        local light_theme = config.base46.theme_toggle[1]
        if config.base46.theme ~= light_theme then
          config.base46.theme = light_theme
          require("base46").load_all_highlights()
          vim.g.toggle_theme_icon = ""
        end
      end,
      set_dark_mode = function()
        local dark_theme = config.base46.theme_toggle[2]
        if config.base46.theme ~= dark_theme then
          config.base46.theme = dark_theme
          require("base46").load_all_highlights()
          vim.g.toggle_theme_icon = ""
        end
      end,
    })

    require('auto-dark-mode').init()
  end
}
