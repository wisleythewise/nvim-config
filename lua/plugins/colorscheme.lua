return {
  -- Rose Pine colorscheme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "main",
      styles = {
        bold = false,  -- Disable all bold
        italic = true,
        transparency = false,
      },
      highlight_groups = {
        -- Pure black background
        Normal = { bg = "#000000" },
        NormalFloat = { bg = "#000000" },
        NormalNC = { bg = "#000000" },
        SignColumn = { bg = "#000000" },
        LineNr = { bg = "#000000", fg = "#3a3a3a" },               -- Subtle dark gray line numbers
        CursorLineNr = { bg = "#000000", fg = "#4a4a4a" },         -- Slightly brighter for current line
        EndOfBuffer = { bg = "#000000" },


        -- Variables (BRIGHT for colorblind visibility)
        ["@variable"] = { fg = "#00ffff" },                        -- Normal variables: BRIGHT cyan
        ["@variable.builtin"] = { fg = "#ff6b9d" },                -- self, cls: bright pink/red (different!)
        ["@variable.parameter"] = { fg = "#00ffff" },              -- Function parameters: BRIGHT cyan
        ["@variable.member"] = { fg = "#00ffff" },                 -- Object properties: BRIGHT cyan

        -- Functions
        ["@function"] = { fg = "gold" },                           -- Function definitions: yellow
        ["@function.builtin"] = { fg = "gold" },                   -- Built-in functions: yellow
        ["@function.call"] = { fg = "gold" },                      -- Function calls: yellow
        ["@function.method"] = { fg = "gold" },                    -- Method definitions: yellow
        ["@function.method.call"] = { fg = "gold" },               -- Method calls: yellow

        -- Classes and Types (softer but still visible)
        ["@type"] = { fg = "#b695ff" },                            -- Type hints: soft purple
        ["@type.builtin"] = { fg = "#b695ff" },                    -- Built-in types: soft purple
        ["@constructor"] = { fg = "#b695ff" },                     -- Class instantiation: soft purple
        ["@class"] = { fg = "#b695ff" },                           -- Class definition: soft purple

        -- Keywords
        ["@keyword"] = { fg = "pine", italic = true },             -- Keywords: green italic
        ["@keyword.function"] = { fg = "pine", italic = true },    -- def, async: green italic
        ["@keyword.return"] = { fg = "pine", italic = true },      -- return: green italic
        ["@keyword.operator"] = { fg = "pine" },                   -- and, or, not: green

        -- Constants and literals
        ["@constant"] = { fg = "gold" },                           -- Constants: gold
        ["@constant.builtin"] = { fg = "gold" },                   -- True, False, None: gold
        ["@string"] = { fg = "gold" },                             -- Strings: gold
        ["@string.documentation"] = { fg = "#6e6e6e", italic = true }, -- Docstrings: light grey italic
        ["@number"] = { fg = "gold" },                             -- Numbers: gold
        ["@boolean"] = { fg = "rose" },                            -- Booleans: pink

        -- Properties and fields
        ["@property"] = { fg = "foam" },                           -- Properties: cyan
        ["@field"] = { fg = "foam" },                              -- Fields: cyan

        -- Decorators
        ["@decorator"] = { fg = "iris", italic = true },           -- @dataclass: purple italic
        ["@attribute"] = { fg = "iris" },                          -- Attributes: purple

        -- Comments
        Comment = { fg = "#6e6e6e", italic = true },               -- Standard vim comments: light grey italic
        ["@comment"] = { fg = "#6e6e6e", italic = true },          -- Treesitter comments: light grey italic
      },
    },
  },

  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
