-- _____     ______     ______   ______    
--/\  __-.  /\  __ \   /\__  _\ /\  __ \   
--\ \ \/\ \ \ \  __ \  \/_/\ \/ \ \  __ \  
-- \ \____-  \ \_\ \_\    \ \_\  \ \_\ \_\ 
--  \/____/   \/_/\/_/     \/_/   \/_/\/_/ 
--                                       
local isFilling = false
local tanker = nil
local originalMaxSpeed = 0.0
local countdownTimer = 0
-- _____     ______     ______   ______    
--/\  __-.  /\  __ \   /\__  _\ /\  __ \   
--\ \ \/\ \ \ \  __ \  \/_/\ \/ \ \  __ \  
-- \ \____-  \ \_\ \_\    \ \_\  \ \_\ \_\ 
--  \/____/   \/_/\/_/     \/_/   \/_/\/_/ 
--                                         



-- ______   __     __         __         __     __   __     ______    
--/\  ___\ /\ \   /\ \       /\ \       /\ \   /\ "-.\ \   /\  ___\   
--\ \  __\ \ \ \  \ \ \____  \ \ \____  \ \ \  \ \ \-.  \  \ \ \__ \  
-- \ \_\    \ \_\  \ \_____\  \ \_____\  \ \_\  \ \_\\"\_\  \ \_____\ 
--  \/_/     \/_/   \/_____/   \/_____/   \/_/   \/_/ \/_/   \/_____/ 
--                                                                    

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
            if countdownTimer <= 0 then
                FinishFilling()
            else
                countdownTimer = countdownTimer - 1000
                local progress = countdownTimer / Config.fillDuration
                DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.0, "Filling: " .. math.floor(progress * (Config.fillDuration / 1000)) .. "s")
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
        countdownTimer = Config.fillDuration
        
        ShowNotification("~g~Filling the tanker...")
    else
        ShowNotification("~r~You can't fill this vehicle!")
    end
end

function FinishFilling()
    isFilling = false
    countdownTimer = 0 -- Reset the countdown timer

    SetVehicleMaxSpeed(tanker, Config.maxSpeedMph * 0.44704) -- Convert to meters per second
    SetVehicleEngineOn(tanker, true, true, true) -- Turn on the engine
    SetVehicleJetEngineOn(tanker, true) -- Turn on the jet engine

    ShowNotification("~g~Tanker Filled!")
end

function ResetTankerProperties()
    SetVehicleMaxSpeed(tanker, originalMaxSpeed) -- Reset the vehicle's max speed to the original value
    SetVehicleEngineOn(tanker, true, true, true) -- Turn on the engine
end
-- ______   __     __         __         __     __   __     ______    
--/\  ___\ /\ \   /\ \       /\ \       /\ \   /\ "-.\ \   /\  ___\   
--\ \  __\ \ \ \  \ \ \____  \ \ \____  \ \ \  \ \ \-.  \  \ \ \__ \  
-- \ \_\    \ \_\  \ \_____\  \ \_____\  \ \_\  \ \_\\"\_\  \ \_____\ 
--  \/_/     \/_/   \/_____/   \/_____/   \/_/   \/_/ \/_/   \/_____/ 
--




-- ______     __    __     _____     ______    
--/\  ___\   /\ "-./  \   /\  __-.  /\  ___\   
--\ \ \____  \ \ \-./\ \  \ \ \/\ \ \ \___  \  
-- \ \_____\  \ \_\ \ \_\  \ \____-  \/\_____\ 
--  \/_____/   \/_/  \/_/   \/____/   \/_____/ 
--                                             
RegisterCommand("draintanker", function()
    local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if DoesEntityExist(playerVehicle) and tanker == playerVehicle then
        ResetTankerProperties()
        ShowNotification("Tanker Drained!")
    end
end, false)
-- ______     __    __     _____     ______    
--/\  ___\   /\ "-./  \   /\  __-.  /\  ___\   
--\ \ \____  \ \ \-./\ \  \ \ \/\ \ \ \___  \  
-- \ \_____\  \ \_\ \ \_\  \ \____-  \/\_____\ 
--  \/_____/   \/_/  \/_/   \/____/   \/_____/ 
--                                             




-- __   __     ______     ______   __     ______   __     ______     ______     ______   __     ______     __   __     ______        ______     ______     ______     ______   __     ______     __   __       
--/\ "-.\ \   /\  __ \   /\__  _\ /\ \   /\  ___\ /\ \   /\  ___\   /\  __ \   /\__  _\ /\ \   /\  __ \   /\ "-.\ \   /\  ___\      /\  ___\   /\  ___\   /\  ___\   /\__  _\ /\ \   /\  __ \   /\ "-.\ \      
--\ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \ \  \ \  __\ \ \ \  \ \ \____  \ \  __ \  \/_/\ \/ \ \ \  \ \ \/\ \  \ \ \-.  \  \ \___  \     \ \___  \  \ \  __\   \ \ \____  \/_/\ \/ \ \ \  \ \ \/\ \  \ \ \-.  \     
-- \ \_\\"\_\  \ \_____\    \ \_\  \ \_\  \ \_\    \ \_\  \ \_____\  \ \_\ \_\    \ \_\  \ \_\  \ \_____\  \ \_\\"\_\  \/\_____\     \/\_____\  \ \_____\  \ \_____\    \ \_\  \ \_\  \ \_____\  \ \_\\"\_\    
--  \/_/ \/_/   \/_____/     \/_/   \/_/   \/_/     \/_/   \/_____/   \/_/\/_/     \/_/   \/_/   \/_____/   \/_/ \/_/   \/_____/      \/_____/   \/_____/   \/_____/     \/_/   \/_/   \/_____/   \/_/ \/_/    
--                                                                                                                                                                                                             
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

function DrawProgressBar(x, y, width, height, fillDuration, r, g, b, a)
    local maxFillDuration = 10000
    local progress = 1 - (fillDuration / maxFillDuration)
    local progressBarWidth = progress * width
    
    DrawRect(x, y, width, height, 0, 0, 0, 100)
    DrawRect(x - (width / 2) + (progressBarWidth / 2), y, progressBarWidth, height, r, g, b, a)
end

-- Define a function to send tanker notifications
function ShowNotification(message)
    if GetResourceState("ModernHUD") == "started" then
        exports["ModernHUD"]:AndyyyNotify({
            title = "<p style='color: #34eb52;'>Tanker Filling:</p>",
            message = message,
            icon = "fa-solid fa-truck-pickup",
            colorHex = "#34eb52",
            timeout = 8000
        })
    else
        TriggerEvent('chatMessage', '^3[Tanker]', { 255, 255, 255 }, message)
    end
end
-- __   __     ______     ______   __     ______   __     ______     ______     ______   __     ______     __   __     ______        ______     ______     ______     ______   __     ______     __   __       
--/\ "-.\ \   /\  __ \   /\__  _\ /\ \   /\  ___\ /\ \   /\  ___\   /\  __ \   /\__  _\ /\ \   /\  __ \   /\ "-.\ \   /\  ___\      /\  ___\   /\  ___\   /\  ___\   /\__  _\ /\ \   /\  __ \   /\ "-.\ \      
--\ \ \-.  \  \ \ \/\ \  \/_/\ \/ \ \ \  \ \  __\ \ \ \  \ \ \____  \ \  __ \  \/_/\ \/ \ \ \  \ \ \/\ \  \ \ \-.  \  \ \___  \     \ \___  \  \ \  __\   \ \ \____  \/_/\ \/ \ \ \  \ \ \/\ \  \ \ \-.  \     
-- \ \_\\"\_\  \ \_____\    \ \_\  \ \_\  \ \_\    \ \_\  \ \_____\  \ \_\ \_\    \ \_\  \ \_\  \ \_____\  \ \_\\"\_\  \/\_____\     \/\_____\  \ \_____\  \ \_____\    \ \_\  \ \_\  \ \_____\  \ \_\\"\_\    
--  \/_/ \/_/   \/_____/     \/_/   \/_/   \/_/     \/_/   \/_____/   \/_/\/_/     \/_/   \/_/   \/_____/   \/_/ \/_/   \/_____/      \/_____/   \/_____/   \/_____/     \/_/   \/_/   \/_____/   \/_/ \/_/    
--  
