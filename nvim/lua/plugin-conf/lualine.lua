local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	print "Could not require lualine"
	return
end

lualine.setup()
