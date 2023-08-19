local QBCore = exports["qb-core"]:GetCoreObject()

RegisterNetEvent("ruby-robparking:server:getmoney", function(Money)
	if Config.Inventory == 'qb' then
		Player = QBCore.Functions.GetPlayer(source)
		if Config.MoneyType == 'cash' then
		Player.Functions.AddMoney("cash", Money)
		elseif Config.MoneyType == 'markedmoney' then
			local bags = math.random(1,3)
			local info = {
            	worth = Money
        	}
        	Player.Functions.AddItem('markedbills', bags, false, info)
        	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbills'], "add")
		end
	elseif Config.Inventory == 'ox' then
		local ox_inventory = exports.ox_inventory
		if Config.MoneyType == 'cash' then
			ox_inventory:AddItem(source, 'money', Money)
		elseif Config.MoneyType == 'markedbills' then
			local bags = math.random(1,3)
			local info = {
            	worth = Money
        	}
			ox_inventory:AddItem(source, 'markedbills', bags, info.worth) -- ox uses markedbills rather than marked money?
		end
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  	return
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  	return
	end
end)
