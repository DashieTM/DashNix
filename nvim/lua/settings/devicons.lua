local status_ok , _ = pcall (require, "nvim-web-devicons")
if not status_ok then
	return
end

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };

 default = true;
}
 
require'nvim-web-devicons'.get_icons()
