local Garage = require 'modules.garage.cfgGarage'
local GarageStation = Garage.Garage
local LocaleGarage = Garage.Locale_Garage

local GarageOpen = function(vehicle, SpawnCoords, Plate)
    local vehicles = {}
    for _, v in pairs(vehicle) do
        if GetJobGrade() >= v.grade then
            vehicles[#vehicles + 1] = {
                title = v.label,
                description = LocaleGarage["Menu_description"] .. v.label,
                icon = LocaleGarage["Menu_icon"],
                onSelect = function()
                    SpawnCar(v.name, SpawnCoords, Plate)
                end
            }
        end
    end

    lib.registerContext({
        id = 'garage',
        title = LocaleGarage["Menu_title"],
        options = vehicles
    })
    lib.showContext('garage')
end

CreateThread(function()
    for _, v in pairs(GarageStation) do
        if not pCoreUse.UseMarker then
            local data = {
                name = 'garage' .. v.Job,
                coords = v.Coords,
                radius = 0.45,
                debug = false,
                options = {
                    {
                        label = LocaleGarage["Target_label"],
                        icon = LocaleGarage["Target_icon"],
                        iconColor = LocaleGarage["Target_iconColor"],
                        groups = v.Job,
                        distance = 2,
                        canInteract = function()
                            return true
                        end,
                        onSelect = function()
                            GarageOpen(v.VehiclesList, v.SpawnCoords, v.Plate)
                        end
                    }
                }
            }

            local Ranger = {
                {
                    label = LocaleGarage["Target_label_veh"],
                    icon = LocaleGarage["Target_icon_veh"],
                    iconColor = LocaleGarage["Target_iconColor_veh"],
                    groups = v.Job,
                    distance = 2,
                    canInteract = function(entity)
                        local distance = GetDistanceBetweenCoords(GetPlayerPosition(cache.ped), v.Coords, true)
                        return distance <= v.DistanceDelete
                    end,
                    onSelect = function(entity)
                        local plate = pCore.Math.Trim(GetVehicleNumberPlateText(entity.entity))
                        if plate == v.Plate then
                            DeleteVehicle(entity.entity)
                            Notify(LocaleGarage["Notif_ranger"], 'success')
                        else
                            Notify(LocaleGarage["Notif_ranger_error"], 'error')
                        end
                    end
                }
            }

            exports.ox_target:addSphereZone(data)
            exports.ox_target:addGlobalVehicle(Ranger)
        else
            if GetJob() == v.Job then
                lib.zones.sphere({
                    coords = v.Coords,
                    radius = 2,
                    debug = false,
                    onEnter = function()
                        lib.showTextUI(LocaleGarage["Zone_label"])
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        DrawMarker(2, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
                        if IsControlJustReleased(0, 38) then
                            GarageOpen(v.VehiclesList, v.SpawnCoords, v.Plate)
                        end
                    end
                })

                lib.zones.sphere({
                    coords = v.CoordsRanger,
                    radius = 2,
                    debug = false,
                    onEnter = function()
                        lib.showTextUI(LocaleGarage["Zone_label_ranger"])
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        if IsPedInAnyVehicle(cache.ped, false) then
                            local plate = pCore.Math.Trim(GetVehicleNumberPlateText(GetVehiclePedIsIn(cache.ped, false)))
                            if IsControlJustPressed(0, 38) then
                                if plate == v.Plate then
                                    DeleteVehicle(GetVehiclePedIsIn(cache.ped, false))
                                    Notify(LocaleGarage["Notif_ranger"], 'success')
                                else
                                    Notify(LocaleGarage["Notif_ranger_error"], 'error')
                                end
                            end
                        end
                    end
                })
            end
        end
    end
end)
