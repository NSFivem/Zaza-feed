



local weapons = {
	[-1569615261] = 'weapon_unarmed',
	[1593441988] = 'weapon_combatpistol',
	[584646201] = 'weapon_appistol'
}


local isDead = false

Citizen.CreateThread(function()
    while true do
		local killed = GetPlayerPed(PlayerId())
		local killedCoords = GetEntityCoords(killed)

		if IsEntityDead(killed) and not isDead then
            local killer = GetPedKiller(killed)
            if killer ~= 0 and killer == killed then
					TriggerServerEvent('KillFeed:Died', killedCoords)
				else
					local KillerNetwork = NetworkGetPlayerIndexFromPed(killer)

					if KillerNetwork == "**Invalid**" or KillerNetwork == -1 then
						TriggerServerEvent('KillFeed:Died', killedCoords)
					else
						TriggerServerEvent('KillFeed:Killed', GetPlayerServerId(KillerNetwork), hashToWeapon(GetPedCauseOfDeath(killed)), killedCoords)
					end
                end
            else
				TriggerServerEvent('KillFeed:Died', killedCoords)
            end
            isDead = true
        end
		if not IsEntityDead(killed) then
			isDead = false
		end
        Citizen.Wait(50)
end)



 
   function Distance(whateverplayer)
		 print("killer entity" ..whateverplayer.. " --  "..GetEntityCoords(GetPlayerPed(whateverplayer)))
		 print("me --" ..GetEntityCoords(PlayerPedId()))
	  local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(whateverplayer)), GetEntityCoords(PlayerPedId()),true)    
	  return distance
   end
 
--    RegisterCommand("get", function()
-- 	local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(whateverplayer)), GetEntityCoords(PlayerPedId()),true) 
-- 	print(distance)
--    end)

RegisterNetEvent('KillFeed:AnnounceKill')
AddEventHandler('KillFeed:AnnounceKill', function(killed, killer, weapon, coords, distance)

		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(whateverplayer)), GetEntityCoords(PlayerPedId()),true) 
		local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if coords ~= nil and distance ~= nil and myLocation ~= nil and config.prox_enabled then
			if #(myLocation - coords) < config.prox_range then
				-- print("Distance was " .. distance, myLocation)
				SendNUIMessage({
					type = 'newKill',
					killer = killer,
					killed = killed,
					weapon = weapon,
					distance = distance
				})
			end
		else
			SendNUIMessage({
				type = 'newKill',
				killer = killer,
				killed = killed,
				weapon = weapon,
				distance = distance
			})
	end
end)

RegisterNetEvent('KillFeed:AnnounceDeath')
AddEventHandler('KillFeed:AnnounceDeath', function(killed, coords)
		if coords ~= nil and config.prox_enabled then
			local myLocation = GetEntityCoords(GetPlayerPed(PlayerId()))
			if #(myLocation - coords) < config.prox_range then
				SendNUIMessage({
					type = 'newDeath',
					killed = killed,
				})
			end
		else
			SendNUIMessage({
				type = 'newDeath',
				killed = killed,
			})
		end
end)

function hashToWeapon(hash)
	if weapons[hash] ~= nil then
		return weapons[hash]
	else
		return 'weapon_unarmed'
	end
end



RegisterCommand("testfeed", function()
	TriggerEvent("KillFeed:AnnounceKill","NS100","NS100","weapon_appistol")
	
	end)

