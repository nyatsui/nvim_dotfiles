return {
  -- GitHub Copilot本体
  {
    "github/copilot.vim",
    event = "VeryLazy",
  },

  -- CopilotChat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main", -- canary は廃止済み。coagent.nvim には v4 (main) が必要
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    -- coagent.nvim から裏で使うだけ（認証・通信の提供元）。
    -- 単体のチャットUIを使いたくなったら cmd = "CopilotChat" を戻す。
    lazy = true,
    config = function()
      require("CopilotChat").setup({
        mappings = {
          reset = false, -- v4 では false でマッピングを無効化
        },
      })
    end,
  },

  -- coagent.nvim（CopilotChat の認証・通信を再利用する自律エージェント）
  -- dev = true: ~/workspace/coagent.nvim があればそれを使い、無いマシンでは GitHub から取得
  {
    "nyatsui/coagent.nvim",
    dev = true,
    main = "coagent",
    dependencies = { "CopilotC-Nvim/CopilotChat.nvim" },
    cmd = {
      "Coagent", "CoagentToggle", "CoagentStop", "CoagentSessions", "CoagentMode",
      "CoagentModel", "CoagentChanges", "CoagentResume", "CoagentUsage", "CoagentProcesses",
    },
    keys = {
      { "<leader>aa", "<cmd>CoagentToggle<cr>", desc = "Coagent" },
      { "<leader>aa", ":Coagent<cr>", mode = "v", desc = "Coagent (selection)" },
      { "<leader>as", "<cmd>CoagentStop<cr>", desc = "Coagent stop" },
      { "<leader>ac", "<cmd>CoagentChanges<cr>", desc = "Coagent changes" },
    },
    opts = {
      mode = "supervised",
      model = "auto", -- Copilot Free では個別モデルを直接使えないため Auto を明示
    },
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
