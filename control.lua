
function add_commands()

    commands.add_command("showStops","shows stops",function() 
        print_table(global.personalStops)
    end)

    commands.add_command("showTrains","shows trains",function() 
        print_table(global.personalTrains)
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

local function get_nearest_stop(player)
    
end

script.on_event(defines.events.on_built_entity,function(event) 
    
    if event.created_entity.name == 'personal-train-stop' then
        table.insert(global.personalStops,event.created_entity)
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

    if event.item_stack.name == 'personal-train-stop' then
        remove_entity_from_table(global.personalStops,event.entity)
    end

    if event.item_stack.name == 'personal-train' then
        remove_entity_from_table(global.personalLocomotives,event.entity)
    end

end)


