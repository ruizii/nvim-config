return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.highlight = {
        enable = true,
    }

    opts.ensure_installed = {
      "lua",
      "vim",
      "bash",
      "c",
      "cpp",
      "css",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "toml",
      "typescript",
      "vimdoc",
    }
  end,
}
