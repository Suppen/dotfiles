local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print "Failed to load lualine"
	return
end

lualine.setup()
