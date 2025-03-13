local Annonce = require 'modules.annonce.cfgAnnonce'
local AnnonceStation = Annonce.Annonce
local LocaleAnnonce = Annonce.Locale_Annonce

local OpenAnnonce = function(j, c)
    local job = GetJob()
    if job == j then
        local input = exports.ox_lib:inputDialog(LocaleAnnonce["Input_title"], {
            { label = LocaleAnnonce["Input_labeltitle"],       type = 'input' },
            { label = LocaleAnnonce["Input_labeldescription"], type = 'input' }
        })
        if not input then return end
        TriggerServerEvent('pcore:annonce', input[1], input[2], job, c)
    end
end

CreateThread(function()
    for _, v in pairs(AnnonceStation) do
        if not pCoreUse.UseMarker then
            local data = {
                name = 'annonce' .. v.Job,
                coords = v.Coords,
                radius = 0.45,
                debug = false,
                options = {
                    {
                        label = LocaleAnnonce["Target_label"],
                        icon = LocaleAnnonce["Target_icon"],
                        iconColor = LocaleAnnonce["Target_iconColor"],
                        groups = v.Job,
                        distance = 2,
                        canInteract = function()
                            return true
                        end,
                        onSelect = function()
                            OpenAnnonce(v.Job, v.Char)
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
                        lib.showTextUI(LocaleAnnonce["Zone_label"])
                    end,
                    onExit = function()
                        lib.hideTextUI()
                    end,
                    inside = function()
                        DrawMarker(2, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
                        if IsControlJustReleased(0, 38) then
                            OpenAnnonce(v.Job, v.Char)
                        end
                    end
                })
            end
        end
    end
end)
