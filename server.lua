RegisterNetEvent('KillFeed:Killed')
AddEventHandler('KillFeed:Killed',function(a,b,c)
    TriggerClientEvent('KillFeed:AnnounceKill',-1,GetPlayerName(source),GetPlayerName(a),b,c)
end)

    RegisterNetEvent('KillFeed:Died')
    AddEventHandler('KillFeed:Died',function(c)
        TriggerClientEvent('KillFeed:AnnounceDeath',-1,GetPlayerName(source),c)
    end)
