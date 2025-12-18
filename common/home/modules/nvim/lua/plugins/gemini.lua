return {
  "jonroosevelt/gemini-cli.nvim",
  enabled = false, -- Deshabilitado: requiere @google/generative-ai-cli instalado globalmente via npm
  config = function()
    require("gemini").setup()
  end,
}
