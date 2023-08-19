
local QBCore = exports["qb-core"]:GetCoreObject()
local rob = false
local lockpicking = false
local robbed = {343434353230}
local canRob = true


local objects = {
    `prop_parknmeter_01`, `prop_parknmeter_02`
}

-- Functions
local function loadAnimDict(dict) while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Wait(0) end end
local function BreakAnim() loadAnimDict("veh@break_in@0h@p_m_one@") lockpicking = true
    CreateThread(function()
        while true do if lockpicking then TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0) else StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0) break end Wait(1000) end
    end)
end

function LookAtEntity(entity)
	if type(entity) == "vector3" then
		if not IsPedHeadingTowardsPosition(PlayerPedId(), entity, 30.0) then TaskTurnPedToFaceCoord(PlayerPedId(), entity, 1500) Wait(1500) end
	else
		if DoesEntityExist(entity) then
			if not IsPedHeadingTowardsPosition(PlayerPedId(), GetEntityCoords(entity), 30.0) then TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(entity), 1500) Wait(1500) end
		end
	end
end

local function PoliceCall()
    local currentPos = GetEntityCoords(PlayerPedId())
    exports["ps-dispatch"]:CustomAlert({ coords = currentPos, job = {"police" }, message = "Parking Meter Robbery", dispatchCode = "10-36", firstStreet = coords, description = "Parking meter geting robbed.", radius = 0, sprite = 164, color = 38, scale = 1.0, length = 2, })
end



-- Events
RegisterNetEvent("ruby-robparking:client:dispatch", function()
    if Config.disptachforall then
        PoliceCall()
    else
        if Config.PoliceCallChance <= math.random(1, 100) then
            PoliceCall()
        end
    end
end)

RegisterNetEvent("ruby-robparking:client:steal", function()
    if Config.Inventory == 'qb' then
        local hasItem = QBCore.Functions.HasItem('lockpick')
        local random = math.random(Config.MinReward, Config.MaxReward)
        if canRob then
            local meterFound = false
            for i = 1, #objects do
                local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, objects[i], false, false, false)
                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(object)) < 1.8 then
                    for i = 1, #robbed do
                        if robbed[i] == object then meterFound = true end
                        if i == #robbed and meterFound then TriggerEvent("QBCore:Notify", "Empty! Seems like already robbed.", "error") return
                        elseif i == #robbed and not meterFound then
                            if rob then 
                                QBCore.Functions.Notify("Just take a breath and try again in while.", "error") 
                                Citizen.Wait(Config.cooldown) 
                                rob = false
                            else 
                                if hasItem then
                                    LookAtEntity(GetEntityCoords(object))
                                    BreakAnim()
                                    exports['ps-ui']:Circle(function(success)
                                        if success then
                                            rob = true 
                                            lockpicking = false 
                                            if Config.dispatch then 
                                                TriggerEvent("ruby-robparking:client:dispatch") 
                                            end 
                                            TriggerServerEvent("ruby-robparking:server:getmoney", random) robbed[i+1] = object 
                                            ClearPedTasks(PlayerPedId())
                                        else 
                                            QBCore.Functions.Notify("You failed", "error") 
                                            lockpicking = false 
                                            ClearPedTasks(PlayerPedId()) 
                                        end
                                    end, math.random(3, 4), math.random(10, 13))
                                else
                                    QBCore.Functions.Notify("You don't have a lockpick", "error")
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif Config.Inventory == 'ox' then
        local ox_inventory = exports.ox_inventory
        local hasItem = ox_inventory:Search('slots', 'lockpick')
        local random = math.random(Config.MinReward, Config.MaxReward)
        if canRob then
            local meterFound = false
            for i = 1, #objects do
                local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, objects[i], false, false, false)
                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(object)) < 1.8 then
                    for i = 1, #robbed do
                        if robbed[i] == object then meterFound = true end
                        if i == #robbed and meterFound then lib.notify({ description = 'Empty! Seems like someone already robbed this', type = 'error' }) return
                        elseif i == #robbed and not meterFound then
                            if rob then
                                lib.notify({ description = 'Just take a breath and try again in while', type = 'error' })
                                Citizen.Wait(Config.cooldown) 
                                rob = false
                            else 
                                if hasItem then
                                    LookAtEntity(GetEntityCoords(object))
                                    BreakAnim()
                                    local success = lib.skillCheck({'easy', 'easy', 'easy', 'medium'}, {'1', '2', '3', '4'})
                                    if success then
                                        rob = true 
                                        lockpicking = false 
                                        if Config.dispatch then 
                                            TriggerEvent("ruby-robparking:client:dispatch") 
                                        end 
                                        TriggerServerEvent("ruby-robparking:server:getmoney", random) robbed[i+1] = object ClearPedTasks(PlayerPedId())
                                    else 
                                        lib.notify({ description = 'You failed', type = 'error' })
                                        lockpicking = false 
                                        ClearPedTasks(PlayerPedId())
                                    end
                                else
                                    lib.notify({ description = 'You dont have a lockpick', type = 'error' })
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


-- Target Export
CreateThread(function()
    if Config.Target == 'qb' then
        exports['qb-target']:AddTargetModel(objects, {options = {{event = "ruby-robparking:client:steal",icon = "fas fa-hands",label = "Rob Meter",},},distance = 2.5,})
    elseif Config.Target == 'ox' then
        local options = {
            {
            event = "ruby-robparking:client:steal",
            icon = "fas fa-hands",
            label = "Rob Meter",
            onSelect = function()
                TriggerEvent('ruby-robparking:client:steal')
            end
            }
        }
        exports.ox_target:addModel(objects, options)
    end
end)
