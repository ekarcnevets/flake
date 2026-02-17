{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      fd
      gopls
      lua-language-server
      nil
      pyright
      ripgrep
      tree-sitter
      yaml-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      vim-nix
      telescope-nvim
      plenary-nvim
      nvim-treesitter.withAllGrammars
      lualine-nvim
      github-nvim-theme
      gruvbox-nvim
      fleet-theme-nvim
      blink-cmp
      friendly-snippets
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      trouble-nvim
      nvim-lspconfig
      snacks-nvim
      noice-nvim
      nvim-notify
      which-key-nvim
      nui-nvim
      lspsaga-nvim
      nvim-web-devicons
      nvim-surround
    ];

    initLua = ''
      local actions = require("telescope.actions")
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        },
        defaults = {
          prompt_prefix = "",
          entry_prefix = " ",
          selection_caret = " ",
          layout_config = {
            prompt_position = 'bottom',
            width = 0.7,
            height = 0.7,
            preview_width = 0.6,
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous
            },
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")

      -- LSP Configuration with new vim.lsp.config API
      -- Common LSP keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local bufopts = { noremap=true, silent=true, buffer=bufnr }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
        end,
      })

      -- Configure LSP servers using new API
      vim.lsp.config('gopls', {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true
            }
          }
        }
      })

      vim.lsp.config('yamlls', {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
        root_markers = { '.git' },
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*/action.yml",
              ["https://json.schemastore.org/ansible-stable-2.9.json"] = "/roles/tasks/*.{yml,yaml}",
              ["https://json.schemastore.org/prettierrc.json"] = "/.prettierrc.{yml,yaml}",
              ["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
              ["https://json.schemastore.org/chart.json"] = "/Chart.{yml,yaml}",
              ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/**/*.{yml,yaml}",
            },
          },
        },
      })

      vim.lsp.config('nil_ls', {
        cmd = { 'nil' },
        filetypes = { 'nix' },
        root_markers = { 'flake.nix', 'flake.lock', '.git' },
        settings = {
          ['nil'] = {
            formatting = {
              command = { 'nixpkgs-fmt' },
            },
          },
        },
      })

      -- Enable LSP servers
      vim.lsp.enable({ 'gopls', 'nil_ls', 'pyright', 'yamlls' })
      local blink = require("blink.cmp")
      blink.setup {
        keymap = { preset = "super-tab" },
        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
          accept = {
            auto_brackets = {
              enabled = true,
              kind_resolution = {
                blocked_filetypes = { "typescriptreact", "javascriptreact" },
              },
            },
          },
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
            },
          },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          providers = {
            lsp = {
              name = "LSP",
              module = "blink.cmp.sources.lsp",
              enabled = true,
              score_offset = 90,
            },
            path = {
              name = "Path",
              module = "blink.cmp.sources.path",
              score_offset = 3,
              opts = {
                trailing_slash = false,
                label_trailing_slash = true,
                get_cwd = function(context) return vim.fn.expand(("#%d:p:h"):format(context.bufnr)) end,
                show_hidden_files_by_default = false,
              }
            },
            snippets = {
              name = "Snippets",
              module = "blink.cmp.sources.snippets",
              score_offset = 85,
            },
            buffer = {
              name = "Buffer",
              module = "blink.cmp.sources.buffer",
              score_offset = 5,
            },
          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        signature = { enabled = false },
      }

      local snacks = require("snacks")
      snacks.setup {
          bigfile = { enabled = false },
          bufdelete = { enabled = true },
          dashboard = { enabled = false },
          explorer = {
            enabled = true,
            replace_netrw = true,
          },
          indent = {
            enabled = false,
            only_scope = true,
          },
          input = {
            enabled = true,
            position = float,
            border = rounded,
            title_pos = center,
          },
          notifier = {
            enabled = true,
            timeout = 3000,
          },
          picker = {
            enabled = true,
            win = {
              input = {
                keys = {
                  ["<Esc>"] = { "close", mode = { "n", "i" } },
                },
              },
            },
          },
          quickfile = { enabled = true },
          scope = { enabled = true },
          scroll = { enabled = false },
          statuscolumn = { enabled = false },
          words = { enabled = true },
          styles = {
            notification = {
              -- wo = { wrap = true } -- Wrap notifications
            }
          },
      }

      local noice = require("noice")
      noice.setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        cmdline = {
            view = "cmdline",
            format = {
              cmdline = { icon = ":" },
            },
        },
      }

      local lspsaga = require("lspsaga")
      lspsaga.setup {
        lightbulb = {
          enable = false
        }
      }

      require("fleet-theme").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })

      require("nvim-surround").setup({})

      vim.g.mapleader = ' ' -- Space
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-y>', ':Telescope yaml_schema<CR>', {})
      vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
      vim.keymap.set('n', '<leader>gs', builtin.grep_string, {})
      vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})

      vim.keymap.set('n', '-', function() require("snacks").picker.files() end, {})
      vim.keymap.set('n', '<C-f>', function() Snacks.picker.smart() end, {})
      vim.keymap.set('n', '<C-b>', function() Snacks.picker.buffers() end, {})
      vim.keymap.set('n', '<C-s>', function() Snacks.picker.grep() end, {})
      vim.keymap.set('n', '<C-p>', function() Snacks.picker.git_files() end, {})
      vim.keymap.set('n', '<C-g>', function() Snacks.picker.lsp_symbols() end, {})

      -- Diagnostics
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Previous error" })
      vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })

      vim.keymap.set('n', '<Leader>e', function() Snacks.explorer() end, { desc = "Toggle file explorer" })
      vim.keymap.set('n', '<Leader><space>', ':nohlsearch<CR>')
      vim.keymap.set('n', '<Leader>tn', ':tabnext<CR>')
      vim.keymap.set('n', '<Leader>tp', ':tabprevious<CR>')
      vim.keymap.set('n', '<Leader>bd', function() Snacks.bufdelete() end, { desc = "Delete buffer" })
      vim.keymap.set('n', '<Leader>bo', function() Snacks.bufdelete.other() end, { desc = "Delete other buffers" })
      local mode_names = {n='N',i='I',v='V',V='VL',['\22']='VB',c='C',R='R',s='S',S='SL',['\19']='SB',t='T'}
      function _G.stl_mode() return mode_names[vim.fn.mode()] or '?' end
      vim.o.statusline = " %{v:lua.stl_mode()} [%n] %.40F %<%m%r%y %= %-5(%l:%c%V%) %P "

      -- Auto-switch theme based on macOS appearance (Tahoe 26 with Auto mode support)
      local function set_theme_from_system()
        -- Use AppleScript which works even when Auto mode is enabled
        local result = vim.fn.system("osascript -e 'tell application \"System Events\" to tell appearance preferences to get dark mode'")

        if result:match("true") then
          vim.o.background = 'dark'
          vim.cmd('hi clear')
          vim.cmd('colorscheme fleet')
        else
          vim.o.background = 'light'
          vim.cmd('hi clear')
          vim.cmd('colorscheme github_light')
        end
      end

      -- Set theme on startup
      set_theme_from_system()

      -- Auto-update when focus returns to Neovim
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = set_theme_from_system,
      })

      -- Manual refresh command
      vim.api.nvim_create_user_command('RefreshTheme', set_theme_from_system, {})
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.showmatch = true
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.swapfile = false
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.mouse = ""
      vim.opt.hlsearch = true
      vim.opt.incsearch = true
      vim.opt.modelines = 5
      vim.opt.signcolumn = "no"
      vim.opt.statuscolumn = "%=%s%C%l "
      vim.deprecate = function() end
      vim.opt.laststatus=3
    '';
  };
}
