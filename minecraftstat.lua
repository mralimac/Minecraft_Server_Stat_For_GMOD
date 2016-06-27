local CATEGORY_NAME = "Minecraft Commands"
function ulx.minecraft(ply)
  
  
  
local serverip = "192.00.00.001" --Define your server IP here
local serverport = "25565" --Define your server Port here


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
    --Outputs the player count to the user who wrote the command--
    ply:ChatPrint("There is currently "..players.." Players on the minecraft server")
    end,
  function(error)
  end
)
end

--Simply adds the command, generic ULib/ULX stuff--
local minecraft = ulx.command(CATEGORY_NAME, "ulx minecraft", ulx.minecraft, "!minecraft", true)
minecraft:addParam{ type=ULib.cmds.PlayerArg}
minecraft:defaultAccess(ULib.ACCESS_ALL)
minecraft:help("Gets Minecraft Server Status")
