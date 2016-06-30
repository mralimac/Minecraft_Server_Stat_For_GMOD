local CATEGORY_NAME = "Minecraft Commands"
local serverip = "192.00.00.01" --Define your server IP here
local serverport = "25565" --Define your server Port here
function ulx.minecraft(ply)
--Where the magic happens--
--Calls the URL to get the status of the minecraft server
  http.Fetch("http://api.fhrnet.eu/mc/"..serverip.."/"..serverport.."/newinfo?method=json",
    function(body)
    --Puts it into a JSON table--
    local body = util.JSONToTable(body)
    --If we don't get a valid response then an error message is displayed--
      if not body or not body.players or not body.players.online then
        error(string.format("Minecraft Server Information could not be retrieved"))
      end
    --Assigns the playercount to the "players" value--
    local players = body.players.online
	--Assigns the max number of players to the "maxplayers" value--
	local maxplayers = body.players.max
	--Assigns the server description to the "description" value--
	local description = body.description.text
	--Displays the server information to the player who typed the command--
	ply:ChatPrint("Server Name: "..description.."\nServer IP:"..serverip..":"..serverport.."\nPlayers: "..players.."/"..maxplayers)
    end,
  function(error)
  end
)
end

--Simply adds the command, generic ULib/ULX stuff--
local minecraft = ulx.command(CATEGORY_NAME, "ulx minecraft", ulx.minecraft, "!mc", true)
minecraft:defaultAccess(ULib.ACCESS_ALL)
minecraft:help("Gets Minecraft Server Information")
