local CATEGORY_NAME = "Generic Name"
function ulx.minecraft(calling_ply, ply)
local serverip = "192.99.149.167" --Define your server IP here
local serverport = "25602" --Define your server Port here
http.Fetch("http://api.fhrnet.eu/mc/"..serverip.."/"..serverport.."/newinfo?method=json",
function(body)
local body = util.JSONToTable(body)
if not body or not body.players or not body.players.online then
error(string.format("Minecraft Server Information could not be retrieved"))
end
local players = body.players.online
PrintTable(body)
ply:ChatPrint("There is currently "..players.." Players on the minecraft server")
end,
function(error)
end
)

end

local minecraft = ulx.command(CATEGORY_NAME, "ulx minecraft", ulx.minecraft, "!minecraft", true)

minecraft:addParam{ type=ULib.cmds.PlayerArg}
minecraft:defaultAccess(ULib.ACCESS_ALL)
minecraft:help("Gets Minecraft Server Status")