local status_ok, typescript = pcall(require, "typescript")
if not status_ok then
	print "Could not require typescript"
	return
end

typescript.setup {}
