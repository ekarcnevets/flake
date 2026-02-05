return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  init = function()
    local autocmd = vim.api.nvim_create_autocmd

    local function open_nvim_tree(data)
      local directory = vim.fn.isdirectory(data.file) == 1

      if not directory then
        return
      end

      if directory then
        vim.cmd.cd(data.file)
      end

      require("nvim-tree.api").tree.open()
    end

    autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  end,
  opts = {}
}
