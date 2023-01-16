ESX = nil
local Vehicles = {}
local PlayerData = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

	ESX.TriggerServerCallback('pd-changecolor:getVehiclesPrices', function(vehicles)
		Vehicles = vehicles
	end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('pd-changecolor:installMod')
AddEventHandler('pd-changecolor:installMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	myCar = ESX.Game.GetVehicleProperties(vehicle)
	TriggerServerEvent('pd-changecolor:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('pd-changecolor:cancelInstallMod')
AddEventHandler('pd-changecolor:cancelInstallMod', function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (GetPedInVehicleSeat(vehicle, -1) ~= PlayerPedId()) then
		 vehicle = GetPlayersLastVehicle(PlayerPedId())
	end
		ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName,
	{
		title    = menuTitle,
		align    = 'bottom-right',
		elements = elems
	}, function(data, menu)
		local isRimMod, found = false, false
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

		if data.current.modType == "modFrontWheels" then
			isRimMod = true
		end

		for k,v in pairs(Config.Menus) do

			if k == data.current.modType then

				if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
					ESX.ShowNotification(_U('already_own', data.current.label))
					TriggerEvent('pd-changecolor:installMod')
				else
					local vehiclePrice = 50000

					for i=1, #Vehicles, 1 do
						if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
							vehiclePrice = Vehicles[i].price
							break
						end
					end

					if isRimMod then
                    print("test")
					else
						price = math.floor(vehiclePrice * v.price / 100)
						TriggerServerEvent('pd-changecolor:buyMod', price)
					end
				end

				menu.close()
				found = true
				break
			end

		end

		if not found then
			GetAction(data.current)
		end
	end, function(data, menu) -- on cancel
		menu.close()
		TriggerEvent('pd-changecolor:cancelInstallMod')

		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if parent == nil then
			lsMenuIsShowed = false
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			FreezeEntityPosition(vehicle, false)
			myCar = {}
		end
	end, function(data, menu) -- on change
		UpdateMods(data.current)
	end)
end

function UpdateMods(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

	if data.modType then
		local props = {}
		props[data.modType] = data.modNum
		ESX.Game.SetVehicleProperties(vehicle, props)
	end
end

function GetAction(data)
	local elements  = {}
	local menuName  = ''
	local menuTitle = ''
	local parent    = nil

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local currentMods = ESX.Game.GetVehicleProperties(vehicle)

	local vehiclePrice = 50000

	for i=1, #Vehicles, 1 do
		if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
			vehiclePrice = Vehicles[i].price
			break
		end
	end

	for k,v in pairs(Config.Menus) do

		if data.value == k then

			menuName  = k
			menuTitle = v.label
			parent    = v.parent

			if v.modType then

				if v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				end
			else
				if data.value == 'primaryRespray' or data.value == 'secondaryRespray' or data.value == 'pearlescentRespray' or data.value == 'modFrontWheelsColor' then
					for i=1, #Config.Colors, 1 do
						if data.value == 'primaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color1', color = Config.Colors[i].value})
						elseif data.value == 'secondaryRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'color2', color = Config.Colors[i].value})
						elseif data.value == 'pearlescentRespray' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'pearlescentColor', color = Config.Colors[i].value})
						elseif data.value == 'modFrontWheelsColor' then
							table.insert(elements, {label = Config.Colors[i].label, value = 'wheelColor', color = Config.Colors[i].value})
						end
					end
				else
					for l,w in pairs(v) do
						if l ~= 'label' and l ~= 'parent' then
							table.insert(elements, {label = w, value = l})
						end
					end
				end
			end
			break
		end
	end

	table.sort(elements, function(a, b)
		return a.label < b.label
	end)

	OpenLSMenu(elements, menuName, menuTitle, parent)
end



-- Activate menu when player is inside marker
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local coords = GetEntityCoords(PlayerPedId())
			local currentZone, zone, lastZone

			if (PlayerData.job and PlayerData.job.name == 'mechanic') or not Config.IsMechanicJobOnly then
				for k,v in pairs(Config.Zones) do
					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x and not lsMenuIsShowed then
						isInLSMarker  = true
						ESX.ShowHelpNotification(v.Hint)
						break
					else
						isInLSMarker  = false
					end
				end
			end

			if IsControlJustReleased(0, 38) and not lsMenuIsShowed and isInLSMarker then
				if (PlayerData.job and PlayerData.job.name == 'mechanic') or not Config.IsMechanicJobOnly then
					lsMenuIsShowed = true

					local vehicle = GetVehiclePedIsIn(playerPed, false)
					FreezeEntityPosition(vehicle, true)

					myCar = ESX.Game.GetVehicleProperties(vehicle)

					ESX.UI.Menu.CloseAll()
					GetAction({value = 'main'})
				end
			end

			if isInLSMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
			end

			if not isInLSMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
			end

		end
	end
end)]]




Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = '<b>[E] to change colors</b>'
    while true do
		wait = 0
		local ped = PlayerPedId()
		local inZone = false
		for cd = 1, #Config.Locations do
			local dist = #(GetEntityCoords(ped)-vector3(Config.Locations[cd].x, Config.Locations[cd].y, Config.Locations[cd].z))
			if dist <= 2.0 and IsPedInAnyVehicle(GetPlayerPed(-1), false) and PlayerData.job and PlayerData.job.name == 'mechanic' then
				wait = 0
				inZone = true

				if IsControlJustReleased(0, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) and PlayerData.job and PlayerData.job.name == 'mechanic' then
					TriggerEvent('cd_drawtextui:HideUI')
					TriggerEvent('pd-colorchanger:respray')
				end

				break
			else
				wait = 0
			end
		end

		if inZone and not alreadyEnteredZone then
			alreadyEnteredZone = true
			TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
		end

		if not inZone and alreadyEnteredZone then
			alreadyEnteredZone = false
			ESX.UI.Menu.CloseAll()
			TriggerEvent('cd_drawtextui:HideUI')
		end
		
		Citizen.Wait(wait)
    end
end)


RegisterNetEvent('pd-colorchanger:respray')
AddEventHandler('pd-colorchanger:respray', function()

        lsMenuIsShowed1 = true
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		myCar = ESX.Game.GetVehicleProperties(vehicle)
        FreezeEntityPosition(vehicle, true)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'main'
        })
end)