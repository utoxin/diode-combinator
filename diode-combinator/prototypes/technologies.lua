data:extend { {
				  name          = "signal-diodes",
				  type          = "technology",
				  icon          = "__base__/graphics/technology/circuit-network.png",
				  icon_mipmaps  = 4,
				  icon_size     = 256,
				  order         = "a-d-e",
				  prerequisites = {
					  "circuit-network"
				  },
				  effects       = {
					  {
						  type   = "unlock-recipe",
						  recipe = "signal-diode-combinator"
					  }
				  },
				  unit          = {
					  time        = 15,
					  count       = 50,
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
			  } }

if mods["Ultracube"] then
	local tech         = data.raw.technology["signal-diodes"]
	tech.prerequisites = { "cube-combinatorics" }
	tech.unit          = {
		time        = 30,
        count       = 150,
        ingredients = {
			{"cube-basic-contemplation-unit", 1},
			{"cube-fundamental-comprehension-card", 1},
		}
	}
end
