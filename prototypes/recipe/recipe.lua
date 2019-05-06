
--locomotive
data:extend(
    {
        {
            type = "recipe",
            name = "personal-train",
            enabled = "true",
            ingredients =
            {
                {"locomotive", 1},
                {"long-handed-inserter", 2}, 
                {"steel-plate", 5},
            },
            result = "personal-train"
        },
        {
            type = "recipe",
            name = "personal-train-stop",
            enabled = "true",
            ingredients =
            {
                {"locomotive", 1},
                {"long-handed-inserter", 2},
                {"steel-plate", 5},
            },
            result = "personal-train-stop"
        }
    }
)