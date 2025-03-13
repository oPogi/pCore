local Coffree = require 'modules.coffre.cfgCoffre'
local Coffre = Coffree.Coffre
local LocaleCoffre = Coffree.Locale_Coffre

CreateThread(function()
    for _, v in pairs(Coffre) do
        if not pCoreUse.UseMarker then
            local data = {
                name = 'coffre' .. v.Name,
                coords = v.Coords,
                radius = 0.45,
                debug = false,
                options = {
                    {
                        label = LocaleCoffre["Target_label"],
                        icon = LocaleCoffre["Target_icon"],
                        iconColor = LocaleCoffre["Target_iconColor"],
                        groups = v.Job,
                        distance = 2,
                        canInteract = function()
                            return true
                        end,
                        onSelect = function()
                            exports.ox_inventory:openInventory('stash', v.Name)
                        end
                    }
                }
            }
            exports.ox_target:addSphereZone(data)
        else
            if GetJob() == v.Job then
                lib.zones.sphere({
                    coords = v.Coords,
                    radius = 2,
                    debug = false,
                    onEnter = function()
                        lib.showTextUI(LocaleCoffre["Zone_label"])
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        DrawMarker(2, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
                        if IsControlJustReleased(0, 38) then
                            exports.ox_inventory:openInventory('stash', v.Name)
                        end
                    end
                })
            end
        end
    end
end)
