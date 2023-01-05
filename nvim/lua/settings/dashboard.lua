local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[ _______       ___           _______. __    __   __   _______ ]],
  [[|       \     /   \         /       ||  |  |  | |  | |   ____|]],
  [[|  .--.  |   /  ^  \       |   (----`|  |__|  | |  | |  |__   ]],
  [[|  |  |  |  /  /_\  \       \   \    |   __   | |  | |   __|  ]],
  [[|  '--'  | /  _____  \  .----)   |   |  |  |  | |  | |  |____ ]],
  [[|_______/ /__/     \__\ |_______/    |__|  |__| |__| |_______|]]
}
dashboard.section.buttons.val = {
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("b", "  Open File Browser", ":Telescope file_browser<CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", "  Find project", ":Telescope project <CR>"),
  dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", "  Zoxide", ":Telescope zoxide list <CR>"),
  dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
  return "dashie@dashie.org"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
