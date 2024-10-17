return {

  {
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      {
        {
          "folke/lazydev.nvim",
          ft = "lua",
          opts = {
            library = {
              { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
          },
        },
        { "Bilal2453/luvit-meta", lazy = true },
        {
          "hrsh7th/nvim-cmp",
          opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
              name = "lazydev",
              group_index = 0,
            })
          end,
        },
      },
      { "folke/neoconf.nvim", opts = {}, enabled = false },
    },
    config = function()
      local lspconfig = require "lspconfig"
      local util = require "lspconfig.util"

      require("mason").setup()
      require("mason-lspconfig").setup {
        automatic_installation = true,
      }
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- python
          "pyright",
          "isort",
          "jupytext",
          "ruff",
          "ruff_lsp",
          -- lua
          "stylua",
          -- shell scripts
          "shfmt",
          -- rust
          "rust_analyzer",
          "rustfmt",
          -- go
          "gopls",
          "goimports",
          "golangci-lint",
          -- sql
          "sqlls",
          -- util
          "jsonls",
          "yamlls",
          "taplo",
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local function vmap(keys, func, desc)
            vim.keymap.set("v", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")

          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          map("<leader>gS", vim.lsp.buf.document_symbol, "[g]o so [S]ymbols")
          map("<leader>gD", vim.lsp.buf.type_definition, "[g]o to type [D]efinition")
          map("<leader>gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
          map("<leader>K", vim.lsp.buf.hover, "[K] hover documentation")
          map("<leader>gh", vim.lsp.buf.signature_help, "[g]o to signature [h]elp")
          map("<leader>gI", vim.lsp.buf.implementation, "[g]o to [I]mplementation")
          map("<leader>gr", vim.lsp.buf.references, "[g]o to [r]eferences")
          map("<leader>[d", function() vim.diagnostic.jump({ count = 1 }) end, "previous [d]iagnostic ")
          map("<leader>]d", function() vim.diagnostic.jump({ count = -1 }) end, "next [d]iagnostic ")
          map("<leader>le", function() vim.diagnostic.open_float() end, "[L]sp [E]xplain")
          map("<leader>ll", vim.lsp.codelens.run, "[l]ens run")
          map("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")
          map("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          vmap("<leader>lf", vim.lsp.buf.format, "[l]sp [f]ormat")
          map("<leader>lq", vim.diagnostic.setqflist, "[l]sp diagnostic [q]uickfix")
        end,
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.marksman.setup {
        capabilities = capabilities,
        filetypes = { "markdown", "quarto" },
        root_dir = util.root_pattern(".git", ".marksman.toml", "_quarto.yml"),
      }

      lspconfig.yamlls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "",
            },
          },
        },
      }

      lspconfig.jsonls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              disable = { "trailing-space" },
            },
            workspace = {
              checkThirdParty = false,
            },
            doc = {
              privateName = { "^_" },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      }

      lspconfig.vimls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
      }

      lspconfig.bashls.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      }

      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
            }
          }
        }
      }

      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      lspconfig.pyright.setup {
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
              util.path.dirname(fname)
        end,
      }
    end,
  },
}
