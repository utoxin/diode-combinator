data:extend{{
    name = "signal-diodes",
    type = "technology",
    icon = "__base__/graphics/technology/circuit-network.png",
    icon_mipmaps = 4,
    icon_size = 256,
    order = "a-d-e",
    prerequisites = {
        "circuit-network"
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "signal-diode-combinator"
        }
    },
    unit = {
        time = 15,
        count = 50,
        ingredients = {
          {
            "automation-science-pack",
            1
          },
          {
            "logistic-science-pack",
            1
          }
        }
    }
}}