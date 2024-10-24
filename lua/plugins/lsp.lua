return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
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
              group_index = 0, -- set to 0 to skip loading LuaLS completions
            })
          end,
        },
      },
    },

    config = function ()

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)

          local function map(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          assert(client, "LSP client not found")
          ---@diagnostic disable-next-line: inject-field
          client.server_capabilities.document_formatting = true

          map("<leader>K", vim.lsp.buf.hover, "[K] hover documentation")
          map("<leader>gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
          map("<leader>gD", vim.lsp.buf.type_definition, "[g]o to type [D]efinition")
          map("<leader>gS", vim.lsp.buf.document_symbol, "[g]o to [S]ymbols")
          map("<leader>gh", vim.lsp.buf.signature_help, "[g]o to signature [h]elp")
          map("<leader>gI", vim.lsp.buf.implementation, "[g]o to [I]mplementation")
          map("<leader>gr", vim.lsp.buf.references, "[g]o to [r]eferences")
          map("<leader>[d", function() vim.diagnostic.jump({ count = 1 }) end, "previous [d]iagnostic ")
          map("<leader>]d", function() vim.diagnostic.jump({ count = -1 }) end, "next [d]iagnostic ")
          map("<leader>le", function() vim.diagnostic.open_float() end, "[L]sp [E]xplain")
          map("<leader>ca", function() vim.lsp.buf.code_action() end, "[C]ode [A]ction")
          map("<leader>lR", vim.lsp.buf.rename, "[l]sp [R]ename")
          map("<leader>lq", vim.diagnostic.setqflist, "[l]sp diagnostic [q]uickfix")


          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = event2.buf }
              end,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local util = require("lspconfig.util")

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "solid" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "solid" })

      local servers = {

        pylsp = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        lua_ls = {
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
                disable = { "trailing-space", "missing-fields" },
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
        },
        rust_analyzer = {
          capabilities = capabilities,
          flags = lsp_flags,
          settings = {
            ["rust-analyzer"] = {
              diagnostics = { enable = false; }
            },
          },
        },
        gopls = {
          capabilities = capabilities,
          flags = lsp_flags,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpls" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
              usePlaceholders = true,
            }
          }
        },
        -- gopls = {
        --   capabilities = capabilities,
        --   flags = lsp_flags,
        --   settings = {
        --     gopls = {
        --       analyses = {
        --         unusedparams = true,
        --       },
        --       staticcheck = true,
        --       gofumpt = true,
        --       usePlaceholders = true,
        --     }
        --   }
        -- },
        jsonls = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        yamlls = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        taplo = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        zls = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        bashls = {
          capabilities = capabilities,
          flags = lsp_flags,
        },
        vimls = {
          capabilities = capabilities,
          flags = lsp_flags,
        }

      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "ruff",
        "mypy",
        "shfmt",
        "gofumpt",
        -- "goimports",
        -- "golangci-lint",
        -- "sqlls",
        -- "dadbod?"
      })

      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        automatic_installation = true,
        handlers = {
          function (server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

}
