local status_ok, _ = pcall(require, "feline")
if not status_ok then
	return
end


require('feline').setup()
--require('feline').winbar.setup()
