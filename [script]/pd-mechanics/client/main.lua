ESX = nil
local Vehicles = {}
local PlayerData = {}
local lsMenuIsShowed = false
local lsMenuIsShowed1 = false
local isInLSMarker = false
local myCar = {}
local engine = false
local turbo = false
local transmission = false
local suspension = false
local brakes = false
local plate = false
local exhaust = false
local armor = false
local wheel = false
local spoilers = false
local wtint = false
local rbumper = false
local fbumper = false
local hood = false
local sideskirt = false
local grille = false
local roof = false
local cage = false
local neon = false
local xenon = false
local horn = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.SharedObject, function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer

    ESX.TriggerServerCallback('pd-mechanics:getVehiclesPrices', function(vehicles)
        Vehicles = vehicles
    end)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('pd-mechanics:installMod')
AddEventHandler('pd-mechanics:installMod', function()
    local plyped = PlayerPedId()
    local plycoords = GetEntityCoords(plyped)
    local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
    myCar = ESX.Game.GetVehicleProperties(vehicle)
    TriggerServerEvent('pd-mechanics:refreshOwnedVehicle', myCar)
end)

RegisterNetEvent('pd-mechanics:cancelInstallMod')
AddEventHandler('pd-mechanics:cancelInstallMod', function()
    local plyped = PlayerPedId()
    local plycoords = GetEntityCoords(plyped)
    local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
    ESX.Game.SetVehicleProperties(vehicle, myCar)
end)

function OpenLSMenu(elems, menuName, menuTitle, parent)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), menuName, {
        title = menuTitle,
        align = 'top-right',
        elements = elems
    }, function(data, menu)
        local isRimMod, found = false, false
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)

        if data.current.modType == "modFrontWheels" then
            isRimMod = true
        end

        for k, v in pairs(Config.Menus) do

            if k == data.current.modType or isRimMod then

                if data.current.label == _U('by_default') or string.match(data.current.label, _U('installed')) then
                    ESX.ShowNotification(_U('already_own', data.current.label))
                    TriggerEvent('pd-mechanics:installMod')
                else
                    local vehiclePrice = 50000

                    for i = 1, #Vehicles, 1 do
                        if GetEntityModel(vehicle) == GetHashKey(Vehicles[i].model) then
                            vehiclePrice = Vehicles[i].price
                            break
                        end
                    end

                    if isRimMod then
                        price = math.floor(vehiclePrice * data.current.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Wheel")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 11 then
                        price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        SetVehicleDoorOpen(vehicle, 4, false, false)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(10000, "Changing Engine")
                        Citizen.Wait(100)
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetVehicleDoorShut(vehicle, 4, false)
                    elseif v.modType == 12 then
                        price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Brakes")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 13 then
                        price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        SetVehicleDoorOpen(vehicle, 4, false, false)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(10000, "Changing Transmission")
                        Citizen.Wait(100)
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetVehicleDoorShut(vehicle, 4, false)
                    elseif v.modType == 14 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Horn")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 15 then
                        price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Suspesion")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 16 then
                        price = math.floor(vehiclePrice * v.price[data.current.modNum + 1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Armor")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 17 then
                        price = math.floor(vehiclePrice * v.price[1] / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        SetVehicleDoorOpen(vehicle, 4, false, false)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(10000, "Changing Turbo")
                        Citizen.Wait(100)
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetVehicleDoorShut(vehicle, 4, false)
                    elseif v.modType == 'plateIndex' then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Plate")
                    elseif v.modType == 'windowTint' then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Window Tint")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 'neonColor' then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Neons")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 0 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Spoiler")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 1 or v.modType == 2 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Bumper")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 3 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Skirts")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 5 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic4')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Cage")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 6 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Grille")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 22 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic3')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Headlight")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 7 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Hood")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 10 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e mechanic')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Roof")
                        FreezeEntityPosition(PlayerPedId(), false)
                    elseif v.modType == 4 then
                        price = math.floor(vehiclePrice * v.price / 100)
                        TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ExecuteCommand('e sunbathe')
                        FreezeEntityPosition(PlayerPedId(), true)
                        ESX.UI.Menu.CloseAll()
                        exports["lm_taskbar"]:taskBar(5000, "Changing Exhaust")
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
						price = math.floor(vehiclePrice * v.price / 100)
						TriggerServerEvent('pd-mechanics:buyMod', price)
                        ClearPedTasksImmediately(PlayerPedId())
                        ESX.UI.Menu.CloseAll()
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
        TriggerEvent('pd-mechanics:cancelInstallMod')

        local playerPed = PlayerPedId()
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        -- SetVehicleDoorsShut(vehicle, false)

        if parent == nil then
            lsMenuIsShowed = false
            local plyped = PlayerPedId()
            local plycoords = GetEntityCoords(plyped)
            local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
            FreezeEntityPosition(vehicle, false)
            myCar = {}
        end
    end, function(data, menu) -- on change
        UpdateMods(data.current)
    end)
end

function UpdateMods(data)
    local plyped = PlayerPedId()
    local plycoords = GetEntityCoords(plyped)
    local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)

    if data.modType then
        local props = {}

        if data.wheelType then
            props['wheels'] = data.wheelType
            ESX.Game.SetVehicleProperties(vehicle, props)
            props = {}
        elseif data.modType == 'neonColor' then
            if data.modNum[1] == 0 and data.modNum[2] == 0 and data.modNum[3] == 0 then
                props['neonEnabled'] = {false, false, false, false}
            else
                props['neonEnabled'] = {true, true, true, true}
            end
            ESX.Game.SetVehicleProperties(vehicle, props)
            props = {}
        elseif data.modType == 'tyreSmokeColor' then
            props['modSmokeEnabled'] = true
            ESX.Game.SetVehicleProperties(vehicle, props)
            props = {}
        end

        props[data.modType] = data.modNum
        ESX.Game.SetVehicleProperties(vehicle, props)
    end
end

function GetAction(data)
    local elements = {}
    local menuName = ''
    local menuTitle = ''
    local parent = nil

    local playerPed = PlayerPedId()
    local plyped = PlayerPedId()
    local plycoords = GetEntityCoords(plyped)
    local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
    local currentMods = ESX.Game.GetVehicleProperties(vehicle)

    if data.value == 'modSpeakers' or data.value == 'modTrunk' or data.value == 'modHydrolic' or data.value ==
        'modEngineBlock' or data.value == 'modAirFilter' or data.value == 'modStruts' or data.value == 'modTank' then
        SetVehicleDoorOpen(vehicle, 4, false)
        SetVehicleDoorOpen(vehicle, 5, false)
    elseif data.value == 'modDoorSpeaker' then
        SetVehicleDoorOpen(vehicle, 0, false)
        SetVehicleDoorOpen(vehicle, 1, false)
        SetVehicleDoorOpen(vehicle, 2, false)
        SetVehicleDoorOpen(vehicle, 3, false)
    else
        -- SetVehicleDoorsShut(vehicle, false)
    end

    local vehiclePrice = 50000

    for i = 1, #Vehicles, 1 do
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
				
				if v.modType == 22 then
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = false})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- disable neon
					table.insert(elements, {label = " " ..  _U('by_default'), modType = k, modNum = {0, 0, 0}})
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then
					local num = myCar[v.modType]
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = num})
				elseif v.modType == 17 then
					table.insert(elements, {label = " " .. _U('no_turbo'), modType = k, modNum = false})
 				else
					table.insert(elements, {label = " " .. _U('by_default'), modType = k, modNum = -1})
				end

				if v.modType == 14 then -- HORNS
					for j = 0, 51, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetHornName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetHornName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 'plateIndex' then -- PLATES
					for j = 0, 4, 1 do
						local _label = ''
						if j == currentMods.plateIndex then
							_label = GetPlatesName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetPlatesName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 22 then -- NEON
					local _label = ''
					if currentMods.modXenon then
						_label = _U('neon') .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						price = math.floor(vehiclePrice * v.price / 100)
						_label = _U('neon') .. ' - <span style="color:green;">$' .. price .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				elseif v.modType == 'neonColor' or v.modType == 'tyreSmokeColor' then -- NEON & SMOKE COLOR
					local neons = GetNeons()
					price = math.floor(vehiclePrice * v.price / 100)
					for i=1, #neons, 1 do
						table.insert(elements, {
							label = '<span style="color:rgb(' .. neons[i].r .. ',' .. neons[i].g .. ',' .. neons[i].b .. ');">' .. neons[i].label .. ' - <span style="color:green;">$' .. price .. '</span>',
							modType = k,
							modNum = { neons[i].r, neons[i].g, neons[i].b }
						})
					end
				elseif v.modType == 'color1' or v.modType == 'color2' or v.modType == 'pearlescentColor' or v.modType == 'wheelColor' then -- RESPRAYS
					local colors = GetColors(data.color)
					for j = 1, #colors, 1 do
						local _label = ''
						price = math.floor(vehiclePrice * v.price / 100)
						_label = colors[j].label .. ' - <span style="color:green;">$' .. price .. ' </span>'
						table.insert(elements, {label = _label, modType = k, modNum = colors[j].index})
					end
				elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 23 then -- WHEELS RIM & TYPE
					local props = {}

					props['wheels'] = v.wheelType
					ESX.Game.SetVehicleProperties(vehicle, props)

					local modCount = GetNumVehicleMods(vehicle, v.modType)
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods.modFrontWheels then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = 'modFrontWheels', modNum = j, wheelType = v.wheelType, price = v.price})
						end
					end
                elseif v.modType == 'windowTint' then -- WINDOWS TINT
					for j = 1, 5, 1 do
						local _label = ''
						if j == currentMods.modHorns then
							_label = GetWindowName(j) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price / 100)
							_label = GetWindowName(j) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
					end
				elseif v.modType == 11 or v.modType == 12 or v.modType == 13 or v.modType == 15 or v.modType == 16 then
					SetVehicleModKit(vehicle, 0)
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- UPGRADES
					for j = 0, modCount, 1 do
						local _label = ''
						if j == currentMods[k] then
							_label = _U('level', j+1) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
						else
							price = math.floor(vehiclePrice * v.price[j+1] / 100)
							_label = _U('level', j+1) .. ' - <span style="color:green;">$' .. price .. ' </span>'
						end
						table.insert(elements, {label = _label, modType = k, modNum = j})
						if j == modCount-1 then
							break
						end
					end
				elseif v.modType == 17 then -- TURBO
					local _label = ''
					if currentMods[k] then
						_label = 'Turbo - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
					else
						_label = 'Turbo - <span style="color:green;">$' .. math.floor(vehiclePrice * v.price[1] / 100) .. ' </span>'
					end
					table.insert(elements, {label = _label, modType = k, modNum = true})
				else
                    SetVehicleModKit(vehicle, 0)
					local modCount = GetNumVehicleMods(vehicle, v.modType) -- BODYPARTS
					for j = 0, modCount, 1 do
						local modName = GetModTextLabel(vehicle, v.modType, j)
						if modName then
							local _label = ''
							if j == currentMods[k] then
								_label = GetLabelText(modName) .. ' - <span style="color:cornflowerblue;">'.. _U('installed') ..'</span>'
							else
								price = math.floor(vehiclePrice * v.price / 100)
								_label = GetLabelText(modName) .. ' - <span style="color:green;">$' .. price .. ' </span>'
							end
							table.insert(elements, {label = _label, modType = k, modNum = j})
						end
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

-----PD----

RegisterNetEvent('pd-mechanic:enginemenu')
AddEventHandler('pd-mechanic:enginemenu', function()
    if engine == true then
        lsMenuIsShowed = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'engines'
        })
        engine = false
    else
        ESX.ShowNotification('No engine')
    end
end)

RegisterNetEvent('pd-mechanic:turbomenu')
AddEventHandler('pd-mechanic:turbomenu', function()
    if turbo == true then
        lsMenuIsShowed = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'turbo'
        })
        turbo = false
    else
        ESX.ShowNotification('No turbo')
    end
end)

RegisterNetEvent('pd-mechanic:transmissionmenu')
AddEventHandler('pd-mechanic:transmissionmenu', function()
    if transmission == true then
        lsMenuIsShowed = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'transmission'
        })
        transmission = false
    else
        ESX.ShowNotification('No transmission')
    end
end)

RegisterNetEvent('pd-mechanic:suspensionmenu')
AddEventHandler('pd-mechanic:suspensionmenu', function()
    if suspension == true then
        lsMenuIsShowed = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'suspension'
        })
        suspension = false
    else
        ESX.ShowNotification('No suspension')
    end
end)

RegisterNetEvent('pd-mechanic:brakesmenu')
AddEventHandler('pd-mechanic:brakesmenu', function()
    if brakes == true then
        lsMenuIsShowed = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'brakes'
        })
        brakes = false
    else
        ESX.ShowNotification('No brakes')
    end
end)

RegisterNetEvent('pd-mechanic:platesmenu')
AddEventHandler('pd-mechanic:platesmenu', function()
    if plate then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'plates'
        })
        plate = false
    else
        ESX.ShowNotification('No license plate')
    end
end)

RegisterNetEvent('pd-mechanic:wheelmenu')
AddEventHandler('pd-mechanic:wheelmenu', function()
    if wheel then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'wheel'
        })
        wheel = false
    else
        ESX.ShowNotification('No wheel')
    end
end)

RegisterNetEvent('pd-mechanic:exhaustmenu')
AddEventHandler('pd-mechanic:exhaustmenu', function()
    if exhaust then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'exhaust'
        })
        exhaust = false
    else
        ESX.ShowNotification('No exhaust')
    end
end)

RegisterNetEvent('pd-mechanic:armormenu')
AddEventHandler('pd-mechanic:armormenu', function()
    if armor then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'armor'
        })
        armor = false
    else
        ESX.ShowNotification('No armor')
    end
end)

RegisterNetEvent('pd-mechanic:spoilersmenu')
AddEventHandler('pd-mechanic:spoilersmenu', function()
    if spoilers then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'spoilers'
        })
        spoilers = false
    else
        ESX.ShowNotification('No spoiler')
    end
end)

RegisterNetEvent('pd-mechanic:wtintmenu')
AddEventHandler('pd-mechanic:wtintmenu', function()
    if wtint then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'wtint'
        })
        wtint = false
    else
        ESX.ShowNotification('No Window Tint')
    end
end)

RegisterNetEvent('pd-mechanic:fbumpermenu')
AddEventHandler('pd-mechanic:fbumpermenu', function()
    if fbumper then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'fbumper'
        })
        fbumper = false
    else
        ESX.ShowNotification('No Bumper')
    end
end)

RegisterNetEvent('pd-mechanic:rbumpermenu')
AddEventHandler('pd-mechanic:rbumpermenu', function()
    if rbumper then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'rbumper'
        })
        rbumper = false
    else
        ESX.ShowNotification('No Bumper')
    end
end)

RegisterNetEvent('pd-mechanic:hoodmenu')
AddEventHandler('pd-mechanic:hoodmenu', function()
    if hood then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'hood'
        })
        hood = false
    else
        ESX.ShowNotification('No Hood')
    end
end)

RegisterNetEvent('pd-mechanic:sideskirtmenu')
AddEventHandler('pd-mechanic:sideskirtmenu', function()
    if sideskirt then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'sideskirt'
        })
        sideskirt = false
    else
        ESX.ShowNotification('No Sideskirts')
    end
end)

RegisterNetEvent('pd-mechanic:grillemenu')
AddEventHandler('pd-mechanic:grillemenu', function()
    if grille then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'grille'
        })
        grille = false
    else
        ESX.ShowNotification('No Grille')
    end
end)

RegisterNetEvent('pd-mechanic:roofmenu')
AddEventHandler('pd-mechanic:roofmenu', function()
    if roof then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'roof'
        })
        roof = false
    else
        ESX.ShowNotification('No Roof')
    end
end)

RegisterNetEvent('pd-mechanic:cagemenu')
AddEventHandler('pd-mechanic:cagemenu', function()
    if cage then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'cage'
        })
        cage = false
    else
        ESX.ShowNotification('No Cage')
    end
end)

RegisterNetEvent('pd-mechanic:neonmenu')
AddEventHandler('pd-mechanic:neonmenu', function()
    if neon then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'neon'
        })
        neon = false
    else
        ESX.ShowNotification('No Neons')
    end
end)

RegisterNetEvent('pd-mechanic:xenonmenu')
AddEventHandler('pd-mechanic:xenonmenu', function()
    if xenon then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'xenon'
        })
        xenon = false
    else
        ESX.ShowNotification('No Xeons')
    end
end)

RegisterNetEvent('pd-mechanic:hornmenu')
AddEventHandler('pd-mechanic:hornmenu', function()
    if horn then
        lsMenuIsShowed1 = true
        local plyped = PlayerPedId()
        local plycoords = GetEntityCoords(plyped)
        local vehicle = GetClosestVehicle(plycoords.x, plycoords.y, plycoords.z, 5.0, 0, 71)
        myCar = ESX.Game.GetVehicleProperties(vehicle)
        ESX.UI.Menu.CloseAll()
        GetAction({
            value = 'horn'
        })
        horn = false
    else
        ESX.ShowNotification('No Horn')
    end
end)

RegisterNetEvent('pd-mechanic:engine')
AddEventHandler('pd-mechanic:engine', function()
    ExecuteCommand('e engine')
    engine = true
end)

RegisterNetEvent('pd-mechanic:turbo')
AddEventHandler('pd-mechanic:turbo', function()
    ESX.ShowNotification('Ready')
    turbo = true
end)

RegisterNetEvent('pd-mechanic:transmission')
AddEventHandler('pd-mechanic:transmission', function()
    ESX.ShowNotification('Ready')
    transmission = true
end)

RegisterNetEvent('pd-mechanic:suspension')
AddEventHandler('pd-mechanic:suspension', function()
    ESX.ShowNotification('Ready')
    suspension = true
end)

RegisterNetEvent('pd-mechanic:brakes')
AddEventHandler('pd-mechanic:brakes', function()
    ESX.ShowNotification('Ready')
    brakes = true
end)

RegisterNetEvent('pd-mechanic:wheel')
AddEventHandler('pd-mechanic:wheel', function()
    ExecuteCommand('e wheel')
	wheel = true
end)

RegisterNetEvent('pd-mechanic:plate')
AddEventHandler('pd-mechanic:plate', function()
    ExecuteCommand('e plate')
    plate = true
end)

RegisterNetEvent('pd-mechanic:exhaust')
AddEventHandler('pd-mechanic:exhaust', function()
    ExecuteCommand('e exhaust')
    exhaust = true
end)

RegisterNetEvent('pd-mechanic:armor')
AddEventHandler('pd-mechanic:armor', function()
    ESX.ShowNotification('Ready')
    armor = true
end)

RegisterNetEvent('pd-mechanic:spoilers')
AddEventHandler('pd-mechanic:spoilers', function()
    ExecuteCommand('e spoiler')
    spoilers = true
end)

RegisterNetEvent('pd-mechanic:wtint')
AddEventHandler('pd-mechanic:wtint', function()
    ESX.ShowNotification('Ready')
    wtint = true
end)

RegisterNetEvent('pd-mechanic:fbumper')
AddEventHandler('pd-mechanic:fbumper', function()
    ESX.ShowNotification('Ready')
    fbumper = true
end)

RegisterNetEvent('pd-mechanic:rbumper')
AddEventHandler('pd-mechanic:rbumper', function()
    ESX.ShowNotification('Ready')
    rbumper = true
end)

RegisterNetEvent('pd-mechanic:hood')
AddEventHandler('pd-mechanic:hood', function()
    ESX.ShowNotification('Ready')
    hood = true
end)

RegisterNetEvent('pd-mechanic:sideskirt')
AddEventHandler('pd-mechanic:sideskirt', function()
    ESX.ShowNotification('Ready')
    sideskirt = true
end)

RegisterNetEvent('pd-mechanic:grille')
AddEventHandler('pd-mechanic:grille', function()
    ESX.ShowNotification('Ready')
    grille = true
end)

RegisterNetEvent('pd-mechanic:roof')
AddEventHandler('pd-mechanic:roof', function()
    ESX.ShowNotification('Ready')
    roof = true
end)

RegisterNetEvent('pd-mechanic:cage')
AddEventHandler('pd-mechanic:cage', function()
    ESX.ShowNotification('Ready')
    cage = true
end)

RegisterNetEvent('pd-mechanic:neon')
AddEventHandler('pd-mechanic:neon', function()
    ESX.ShowNotification('Ready')
    neon = true
end)

RegisterNetEvent('pd-mechanic:xenon')
AddEventHandler('pd-mechanic:xenon', function()
    ESX.ShowNotification('Ready')
    xenon = true
end)

RegisterNetEvent('pd-mechanic:horn')
AddEventHandler('pd-mechanic:horn', function()
    ESX.ShowNotification('Ready')
    horn = true
end)