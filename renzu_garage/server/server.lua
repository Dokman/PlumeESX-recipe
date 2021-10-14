ESX = nil
local vehicles = {}
local parkedvehicles = {}
local parkmeter = {}
local default_routing = {}
local current_routing = {}
local lastgarage = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
    Wait(1000)
    vehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM vehicles', {})
    parkedvehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE isparked = 1', {}) or {}
    parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
    Wait(100)
    if Config.UseRayZone then
        local garages = {} -- garage table
        garages['multi_zone'] = {} -- rayzone multizone
        for k,v in pairs(garagecoord) do -- repack the coordinates to new table
            garages['multi_zone'][tostring(v.garage)] = {
                coord = vector3(v.garage_x,v.garage_y,v.garage_z),
                custom_title = 'Garage '..v.garage, -- custom title and it wont used the ['title'] anymore
                custom_event = 'opengarage', -- if custom_event is being used , the event ( ['event'] ) will not be used.
                custom_arg = { 1, 2, 4, 3}, -- sample only , ordering is important on this table
                arg_unpack = false, -- if true this will return the array as unpack to your event handler example: AddEventHandler("renzu_rayzone:test",function(a,b,c) the ,a will return the 1 ,b for 2, c for 4 ( as example config here) custom_arg = { 1, 2, 4, 3}, elseif false will return as a table.
                custom_ped = `g_m_importexport_01`, -- custom ped for this zone
                custom_heading = 100.0,
                server_event = false,
                min_z = -25.0, -- you can use this if you want the zone can be trigger only within this minimum height level
                max_z = 240.0, -- you can use this if you want the zone can be trigger only within this maximum height level
            }
        end
        if Config.EnableImpound then
            for k,v in pairs(impoundcoord) do -- repack the coordinates to new table
                garages['multi_zone'][tostring(v.garage)] = {
                    coord = vector3(v.garage_x,v.garage_y,v.garage_z),
                    custom_title = 'Garage '..v.garage, -- custom title and it wont used the ['title'] anymore
                    custom_event = 'opengarage', -- if custom_event is being used , the event ( ['event'] ) will not be used.
                    custom_arg = { 1, 2, 4, 3}, -- sample only , ordering is important on this table
                    arg_unpack = false, -- if true this will return the array as unpack to your event handler example: AddEventHandler("renzu_rayzone:test",function(a,b,c) the ,a will return the 1 ,b for 2, c for 4 ( as example config here) custom_arg = { 1, 2, 4, 3}, elseif false will return as a table.
                    custom_ped = `g_m_importexport_01`, -- custom ped for this zone
                    custom_heading = 100.0,
                    server_event = false,
                    min_z = -25.0, -- you can use this if you want the zone can be trigger only within this minimum height level
                    max_z = 240.0, -- you can use this if you want the zone can be trigger only within this maximum height level
                }
            end
        end

        if Config.EnableHeliGarage then
            for k,t in pairs(helispawn) do -- repack the coordinates to new table
                for k,v in pairs(t) do
                    garages['multi_zone'][tostring(v.garage)] = {
                        coord = vector3(v.coords.x,v.coords.y,v.coords.z),
                        custom_title = 'Garage '..v.garage, -- custom title and it wont used the ['title'] anymore
                        custom_event = 'opengarage', -- if custom_event is being used , the event ( ['event'] ) will not be used.
                        custom_arg = { 1, 2, 4, 3}, -- sample only , ordering is important on this table
                        arg_unpack = false, -- if true this will return the array as unpack to your event handler example: AddEventHandler("renzu_rayzone:test",function(a,b,c) the ,a will return the 1 ,b for 2, c for 4 ( as example config here) custom_arg = { 1, 2, 4, 3}, elseif false will return as a table.
                        custom_ped = `g_m_importexport_01`, -- custom ped for this zone
                        custom_heading = 100.0,
                        server_event = false,
                        min_z = -25.0, -- you can use this if you want the zone can be trigger only within this minimum height level
                        max_z = 240.0, -- you can use this if you want the zone can be trigger only within this maximum height level
                    }
                end
            end
        end

        garage = {
            ['zone_cooldown'] = 1, -- event cooldown
            ['popui'] = true, -- show pop ui by default, manual trigger event.
            ['multi_zone'] = garages['multi_zone'], -- insert table to the array
            -- global setting for each multi zone
            ['title'] = '🚗 My Garage', -- ignored if multizone
            ['confirm'] = '[ENTER]',
            ['reject'] = '[BACK]',
            ['thread_dist'] = 10,
            ['event_dist'] = 5,
            ['drawmarker'] = true,
            ['marker_type'] = 36,
            ['event'] = 'opengarage',
            ['invehicle_title'] = 'Store Vehicle', -- title to show instead of the ['title']
            ['spawnped'] = `g_m_importexport_01`, -- set to false if no spawnpeds else `g_m_importexport_01` (model)
        }
        zoneadd = exports['renzu_rayzone']:AddZone('Garage Zone Multi', garage) -- export!
        Wait(100)
        parking_prop = { -- Example using parking prop for parking garage
            ['type'] = 'object',
            ['job'] = 'all',
            ['model'] = {"prop_parking_hut_2","prop_parking_hut_2b","ch_prop_parking_hut_2","prop_parkingpay","dt1_21_parkinghut","prop_parking_sign_07"},
            ['dist'] = 7,
            --['target'] = 'bone',
            uidata = {
                ['garagepublic'] = {
                    ['title'] = 'Public Garage',
                    ['type'] = 'event', -- event / export
                    ['content'] = 'renzu_garage:property',
                    ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {`street`,`coord`}, arg_unpack = true}, -- `street` = send current street name, `coord` = send current coordinates ( this is a shorcut function for custom args )
                },
            },
        }

        add = exports['renzu_rayzone']:AddRayCastTarget("Parking Target",parking_prop)
    end
end)

function MysqlGarage(plugin,type,query,var)
    local plugin = plugin
    local type = type
    local query = query
    local var = var
    if type == 'fetchAll' and plugin == 'mysql-async' then
        local data = nil
        local res = MySQL.Async.fetchAll(query, var, function(result)
            data = result
        end)
        while data == nil do Wait(1) end
        return data
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Sync.execute(query,var) 
    end
    if type == 'execute' and plugin == 'ghmattisql' then
        exports['ghmattimysql']:execute(query, var)
    end
    if type == 'fetchAll' and plugin == 'ghmattisql' then
        local data = nil
        exports.ghmattimysql:execute(query, var, function(result)
            data = result
        end)
        while data == nil do Wait(0) end
        return data
    end
end

RegisterServerEvent('renzu_garage:GetVehiclesTable')
AddEventHandler('renzu_garage:GetVehiclesTable', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    --local Owned_Vehicle = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {['@owner'] = xPlayer.identifier})
    local Owned_Vehicle = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE owner = @owner', {['@owner'] = xPlayer.identifier})
    TriggerClientEvent("renzu_garage:receive_vehicles", src , Owned_Vehicle,vehicles)
end)

RegisterServerEvent('renzu_garage:GetVehiclesTableImpound')
AddEventHandler('renzu_garage:GetVehiclesTableImpound', function()
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    --local Impounds = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE impound = 1', {})
    local Impounds = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE impound = 1', {})
    TriggerClientEvent("renzu_garage:receive_vehicles", src , Impounds,vehicles)
end)

ESX.RegisterServerCallback('renzu_garage:getowner',function(source, cb, identifier)
    local owner = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})
	cb(owner)
end)

function bool_to_number(value)
    if value then
    return tonumber(1)
    else
    return tonumber(0)
    end
end

ESX.RegisterServerCallback('renzu_garage:returnpayment', function (source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= Config.ReturnPayment then
        xPlayer.removeMoney(Config.ReturnPayment)
        cb(true)
    else
        cb(false)
    end
end)

local garageshare = {}

function DoiOwnthis(xPlayer,id)
    local owned = false
    for k,v in pairs(current_routing) do
        if tonumber(v) == tonumber(xPlayer.source) and GetPlayerRoutingBucket(xPlayer.source) == tonumber(k) then
            owned = true
        end
    end
    return owned
end

ESX.RegisterServerCallback('renzu_garage:getinventory', function (source, cb, id, share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    local share = share
    local id = id
    if share and not DoiOwnthis(xPlayer,id) then
        identifier = share.owner
    end
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM private_garage WHERE identifier = @identifier and garage = @garage', {
        ['@identifier'] = identifier,
        ['@garage'] = id
    })
    local inventory = {}
    if json.decode(result[1].inventory) then
        inventory = json.decode(result[1].inventory) or {}
    end
    id = nil
    share = nil
    cb(inventory)
end)

ESX.RegisterServerCallback('renzu_garage:itemavailable', function (source, cb, id, item, share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    local share = share
    local id = id
    local item = item
    if share and not DoiOwnthis(xPlayer,id) then
        identifier = share.owner
    end
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM private_garage WHERE identifier = @identifier and garage = @garage', {
        ['@identifier'] = identifier,
        ['@garage'] = id
    })
    local inventory = false
    if json.decode(result[1].inventory) then
        inventory = json.decode(result[1].inventory) or {}
        if inventory[item] ~= nil and inventory[item] > 0 then
            inventory[item] = inventory[item] - 1
            MysqlGarage(Config.Mysql,'execute','UPDATE private_garage SET inventory = @inventory WHERE garage = @garage and identifier = @identifier', {
                ['@inventory'] = json.encode(inventory),
                ['@garage'] = id,
                ['@identifier'] = identifier,
            })
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
    share = nil
    id = nil
    item = nil
end)

RegisterServerEvent('renzu_garage:storemod')
AddEventHandler('renzu_garage:storemod', function(id,mod,lvl,newprop,share,save,savepartsonly)
	print(savepartsonly)
    local newprop = newprop
	local savepartsonly = savepartsonly
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local id = id
    local identifier = xPlayer.identifier
	local save = save
	local share = share
    if share and not DoiOwnthis(xPlayer,id) then
        identifier = share.owner
    end
    local success = false
    local vehicles = nil
    if not savepartsonly then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM private_garage WHERE identifier = @identifier and garage = @garage', {
            ['@identifier'] = identifier,
            ['@garage'] = id
        })
        vehicles = json.decode(result[1].vehicles)
        success = false
        for k,v in pairs(vehicles) do
            if v.vehicle == nil then v.taken = false end
            if v.taken and newprop.plate == v.vehicle.plate then
                v.vehicle = newprop
                success = true
                break
            end
        end
    end
    if success and not savepartsonly or savepartsonly then
        if not savepartsonly then
            MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle WHERE TRIM(UPPER(plate)) = @plate', {
                ['@vehicle'] = json.encode(newprop),
                ['@garage_id'] = 'private',
                ['@plate'] = string.gsub(newprop.plate:upper(), '^%s*(.-)%s*$', '%1'),
                ['@stored'] = 0
            })
        end
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM private_garage WHERE identifier = @identifier and garage = @garage', {
            ['@identifier'] = identifier,
            ['@garage'] = id
        })
        local inventory = json.decode(result[1].inventory) or {}
        if not save then
            local modname = mod.name..'-'..lvl
            if inventory[modname] == nil then
                inventory[modname] = 1
            else
                inventory[modname] = inventory[modname] + 1
            end
        end
        if savepartsonly then
            MysqlGarage(Config.Mysql,'execute','UPDATE private_garage SET inventory = @inventory WHERE garage = @garage and identifier = @identifier', {
                ['@inventory'] = json.encode(inventory),
                ['@garage'] = id,
                ['@identifier'] = identifier,
            })
        else
            MysqlGarage(Config.Mysql,'execute','UPDATE private_garage SET `vehicles` = @vehicles, inventory = @inventory WHERE garage = @garage and identifier = @identifier', {
                ['@vehicles'] = json.encode(vehicles),
                ['@inventory'] = json.encode(inventory),
                ['@garage'] = id,
                ['@identifier'] = identifier,
            })
        end
        newprop = {}
        share = false
        save = nil
        savepartsonly = nil
        TriggerClientEvent('renzu_notify:Notify', src, 'success','Garage', 'You Successfully store the parts ('..mod.name..')')
    else
        TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'this vehicle mod does not exist in your garage')
    end
end)

RegisterServerEvent('renzu_garage:buygarage')
AddEventHandler('renzu_garage:buygarage', function(id,v)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    if xPlayer.getMoney() >= v.cost then
        MysqlGarage(Config.Mysql,'execute','INSERT INTO private_garage (identifier, garage, vehicles) VALUES (@identifier, @garage, @vehicles)', {
            ['@identifier']   = xPlayer.identifier,
            ['@garage']   = id,
            ['@vehicles'] = '[]'
        })
        xPlayer.removeMoney(v.cost)
        TriggerClientEvent('renzu_notify:Notify', src, 'success','Garage', 'You Successfully Purchase this Garage ('..id..')')
    else
        TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'not enough money')
    end
end)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

RegisterServerEvent('renzu_garage:storeprivate')
AddEventHandler('renzu_garage:storeprivate', function(id,v,prop)
    local id = id
    local prop = prop
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE owner = @owner and TRIM(UPPER(plate)) = @plate LIMIT 1', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = string.gsub(prop.plate:upper(), '^%s*(.-)%s*$', '%1')
    })
    if not Config.Allowednotowned and result[1] == nil then TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'You dont owned the vehicle') return end
    local garage = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM private_garage WHERE identifier = @identifier and garage = @garage', {
        ['@identifier'] = xPlayer.identifier,
        ['@garage'] = id
    })
    local vehiclesgarage = {}
    vehiclesgarage = json.decode(garage[1].vehicles) or {}
    local success = false
    local newgarage = true
    for k,v in pairs(vehiclesgarage) do
        newgarage = false
        if v.vehicle == nil then v.taken = false end
        if not v.taken then
            v.taken = true
            v.vehicle = prop
            print(prop.plate)
            success = true
            break
        end
    end
    if newgarage then
        local pgarage = deepcopy(private_garage[id].park)
        for k,v in pairs(pgarage) do
            vehiclesgarage[k] = v
            if v.vehicle == nil then vehiclesgarage[k].taken = false end
            if not vehiclesgarage[k].taken and k == #pgarage then
                vehiclesgarage[k].taken = true
                vehiclesgarage[k].vehicle = prop
                print(prop.plate)
                break
            end
        end
    end
    if success and not newgarage or newgarage then
        MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle WHERE TRIM(UPPER(plate)) = @plate and owner = @owner', {
            ['@vehicle'] = json.encode(prop),
            ['@garage_id'] = 'private',
            ['@plate'] = string.gsub(prop.plate:upper(), '^%s*(.-)%s*$', '%1'),
            ['@owner'] = xPlayer.identifier,
            ['@stored'] = 0
        })
        MysqlGarage(Config.Mysql,'execute','UPDATE private_garage SET `vehicles` = @vehicles WHERE garage = @garage and identifier = @identifier', {
            ['@vehicles'] = json.encode(vehiclesgarage),
            ['@garage'] = id,
            ['@identifier'] = xPlayer.identifier,
        })
        TriggerClientEvent('renzu_notify:Notify', src, 'success','Garage', 'You Successfully Stored this vehicle')
        vehiclesgarage = {}
        pgarage = {}
        --ever wonder why need to declare this? i dont know too, but without this, it cause a data duplicate, must be fx version bug! happens only on > recommended like 4680 or > 4680
    else
        TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'There is not enough space in this garage')
    end
end)

RegisterServerEvent('renzu_garage:gotogarage')
AddEventHandler('renzu_garage:gotogarage', function(id,v,share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    if share and not DoiOwnthis(xPlayer,id) then
        identifier = v.owner
    end
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM private_garage WHERE identifier = @identifier and garage = @garage', {
        ['@identifier'] = identifier,
        ['@garage'] = id
    })
    local routing = 0
    local haveworld = false
    for k,v in pairs(current_routing) do
        if tonumber(v) == tonumber(source) then
            haveworld = true
            routing = tonumber(k)
        end
    end
    if not haveworld then
        default_routing[source] = GetPlayerRoutingBucket(source)
    end
    if not share and not haveworld then
        for route = default_routing[source]+100, 65000 do
            routing = route
            if current_routing[route] == nil then
                break
            end
        end
    elseif share then
        routing = v.route
    end
    SetPlayerRoutingBucket(source,routing)
    if not share and not haveworld then
        current_routing[routing] = source
    end
    Wait(1000)
    -- SetEntityCoords(GetPlayerPed(source),private_garage[id].coords.x,private_garage[id].coords.y,private_garage[id].coords.z,true)
    -- SetEntityHeading(GetPlayerPed(source),private_garage[id].coords.w)
    lastgarage[source] = id
	local vehicle_ = {}
	for k,v in pairs(json.decode(result[1].vehicles)) do
		vehicle_[k] = v
	end
    TriggerClientEvent('renzu_garage:ingarage',source, result[1],private_garage[id],id, vehicle_)
    -- for k,v in pairs(json.decode(result[1].vehicles)) do
    --     print(k,v.vehicle)
    --     if v.vehicle ~= nil and v.taken then
    --         CreateVehicle(v.vehicle.model,v.coord.x,v.coord.y,v.coord.z,v.coord.w,false,false)
    --     end
    -- end
    --SetEntityCoords(GetPlayerPed(source),private_garage[id].coords.x,private_garage[id].coords.y,private_garage[id].coords.z,true)
    --SetEntityHeading(GetPlayerPed(source),private_garage[id].coords.w)

end)

RegisterServerEvent('renzu_garage:exitgarage')
AddEventHandler('renzu_garage:exitgarage', function(table,prop,id,choose,share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = id
    if not choose then
        --SetEntityCoords(GetPlayerPed(source),table.buycoords.x,table.buycoords.y,table.buycoords.z,true)
        TriggerClientEvent('renzu_garage:exitgarage',source, table, true)
        SetPlayerRoutingBucket(source,default_routing[source])
        --current_routing[default_routing[source]] = nil
    else
        local identifier = xPlayer.identifier
        if share and not DoiOwnthis(xPlayer,id) then
            identifier = share.owner
        end
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM private_garage WHERE identifier = @identifier and garage = @garage', {
            ['@identifier'] = identifier,
            ['@garage'] = id
        })
        local vehicles = json.decode(result[1].vehicles)
        local success = false
        for k,v in pairs(vehicles) do
            if v.vehicle == nil then v.taken = false end
            if v.taken and v.vehicle ~= nil and v.vehicle.plate == prop.plate then
                v.taken = false
                v.vehicle = nil
                success = true
                break
            end
        end
        local result = MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle WHERE TRIM(UPPER(plate)) = @plate and owner = @owner', {
            ['@vehicle'] = json.encode(prop),
            ['@garage_id'] = 'A',
            ['@plate'] = string.gsub(prop.plate:upper(), '^%s*(.-)%s*$', '%1'),
            ['@owner'] = identifier,
            ['@stored'] = 0
        })
        local result = MysqlGarage(Config.Mysql,'execute','UPDATE private_garage SET `vehicles` = @vehicles WHERE garage = @garage and identifier = @identifier', {
            ['@vehicles'] = json.encode(vehicles),
            ['@garage'] = id,
            ['@identifier'] = identifier,
        })
        TriggerClientEvent('renzu_notify:Notify', source, 'success','Garage', 'You Successfully Take out the vehicle')
        --SetEntityCoords(GetPlayerPed(source),table.buycoords.x,table.buycoords.y,table.buycoords.z,true)
        TriggerClientEvent('renzu_garage:exitgarage',source, table, true)
        Wait(500)
        --current_routing[default_routing[source]] = nil
        TriggerClientEvent('renzu_garage:choose',source,prop,table)
		Wait(1000)
		SetPlayerRoutingBucket(source,default_routing[source])
        TriggerClientEvent('renzu_garage:syncstate',-1,string.gsub(prop.plate:upper(), '^%s*(.-)%s*$', '%1'),source)
    end
    lastgarage[source] = nil
end)


ESX.RegisterServerCallback('renzu_garage:isgarageowned', function (source, cb, id, v)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = id
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT identifier FROM private_garage WHERE identifier = @identifier and garage = @garage', {
        ['@identifier'] = xPlayer.identifier,
        ['@garage'] = id
    })
    local garage_share = {}
    if result and result[1] ~= nil then
        if garageshare[tonumber(source)] ~= nil then
            garage_share = garageshare[tonumber(source)]
        end
        cb(true,garage_share)
    else
        if garageshare[tonumber(source)] ~= nil then
            garage_share = garageshare[tonumber(source)]
        end
        cb(false,garage_share)
    end
end)

RegisterCommand(Config.GiveAccessCommand, function(source, args, rawCommand)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if lastgarage[source] then
        for k,v in pairs(current_routing) do
            if v == source then
                print('added',tonumber(args[1]))
                garageshare[tonumber(args[1])] = {}
                garageshare[tonumber(args[1])].owner = xPlayer.identifier
                garageshare[tonumber(args[1])].route = k
                garageshare[tonumber(args[1])].garage = lastgarage[source]
            end
        end
    else
        TriggerClientEvent('renzu_notify:Notify', source, 'warning','Garage', 'You must be in garage to invite')
    end
end)

ESX.RegisterServerCallback('renzu_garage:parkingmeter', function (source, cb, coord, coord2,prop)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local coord = coord
    local coord2 = coord2
    local prop = prop
    if xPlayer.getMoney() >= Config.MeterPayment then
        local canpark = true
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT coord FROM parking_meter', {})
        if result then
            for k,v in pairs(result) do
                local c = json.decode(v.coord)
                if v.coord ~= nil and #(vector3(c.x,c.y,c.z) - coord) < 7 then
                    canpark = false
                end
            end
        end
        if canpark then
            MysqlGarage(Config.Mysql,'execute','INSERT INTO parking_meter (identifier, coord, park_coord, vehicle, plate) VALUES (@identifier, @coord, @park_coord, @vehicle, @plate)', {
                ['@identifier']   = xPlayer.identifier,
                ['@coord']   = json.encode(coord),
                ['@park_coord']   = json.encode(coord2),
                ['@vehicle'] = prop,
                ['@plate'] = json.decode(prop).plate
            })
            xPlayer.removeMoney(Config.MeterPayment)
            TriggerClientEvent('renzu_notify:Notify', src, 'success','Garage', 'You Successfully Park the vehicle')
            Wait(300)
            parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
            Wait(200)
            TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles,json.decode(prop).plate,parkmeter)
            cb(true)
        else
            TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'Parking is occupied')
            cb(false)
        end
    else
        TriggerClientEvent('renzu_notify:Notify', src, 'error','Garage', 'Not Enough Money to pay parking')
        cb(false)
    end
end)

RegisterServerEvent('renzu_garage:getparkmeter')
AddEventHandler('renzu_garage:getparkmeter', function(plate,state,model)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter WHERE TRIM(UPPER(plate)) = @plate', {['@plate'] = plate})
        if #result > 0 then
            MysqlGarage(Config.Mysql,'execute','DELETE FROM parking_meter WHERE TRIM(UPPER(plate)) = @plate', {['@plate'] = plate})
            Wait(300)
            parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
            Wait(200)
            TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles,plate:upper(),parkmeter)
        else
            xPlayer.showNotification("This Vehicle is not your property", 1, 0)
        end
    end
end)

ESX.RegisterServerCallback('renzu_garage:isvehicleingarage', function (source, cb, plate, id, ispolice)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    if plate == Config.DefaultPlate then
        cb(true,0)
    else
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT `stored` ,impound FROM owned_vehicles WHERE TRIM(UPPER(plate)) = @plate', {
            ['@plate'] = plate
        })
        if id == 'impound' and Config.Impoundforall and not ispolice then
            if xPlayer.getMoney() >= Config.ImpoundPayment then
                xPlayer.removeMoney(Config.ImpoundPayment)
                TriggerClientEvent('renzu_notify:Notify', source, 'success','Garage', 'Successfully Retrieve Owned vehicle')
                cb(1,1)
            else
                TriggerClientEvent('renzu_notify:Notify', source, 'error','Garage', 'Fail to retrieve vehicle, not enough money cabron')
                cb(false)
            end
        elseif result and result[1].stored ~= nil then
            local stored = result[1].stored
            local impound = result[1].impound
            cb(stored,impound)
        end
    end
end)

RegisterServerEvent('renzu_garage:GetParkedVehicles')
AddEventHandler('renzu_garage:GetParkedVehicles', function()
    print("sending")
    TriggerClientEvent('renzu_garage:update_parked',source,parkedvehicles, false, parkmeter)
end)

RegisterServerEvent('renzu_garage:park')
AddEventHandler('renzu_garage:park', function(plate,state,coord,model,props)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE owner = @owner and TRIM(UPPER(plate)) = @plate LIMIT 1', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate
        })
        if #result > 0 then
            if result[1].vehicle ~= nil then
                local veh = json.decode(result[1].vehicle)
                if veh.model == model then
                    local result = MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle , park_coord = @park_coord, isparked = @isparked WHERE TRIM(UPPER(plate)) = @plate and owner = @owner', {
                        ['@vehicle'] = json.encode(props),
                        ['@garage_id'] = 'PARKED',
                        ['@plate'] = plate:upper(),
                        ['@owner'] = xPlayer.identifier,
                        ['@stored'] = 0,
                        ['@park_coord'] = json.encode(coord),
                        ['@isparked'] = state
                    })
                    Wait(800)
                    parkedvehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE isparked = 1', {}) or {}
                    parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
                    Wait(200)
                    TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles, false, parkmeter)
                else
                    print('exploiting')
                end
            end
        else
            xPlayer.showNotification("This Vehicle is not your property", 1, 0)
        end
    end
end)

RegisterServerEvent('renzu_garage:unpark')
AddEventHandler('renzu_garage:unpark', function(plate,state,model)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE TRIM(UPPER(plate)) = @plate LIMIT 1', {
            ['@plate'] = plate
        })
        if #result > 0 then
            if result[1].vehicle ~= nil then
                local veh = json.decode(result[1].vehicle)
                if veh.model == model then
                    local result = MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle , park_coord = @park_coord, isparked = @isparked WHERE TRIM(UPPER(plate)) = @plate and owner = @owner', {
                        ['vehicle'] = result[1].vehicle,
                        ['@garage_id'] = 'A',
                        ['@plate'] = plate:upper(),
                        ['@owner'] = xPlayer.identifier,
                        ['@stored'] = 0,
                        ['@park_coord'] = json.encode(coord),
                        ['@isparked'] = 0
                    })
                    Wait(300)
                    parkedvehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE isparked = 1', {}) or {}
                    Wait(200)
                    parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
                    TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles,plate:upper(),parkmeter)
                else
                    print('exploiting')
                end
            end
        else
            xPlayer.showNotification("This Vehicle is not your property", 1, 0)
        end
    end
end)

RegisterServerEvent('renzu_garage:changestate')
AddEventHandler('renzu_garage:changestate', function(plate,state,garage_id,model,props)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    local state = tonumber(state)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE owner = @owner and TRIM(UPPER(plate)) = @plate LIMIT 1', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate
        })
        if #result > 0 and garage_id ~= 'impound' then
            local updatepark = false
            for k,park in pairs(parkedvehicles) do
                if string.gsub(tostring(park.plate), '^%s*(.-)%s*$', '%1'):upper() == plate:upper() then
                    updatepark = true
                end
            end
            if result[1].vehicle ~= nil then
                local veh = json.decode(result[1].vehicle)
                if veh.model == model then
                    local result = MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, vehicle = @vehicle, isparked = @isparked WHERE TRIM(UPPER(plate)) = @plate and owner = @owner', {
                        ['vehicle'] = json.encode(props),
                        ['@garage_id'] = garage_id,
                        ['@plate'] = plate:upper(),
                        ['@owner'] = xPlayer.identifier,
                        ['@stored'] = state,
                        ['@isparked'] = 0
                    })
                    if updatepark then
                        Wait(300)
                        parkedvehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE isparked = 1', {}) or {}
                        Wait(200)
                        parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
                        TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles,plate:upper(),parkmeter)
                    end
                    if state == 1 then
                        TriggerClientEvent('renzu_notify:Notify', source, 'success','Garage', 'You Successfully Store the vehicle')
                    else
                        TriggerClientEvent('renzu_notify:Notify', source, 'success','Garage', 'You Successfully Take out the vehicle')
                    end
                else
                    print('exploiting')
                end
            end
        elseif Config.JobImpounder[xPlayer.job.name] ~= nil and garage_id == 'impound' then
            if state == 1 then
                garage_id = 'impound'
                chopstatus = os.time()
            else
                garage_id = 'A'
                chopstatus = os.time()
            end
            local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE TRIM(UPPER(plate)) = @plate LIMIT 1', {
                ['@plate'] = plate:upper()
            })
            if #result > 0 then
                local updatepark = false
                for k,park in pairs(parkedvehicles) do
                    if park.plate:upper() == plate:upper() then
                        updatepark = true
                    end
                end
                local veh = json.decode(result[1].vehicle)
                if veh.model == model then
                    MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `stored` = @stored, garage_id = @garage_id, impound = @impound, vehicle = @vehicle, isparked = @isparked WHERE TRIM(UPPER(plate)) = @plate', {
                        ['vehicle'] = json.encode(props),
                        ['@garage_id'] = garage_id,
                        ['@impound'] = state,
                        ['@plate'] = plate:upper(),
                        ['@stored'] = state,
                        ['@isparked'] = 0
                    })
                    if updatepark then
                        Wait(300)
                        parkedvehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE isparked = 1', {}) or {}
                        Wait(200)
                        parkmeter = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM parking_meter', {}) or {}
                        TriggerClientEvent('renzu_garage:update_parked',-1,parkedvehicles,plate:upper(),parkmeter)
                    end
                    TriggerClientEvent('renzu_notify:Notify', source, 'success','Garage', 'You Take out the Vehicle')
                else
                    print('exploiting')
                end
            else
                TriggerClientEvent('renzu_notify:Notify', source, 'error','Garage', 'Vehicle is not impoundable')
                --xPlayer.showNotification("This Vehicle is local car", 1, 0)
            end
        else
            TriggerClientEvent('renzu_notify:Notify', source, 'info','Garage', 'Vehicle is not your property')
            --xPlayer.showNotification("This Vehicle is not your property", 1, 0)
        end
    end
end)

RegisterServerEvent('renzu_garage:transfercar')
AddEventHandler('renzu_garage:transfercar', function(plate,id)
    if not Config.PlateSpace then
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    else
        plate = string.gsub(tostring(plate), '^%s*(.-)%s*$', '%1'):upper()
    end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local transfer = ESX.GetPlayerFromId(id)
    if id == nil then
        xPlayer.showNotification("Invalid User ID! (Must be Digits only)", 1, 0)
    else
        if plate and transfer then
            local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE TRIM(UPPER(plate)) = @plate and owner = @owner LIMIT 1', {
                ['@plate'] = plate:upper(),
                ['@owner'] = xPlayer.identifier
            })
            if #result > 0 then
                MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate', {
                    ['plate'] = plate:upper(),
                    ['owner'] = transfer.identifier
                })
                xPlayer.showNotification("You Transfer the car with plate #"..plate.." to "..transfer.name.."", 1, 0)
                transfer.showNotification("You Receive a car with plate #"..plate.." from "..xPlayer.name.."", 1, 0)
            else
                xPlayer.showNotification("This Vehicle is not your property", 1, 0)
            end
        elseif not transfer then
            xPlayer.showNotification("User Does not Exist!", 1, 0)
        else
            xPlayer.showNotification("Invalid Plate number! (Must be Digits only)", 1, 0)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k,v in pairs(default_routing) do
        SetPlayerRoutingBucket(k,0)
    end
    print('The resource ' .. resourceName .. ' was stopped.')
end)  
