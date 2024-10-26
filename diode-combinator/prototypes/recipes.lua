data:extend {
	{
		type        = "recipe",
		name        = "signal-diode-combinator",
		enabled     = false,
		ingredients = {
			{ type="item", name="arithmetic-combinator", amount=1 },
			{ type="item", name="electronic-circuit", amount=1 },
		},
		results      = {
			{type="item", name="signal-diode-combinator", amount=1}
		}
	},
}

if mods["Ultracube"] then
	local recipe = data.raw.recipe["signal-diode-combinator"]

	recipe.category = "cube-fabricator-handcraft"
	recipe.ingredients = {
		{ type="item", name="arithmetic-combinator", amount=1 },
		{ type="item", name="cube-electronic-circuit", amount=1 },
	}
end