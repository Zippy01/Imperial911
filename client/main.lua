local commId = GetConvar("imperial_community_id", "")

if not commId or commId == "" then
    error("Could not find 'imperial_community_id' convar. Please ensure it is set in your server configuration file.")
end

print("ImperialCAD Community ID Found")


local callTimer = 0
local blips = {}


--

TriggerEvent('chat:addSuggestion', '/911', 'Call Emergency Services', {
    { name = "Information", help = "Description of your call." }
})

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if callTimer > 0 then
            callTimer = callTimer - 1
        end
    end
end)

RegisterCommand("911", function(source, args, rawCommand)
    local message = table.concat(args, " ")

    if message == nil or message == "" then
        Notify("You need to include the ~o~call information ~w~first before calling ~r~Emergency Services.")
        return
    end

    if callTimer > 0 then
        Notify("You must wait ~o~" .. callTimer .. " seconds ~w~before calling ~r~emergency services ~w~again.")
        return
    end

    Notify("Your ~o~call ~w~has been sent to ~r~emergency services~w~.")
    callTimer = 20 -- Set timer to 20 seconds after the call is made

    local name = exports["CivilianInt"]:GetStoredName()   
    local coords = GetEntityCoords(PlayerPedId())
    local streetHash, crossStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street = GetStreetNameFromHashKey(streetHash)
    local crossStreet = GetStreetNameFromHashKey(crossStreetHash)
    local postal = exports[Config.postalExportResource][Config.postalExportFunction]()

    if crossStreet == nil or crossStreet == '' then
        crossStreet = "N/A"
    end

    if name == nil or name == '' then
    name = GetPlayerName(PlayerId())
    end

    local data = {
        name = name,
        street = street,
        info = message,
        cross_street = crossStreet,
        postal = postal,
        community_id = commId,
    }

    TriggerServerEvent("Imperial:Send911ToCad", data)
    TriggerServerEvent("Imperial:CallChatMessage", name, street, message, crossStreet, postal)
    if Config.callBlip then
    TriggerServerEvent("Imperial:911Blip", coords)
    end
end, false)

-- Blip creation handler for on-duty units
RegisterNetEvent("Imperial:911BlipForOnduty")
AddEventHandler("Imperial:911BlipForOnduty", function(coords)
    local name = GetPlayerName(PlayerId())
    local blipId = math.random(100000, 999999)
    local offsetX = math.random(-50, 50)
    local offsetY = math.random(-50, 50)

    local newX = coords.x + offsetX
    local newY = coords.y + offsetY

    local radiusBlip = AddBlipForRadius(newX, newY, coords.z, 1000.0)
    SetBlipHighDetail(radiusBlip, true)
    SetBlipColour(radiusBlip, 1)
    SetBlipAlpha(radiusBlip, 128)
    SetBlipSprite(radiusBlip, 3)

    local coordBlip = AddBlipForCoord(newX, newY, coords.z)
    SetBlipSprite(coordBlip, 2)
    SetBlipDisplay(coordBlip, 2)
    SetBlipScale(coordBlip, 0.8)
    SetBlipColour(coordBlip, 1)
    SetBlipAsShortRange(coordBlip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("911 - " .. name )
    EndTextCommandSetBlipName(coordBlip)

    blips[blipId] = {radiusBlip = radiusBlip, coordBlip = coordBlip, x = newX, y = newY, z = coords.z}

    -- Set a timer to remove the blip after 5 minutes
    Citizen.CreateThread(function()
        Citizen.Wait(180000) -- 3 minutes in milliseconds
        if blips[blipId] then
            if blips[blipId].radiusBlip then RemoveBlip(blips[blipId].radiusBlip) end
            if blips[blipId].coordBlip then RemoveBlip(blips[blipId].coordBlip) end
            blips[blipId] = nil
            print("Blip ID " .. blipId .. " has been automatically removed after 5 minutes.")
        end
    end)
end)

function Notify(message)
    BeginTextCommandThefeedPost("STRING");
    AddTextComponentSubstringPlayerName(message);
    EndTextCommandThefeedPostMessagetext("CHAR_CALL911", "CHAR_CALL911", true, 1, "Imperial911", "Emergency Services");
end
