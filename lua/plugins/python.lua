return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          capabilities = {
            workspace = {
              fileOperations = {
                willRename = true,
              },
            },
          },
        },
        ruff = {},
      },
    },
  },
}

