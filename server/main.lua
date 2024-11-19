RegisterNetEvent("Imperial:911Blip")
AddEventHandler("Imperial:911Blip", function(coords)
    local OnDutyUnitsFound = exports['ImperialDuty']:GetOnDutyUnits()
    for _, playerId in ipairs(OnDutyUnitsFound) do
        TriggerClientEvent("Imperial:911BlipForOnduty", playerId, coords)
    end
end)


RegisterNetEvent("Imperial:CallChatMessage")
AddEventHandler("Imperial:CallChatMessage", function(name, street, message, crossStreet, postal)
    local onDutyUnits = exports["ImperialDuty"]:GetOnDutyUnits()
    local chatMessage = {
        multiline = true,
        args = {"^8(Imperial911 - New Call For Service)", 
            "\nName: ^3" .. name .. "^7\nPostal: ^3" .. postal .. "^7\nStreet: ^3" .. street .. 
            "^7\nCross Street: ^3" .. crossStreet .. "^7\nInformation: ^3" .. message
        }
    }
    
    for _, playerId in ipairs(onDutyUnits) do
        -- Send the message to each on-duty player only once
        TriggerClientEvent("chat:addMessage", playerId, chatMessage)
    end
end)

-- Event to send 911 call data to CAD system
RegisterNetEvent("Imperial:Send911ToCad")
AddEventHandler("Imperial:Send911ToCad", function(data)
    PerformHttpRequest("https://imperialcad.app/api/1.1/wf/911", function(statusCode, responseText, headers)
        if statusCode == 200 then
            print("911 Call Success")
        else
            print("Failed to create post. Status Code: " .. statusCode)
            print("Error Response: " .. responseText)
        end
    end, "POST", json.encode(data), {["Content-Type"] = "application/json"})
end)
