--locomotive
data:extend(
    {
        {
            type = "item-with-entity-data",
            name = "personal-train",
            icon = "__personalTrains__/graphics/icons/farl.png",
            icon_size = 32,
            subgroup = "transport",
            order = "a[train-system]-fb[locomotive]",
            place_result = "personal-train",
            stack_size = 5
        },
        {
        type = "item",
        name = "personal-train-stop",
        icon = "__personalTrains__/graphics/icons/station.png",
        icon_size = 32,
        subgroup = "transport",
        order = "a[train-system]-fb[station]",
        place_result = "personal-train-stop",
        stack_size = 5
        }
    }
)