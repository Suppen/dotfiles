local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	print "Failed to load ibl"
	return
end

ibl.setup {}
