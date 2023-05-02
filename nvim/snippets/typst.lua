local ls = require("luasnip")
-- some shorthands...
local s = ls.s
local i = ls.i
local t = ls.t
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {}
local group = vim.api.nvim_create_augroup("Tex Snippets", { clear = true })
local file_pattern = "*.typst"
------------------------------------------------- boilerplate end
-- snippers go here:

local colorSnippet = s(
	"tx-",
	fmt(
  [[ #text({1})[{2}] ]],
		{
			i(1, "color"),
			i(2, "text"),
		}
	)
)
table.insert(snippets, colorSnippet)

local imageSnippet = s(
  "image-",
  fmt(
    [[
    #image("{1}", width: {2}%)
    ]],
    {
      i(1, "image"),
      i(2, "width"),
    }
  )
)
table.insert(snippets, imageSnippet)

------------------------------------------------- snippets end
return snippets, autosnippets
