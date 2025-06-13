return {
  -- Hihglight colors
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {},
  },
  {
    "telescope.nvim",
    priority = 1000,
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        ";f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            -- hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep()
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "\\\\",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { 
          prompt_position = "top",
          width = 0.75,
          height = 0.75,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.DS_Store",
        },
        mappings = {
          n = {},
          i = {
            ["<C-h>"] = "which_key",
            ["<esc>"] = actions.close,
          },
        },
      })
      opts.pickers = {
        hidden = false,
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },

  -- Legendary.nvim - Fast keymap search and command palette
  {
    "mrjones2014/legendary.nvim",
    version = "v2.13.9",
    priority = 10000,
    lazy = false,
    dependencies = { "kkharji/sqlite.lua" },
    keys = {
      {
        "<leader>p",
        "<cmd>Legendary<cr>",
        desc = "Open Legendary (Keymap Search)",
      },
      {
        "<C-p>",
        "<cmd>Legendary<cr>",
        desc = "Open Legendary (Keymap Search)",
      },
    },
    opts = {
      -- Include keymaps created by lazy.nvim key mappings
      include_builtin = true,
      include_legendary_cmds = true,
      -- Automatically register which-key.nvim keymaps
      extensions = {
        lazy_nvim = true,
        which_key = {
          auto_register = true,
        },
      },
      -- Custom keymaps, commands, and functions
      keymaps = {
        {
          "<leader>fk",
          "<cmd>Legendary keymaps<cr>",
          description = "Search keymaps only",
        },
        {
          "<leader>fc",
          "<cmd>Legendary commands<cr>",
          description = "Search commands only",
        },
        {
          "<leader>ff",
          "<cmd>Legendary functions<cr>",
          description = "Search functions only",
        },
      },
    },
    config = function(_, opts)
      require("legendary").setup(opts)
    end,
  },
}
