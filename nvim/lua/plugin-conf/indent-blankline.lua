local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	print "Could not require indent_blankline"
	return
end

indent_blankline.setup {}
