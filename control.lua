
function add_commands()

    commands.add_command("showStops","shows stops",function() 
        print_table(global.personalStops)
    end)

    commands.add_command("showTrains","shows trains",function() 
        local personal_trains = get_personal_trains()
        print_personal_trains(personal_trains)
    end)

    commands.add_command("getNearestStop","shows stops",function(t) 
        game.print(get_nearest_stop(game.get_player(t.player_index)).unit_number)
    end)

    commands.add_command("callTrain","calls train",function(t)
        game.print(t.parameter)
        local train_id = tonumber(t.parameter)
        local nearest_stop = get_nearest_stop(game.get_player(t.player_index))

        call_train(nearest_stop,train_id)
    end)

end

script.on_init(function()
    global.personalStops = {}
    global.personalLocomotives = {}
    global.personalTrains = {}

    add_commands()
end)

script.on_load(function()
    add_commands()
end)

function print_table(t)
    for key,value in pairs(t) do
        game.print(string.format("[<%d>, <%d>]",value.position.x,value.position.y))
    end
end

local function remove_entity_from_table(t,entity)

    local to_remove = 0
    for key,value in pairs(t) do
        if value.position.x == entity.position.x and value.position.y == entity.position.y then
            to_remove = key
            break 
        end
    end

    table.remove( t , to_remove )
end

function get_personal_trains()
    local personal_trains = {}

    for key,value in pairs(global.personalLocomotives) do
        if value.name == 'personal-train' then
            table.insert( personal_trains, value.train.id ,value.train )
        end
    end

    return personal_trains
end

function print_personal_trains(personal_trains)
    for key,value in pairs(personal_trains) do
        game.print(string.format( "%d --> %d", key,value.id ))
    end
end

function get_nearest_stop(player)
    local nearest_stop = global.personalStops[0]
    local min_distance =  1000000

    for key,value in pairs(global.personalStops) do
        local distance = math.sqrt( math.pow((math.abs(value.position.x - player.position.x)),2) +math.pow((math.abs(value.position.y - player.position.y)),2))
        if distance <= min_distance then
            min_distance = distance
            nearest_stop = value
        end
    end

    return nearest_stop
end

function call_train(stop,train_id)

    local personal_trains = get_personal_trains()
    local train = personal_trains[train_id]

    if train == nil then
        game.print(string.format("train nill of %d",train_id))
        return
    end

    train.schedule = nil

    new_schedule = {
        current = 1,
        records = {
            {
                station = stop.backer_name,
                wait_conditions = {
                    {
                        type = "empty",
                        compare_type = "or",
                    }
                }
            }
        }
    }

    train.schedule = new_schedule
    train.manual_mode = false

end

script.on_event(defines.events.on_built_entity,function(event) 
    
    if event.created_entity.name == 'personal-train-stop' then
        table.insert(global.personalStops,event.created_entity.unit_number,event.created_entity)
    end

    if event.created_entity.name == 'personal-train' then
        table.insert( global.personalLocomotives,event.created_entity)
    end

end)

script.on_event(defines.events.on_entity_died,function(event)

    if event.entity.name == 'personal-train-stop' then
        remove_entity_from_table(global.personalStops,event.entity)
    end

    if event.entity.name == 'personal-train' then
        remove_entity_from_table(global.personalLocomotives,event.entity)
    end

end)

script.on_event(defines.events.on_player_mined_entity,function(event)

    if event.entity.name == 'personal-train-stop' then
        remove_entity_from_table(global.personalStops,event.entity)
    end

    if event.entity.name == 'personal-train' then
        remove_entity_from_table(global.personalLocomotives,event.entity)
    end

end)


