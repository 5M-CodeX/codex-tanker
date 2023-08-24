local isFilling = false
local tanker = nil

RegisterCommand("draintanker", function()
    local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(playerVehicle) and tanker == playerVehicle then
        local currentVelocity = GetEntityVelocity(tanker)
        SetEntityVelocity(tanker, currentVelocity * (1 / Config.slowdownFactor)) -- Reset the speed
    end
end, false)

Citizen.CreateThread(function()
    for _, location in ipairs(Config.refillLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, 365)
        SetBlipColour(blip, 2)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Water Refill")
        EndTextCommandSetBlipName(blip)
    end

    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, location in ipairs(Config.refillLocations) do
            local distance = #(playerCoords - vector3(location.x, location.y, location.z))

            if distance < 2.0 then
                DrawText3D(location.x, location.y, location.z, "Press ~g~E~w~ to fill the tanker")

                if IsControlJustReleased(0, 38) then -- 'E' key
                    StartFilling()
                end
            end
        end

        if isFilling then
            Config.fillDuration = Config.fillDuration - 1

            if Config.fillDuration <= 0 then
                FinishFilling()
            end
        end
    end
end)

function StartFilling()
    local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local playerVehicleModel = GetEntityModel(playerVehicle)
    
    local isAllowed = false
    for _, model in ipairs(Config.allowedVehicles) do
        if GetHashKey(model) == playerVehicleModel then
            isAllowed = true
            break
        end
    end
    
    if isAllowed then
        isFilling = true
        tanker = playerVehicle

        SetEntityCollision(tanker, false, false)
    else
        ShowNotification("~r~You can't fill this vehicle!")
    end
end

function FinishFilling()
    isFilling = false
    Config.fillDuration = 10000

    ShowNotification("~g~Tanker Filled!")

    local currentVelocity = GetEntityVelocity(tanker)
    SetEntityVelocity(tanker, currentVelocity * Config.slowdownFactor)

    SetEntityCollision(tanker, true, true)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
