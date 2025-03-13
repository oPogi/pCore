local Boss = require 'modules.boss.cfgBoss'
local BossMenu = Boss.Boss
local LocaleBoss = Boss.Locale_Boss

CreateThread(function()
    for _, v in pairs(BossMenu) do
        if not pCoreUse.UseMarker then
            local data = {
                name = 'boss' .. v.Job,
                coords = v.Coords,
                radius = 0.45,
                debug = false,
                options = {
                    {
                        label = LocaleBoss["Target_label"],
                        icon = LocaleBoss["Target_icon"],
                        iconColor = LocaleBoss["Target_iconColor"],
                        groups = v.Job,
                        distance = 2,
                        canInteract = function()
                            return true
                        end,
                        onSelect = function()
                            OpenBossMenu(v.Job)
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
                        lib.showTextUI(LocaleBoss["Zone_label"])
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        DrawMarker(2, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
                        if IsControlJustReleased(0, 38) then
                            OpenBossMenu(v.Job)
                        end
                    end
                })
            end
        end
    end
end)
