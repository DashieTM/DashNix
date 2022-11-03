-- Set barbar's options
require("bufferline").setup({
  animation = true,
  auto_hide = false,
  tabpages = true,
  closable = true,
  clickable = true,
  exclude_name = { "package.json" },
  icons = true,
  icon_custom_colors = false,
  icon_separator_active = "",
  icon_separator_inactive = "",
  icon_close_tab = "",
  icon_close_tab_modified = "●",
  icon_pinned = "車",
  insert_at_end = false,
  maximum_padding = 1,
  minimum_padding = 1,
  maximum_length = 30,
  semantic_letters = true,
  letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
  no_name_title = nil,
})

local nvim_tree_events = require("nvim-tree.events")
local bufferline_api = require("bufferline.api")

local function get_tree_size()
  return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
  bufferline_api.set_offset(0)
end)

nvim_tree_events.subscribe("Resize", function()
  bufferline_api.set_offset(0)
end)

nvim_tree_events.subscribe("TreeClose", function()
  bufferline_api.set_offset(0)
end)

