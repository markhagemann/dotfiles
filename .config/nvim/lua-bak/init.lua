local HOME = os.getenv("HOME")
package.path = package.path .. ";" .. HOME .. "/luarocks/share/lua/5.2/?.lua"
package.cpath = package.cpath .. ";" .. HOME .. "/luarocks/lib/lua/5.2/?.so"

require "lsp"
require "treesitter"
