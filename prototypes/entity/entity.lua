local function copyPrototype(type, name, newName, change_results)
    if not data.raw[type][name] then error("type "..type.." "..name.." doesn't exist") end
    local p = table.deepcopy(data.raw[type][name])
    p.name = newName
    if p.minable and p.minable.result then
        p.minable.result = newName
    end
    if change_results then
        if p.place_result then
            p.place_result = newName
        end
        if p.result then
            p.result = newName
        end
        if p.take_result then
            p.take_result = newName
        end
        if p.placed_as_equipment_result then
            p.placed_as_equipment_result = newName
        end
    end
    return p
end


local locomotive = copyPrototype("locomotive", "locomotive", "personal-train")
locomotive.icon = "__personalTrains__/graphics/icons/farl.png"
locomotive.max_speed = 0.8
locomotive.burner.fuel_inventory_size = 4

locomotive.color = {r = 0, g = 0, b = 1, a = 0.8}
--locomotive.color = {r = 0.8, g = 0.40, b = 0, a = 0.8}
data:extend({locomotive})


local station = copyPrototype("train-stop","train-stop","personal-train-stop")
station.icon = "__personalTrains__/graphics/icons/station.png"

data:extend({station})

