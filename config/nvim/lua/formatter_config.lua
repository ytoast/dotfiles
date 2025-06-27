local format = require("formatter")

format.setup(
  {
    filetype = {
      python = {
        function()
          return {
            exe = "black",
            args = {"-"},
            stdin = true
          }
        end
      },
      terraform = {
        function()
          return {
            exe = "terraform",
            args = {"fmt", "-"},
            stdin = true
          }
        end
      },
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- Removed duplicate keybinding since <space>f is now handled in LSP config
