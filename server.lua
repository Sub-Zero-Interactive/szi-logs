if Config.UseESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

function SendLog(name, title, color, message, tagEveryone)      

    local tag = tagEveryone or false
    local webHook = Config.Webhooks[name] or Config.Webhooks.default
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Config.Colors[color] or Config.Colors.default,
            ['footer'] = {
                ['text'] = Config.ServerName.. " | SZI Logs | ".. os.date(),
                ['icon_url'] = Config.ServerLogo,
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = name .. ' | Logs',
                ['icon_url'] = 'https://i.imgur.com/tPccWVv.png',
            },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'Logs', content = '|| @everyone @here ||'}), { ['Content-Type'] = 'application/json' })
    end
end


------- Args -------
-- args[1] = Weebhook
-- args[2] = Color
---------------------
RegisterCommand("embed",  function(source, args, rawCommand) 
	SendLog(args[1], 'Test Webhook', args[2], 'Webhook setup successfully',false)
end, false)

if Config.DefaultEvents then
    if Config.DefaultEvents.chat then
        AddEventHandler('chatMessage', function(playerId, playerName, message)
            if Config.UseESX then
                local xPlayer = ESX.GetPlayerFromId(playerId)
                SendLog("Chat", "New Message", "green", "**ID**:```diff\n+ ".. playerId .. "```\n**OOC Name**:```diff\n+".. GetPlayerName(playerId) ..  "```\n**In-Game Name**:```diff\n+".. xPlayer.getName() .. "```\n**Message**:```diff\n- ".. message .. "```")
            else 
                SendLog("Chat", "New Message", "green", "**ID**:```diffr\n+ ".. playerId .. "```\n**Name**:```diff\n+"..playerName .. "```\n**Message**:```diff- ".. message .. "```")
            end
        end)
    end
    if Config.DefaultEvents.playerDropped then
        AddEventHandler('playerDropped', function (reason)
            if Config.UseESX then
                local xPlayer = ESX.GetPlayerFromId(source)
                SendLog("UserActions", "User Dropped", "red", "**ID**:```diff\n+ ".. source .. "```\n**OOC Name**:```diff\n+".. GetPlayerName(source) ..  "```\n**In-Game Name**:```diff\n+".. xPlayer.getName() .. "```\n**Reason**:```diff\n- ".. reason .. "```")
            else 
                SendLog("UserActions", "User Dropped", "red", "**ID**:```".. source .. "```\n**Name**:```".. GetPlayerName(source) .. "```\n**Reason**:```".. reason .. "```")
            end
        end)
    end

    if Config.DefaultEvents.playerJoining then
        AddEventHandler('playerJoining', function ()
            SendLog("UserActions", "User Joined", "green", "**ID**:```diff\n+ ".. source .. "```\n**Name**:```diff\n+ ".. GetPlayerName(source) .."```")
        end)
    end
    if Config.DefaultEvents.playerJoining then
        AddEventHandler('onResourceStart', function (resource)
            SendLog("Resources", "Resource Started", "white", "**Name**:```diff\n+ ".. resource .."```")
        end)
        AddEventHandler('onResourceStop', function (resource)
            SendLog("Resources", "Resource Stopped", "white", "**Name**:```diff\n- ".. resource .."```")
        end)
    end

end
