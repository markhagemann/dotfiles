local status_ok, nvim_numbertoggle = pcall(require, "nvim-numbertoggle")
if not status_ok then
  return
end

nvim_numbertoggle.setup{}
