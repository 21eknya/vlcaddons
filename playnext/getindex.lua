--[[
 Play Next, testing version

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
--]]

--[[ Extension description ]]



	function descriptor()
		return { title = "get index" ;
				 version = "alpha" ;
				 author = "khu" ;
				 shortdesc = "get index.";
				 description = "<h1>Get Index</h1>";
				 capabilities = { "input-listener", "meta-listener" } }
	end

--[[ Global vars ]]
	path = nil
	target = nil


--[[ Hooks ]]

	-- Activation hook
	function activate()
		vlc.msg.dbg("[Get Index] Activated")
		start()
	end

	-- Deactivation hook
	function deactivate()
		vlc.msg.dbg("[Get Index] Deactivated")
	end


--[[ Start ]]

	function start()
		item = vlc.item or vlc.input.item() -- check if an item is playing
		if not item then -- return an alert box explaining what the user should do
			vlc.msg.dbg("[Get Index] No item has been selected.")
		else	
                        vlc.msg.dbg("[Get Index] Index: "..vlc.playlist.current())
                        vlc.msg.dbg("[GI] getnormal:"..#vlc.playlist.get("normal", false).children)

		end
	end




function alert(title,message)
	local dialog = vlc.dialog("Get Index")
	dialog:add_label("<h2>"..title.."</h2>", 1, 1, 5, 10)
    dialog:add_label(message, 1, 14, 5, 5, 200)
    dialog:add_button("OK", function () dialog:delete() vlc.deactivate(); return nil end, 3, 20, 1, 5)
end

function close() -- when the messagebox is closed
    vlc.deactivate()
end

-- Splits a string into a table, based on a patterns (from: http://http://lua-users.org/wiki/SplitJoin )

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t,cap)
   end
   return t
end


function tostr(obj)
    if type(obj) == "table" then
        return table.concat(obj, "|")
    end
    return obj
end

