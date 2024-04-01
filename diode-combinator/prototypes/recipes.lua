data:extend {
	{
		type        = "recipe",
		name        = "signal-diode-combinator",
		enabled     = "false",
		ingredients = {
			{ "arithmetic-combinator", 1 },
			{ "electronic-circuit", 1 },
		},
		result      = "signal-diode-combinator",
	},
}

if mods["Ultracube"] then
	local recipe = data.raw.recipe["signal-diode-combinator"]

	recipe.category = "cube-fabricator-handcraft"
	recipe.ingredients = {
		{ "arithmetic-combinator", 1 },
		{ "cube-electronic-circuit", 1 },
	}
end