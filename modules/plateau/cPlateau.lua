local Plateauu = require 'modules.plateau.cfgPlateau'
local Plateau = Plateauu.Plateau
local LocalePlateau = Plateauu.Locale_Plateau

CreateThread(function()
    for _, v in pairs(Plateau) do
        if not pCoreUse.UseMarker then
            local data = {
                name = 'plateau' .. v.Name,
                coords = v.Coords,
                radius = 0.45,
                debug = false,
                options = {
                    {
                        label = LocalePlateau["Target_label"],
                        icon = LocalePlateau["Target_icon"],
                        iconColor = LocalePlateau["Target_iconColor"],
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
                        lib.showTextUI(LocalePlateau["Zone_label"])
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
