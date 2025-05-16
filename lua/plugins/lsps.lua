return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lspconfig = require("lspconfig")

      local servers = {
        bashls = true,
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              gofumpt = true,
              staticcheck = true,
              buildFlags = { "-tags", "build wireinject" },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        lua_ls = true,
        rust_analyzer = true,
        svelte = true,
        templ = true,
        cssls = true,
        html = {
          filetypes = {
            "html",
            "templ",
          },
        },
        -- htmx = {
        --   filetypes = {
        --     "templ",
        --   },
        -- },
        ts_ls = true,
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        ocamllsp = {
          manual_install = true,
          settings = {
            codelens = { enable = true },
            inlayHints = { enable = true },
          },

          filetypes = {
            "ocaml",
            "ocaml.interface",
            "ocaml.menhir",
            "ocaml.cram",
          },

          -- TODO: Check if i still need the filtypes stuff i had before
        },

        clangd = {
          -- TODO: Could include cmd, but not sure those were all relevant flags.
          --    looks like something i would have added while i was floundering
          init_options = { clangdFileStatus = true },
          filetypes = { "c" },
        },
      }

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "stylua",
        "lua_ls",
        "delve",
        "ts_ls",
        "gopls",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

          vim.keymap.set(
            "n",
            "gI",
            "<CMD>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>",
            { noremap = true, silent = true }
          )

          vim.keymap.set(
            "n",
            "gd",
            "<CMD>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>",
            { noremap = true, silent = true }
          )

          vim.keymap.set(
            "n",
            "gr",
            "<CMD>FzfLua lsp_references jump1=true ignore_current_line=true<cr>",
            { noremap = true, silent = true }
          )

          vim.keymap.set(
            "n",
            "gy",
            "<CMD>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>",
            { noremap = true, silent = true }
          )

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end
        end,
      })

      -- Autoformatting Setup
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          templ = { "templ" },
          go = { "goimports" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   callback = function(args)
      --     require("conform").format({
      --       bufnr = args.buf,
      --       lsp_fallback = true,
      --       quiet = true,
      --     })
      --   end,
      -- })
    end,
  },
}
