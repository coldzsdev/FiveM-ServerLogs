local webhookUrl = "https://discordapp.com/api/webhooks/xxxxxxxxxx/yyyyyyyyyyyyyyyyyyyyyyyyyyyyy" -- Daj tu swojego webhooka, na który chcesz, żeby przychodziły logi.

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
    deferrals.defer()
    deferrals.update("Sprawdzanie poziomu dostępu...")
    deferrals.update("Sprawdzanie historii banów...")
    deferrals.done()
    -- Logowanie do webhooka
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = "Serwer FiveM",
        content = "**" .. name .. "** dołączył do serwera."
    }), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerDropped", function(reason)
    -- Logowanie do webhooka
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = "Serwer FiveM",
        content = "**" .. GetPlayerName(source) .. "** opuścił serwer. Powód: " .. reason
    }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("playerKilled")
AddEventHandler("playerKilled", function(killer, weapon)
    -- Logowanie do webhooka
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = "Serwer FiveM",
        content = "**" .. GetPlayerName(killer) .. "** zabił **" .. GetPlayerName(source) .. "**. Broń: " .. weapon .. ". Dystans: " .. math.floor(GetDistanceBetweenCoords(GetEntityCoords(killer), GetEntityCoords(source), true)) .. " m"
    }), { ['Content-Type'] = 'application/json' })
end)
