return {
  -- GitHub Copilot本体
  {
    "github/copilot.vim",
    event = "VeryLazy",
  },

  -- CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("CopilotChat").setup({
        mappings = {
          reset = {
            key = false,
          },
        },
      })
    end,
    cmd = "CopilotChat",
  },

  -- Ollama (変更なし)
  {
    "nomnivore/ollama.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
    config = function()
      require("ollama").setup({
        model = "mistral",
      })
    end,
    keys = {
      { "<leader>oo", function() require("ollama").prompt() end, desc = "Ollama Prompt" },
      { "<leader>oG", function() require("ollama").prompt('Generate_Code') end, desc = "Ollama Generate Code" },
    },
  },
}
