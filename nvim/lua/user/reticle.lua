local status_ok, reticle = pcall(require, "reticle")
if not status_ok then
  return
end


require('reticle').setup {
  on_startup = {
        cursorline = true, 
        cursorcolumn = true,
    },
  disable_in_insert = true,
  always_highlight_number = false,
}
