return {
  "dmtrKovalenko/fff.nvim",
  -- For NixOS/macOS with Nix, use the nix build command
  build = "nix run .#release",
  -- For non-Nix systems:
  -- build = function()
  --   require("fff.download").download_or_build_binary()
  -- end,
  opts = { -- (optional)
    debug = {
      enabled = true, -- we expect your collaboration at least during the beta
      show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
    },
    preview = {
      line_numbers = true,
    },
  },
  -- No need to lazy-load with lazy.nvim.
  -- This plugin initializes itself lazily.
  lazy = false,
  keys = {
    {
      "ff", -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
  },
}
