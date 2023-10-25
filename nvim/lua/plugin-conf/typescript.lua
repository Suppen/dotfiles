local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	print "Failed to load typescript"
	return
end

typescript.setup {}
