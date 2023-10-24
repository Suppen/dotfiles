local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	print "Could not require ibl"
	return
end

ibl.setup {}
