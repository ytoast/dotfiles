local conf = {
    -- For customization, refer to Install > Configuration in the Documentation/Readme
  debug = true,

	providers = {
		openai = {
			endpoint = "https://api.openai.com/v1/chat/completions",
      -- secret = { "bw", "get", "password", "OAI_API_KEY" },
			-- secret = os.getenv("OPENAI_API_KEY"),
		},

		-- azure = {...},

		-- copilot = {
		-- 	endpoint = "https://api.githubcopilot.com/chat/completions",
		-- 	secret = {
		-- 		"bash",
		-- 		"-c",
		-- 		"cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
		-- 	},
		-- },

		-- pplx = {
		-- 	endpoint = "https://api.perplexity.ai/chat/completions",
		-- 	secret = os.getenv("PPLX_API_KEY"),
		-- },

		-- ollama = {
		-- 	endpoint = "http://localhost:11434/v1/chat/completions",
		-- },

		-- googleai = {
		-- 	endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
		-- 	secret = os.getenv("GOOGLEAI_API_KEY"),
		-- },

		-- anthropic = {
		-- 	endpoint = "https://api.anthropic.com/v1/messages",
		-- 	secret = os.getenv("ANTHROPIC_API_KEY"),
		-- },
	},


	-- agents = {
	-- 	{
	-- 		name = "ChatGPT3-5",
	-- 		disable = false,
	-- 	},
	-- 	{
	-- 		name = "MyCustomAgent",
	-- 		provider = "copilot",
	-- 		chat = true,
	-- 		command = true,
	-- 		model = { model = "gpt-4-turbo" },
	-- 		system_prompt = "Answer any query with just: Sure thing..",
	-- 	},
	-- },

}
require("gp").setup(conf)
