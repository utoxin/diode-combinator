local main = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])
local output = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])

local full_display_sprite = {
	north = {
		filename = "__Filter_Combinator__/graphics/entities/filter-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.north.scale,
		shift = main.and_symbol_sprites.north.shift,
		hr_version = {
			filename = "__Filter_Combinator__/graphics/entities/hr-filter-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.north.hr_version.scale,
			shift = main.and_symbol_sprites.north.hr_version.shift
		}
	},
	east = {
		filename = "__Filter_Combinator__/graphics/entities/filter-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.east.scale,
		shift = main.and_symbol_sprites.east.shift,
		hr_version = {
			filename = "__Filter_Combinator__/graphics/entities/hr-filter-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.east.hr_version.scale,
			shift = main.and_symbol_sprites.east.hr_version.shift
		}
	},
	south = {
		filename = "__Filter_Combinator__/graphics/entities/filter-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.south.scale,
		shift = main.and_symbol_sprites.south.shift,
		hr_version = {
			filename = "__Filter_Combinator__/graphics/entities/hr-filter-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.south.hr_version.scale,
			shift = main.and_symbol_sprites.south.hr_version.shift
		}
	},
	west = {
		filename = "__Filter_Combinator__/graphics/entities/filter-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.west.scale,
		shift = main.and_symbol_sprites.west.shift,
		hr_version = {
			filename = "__Filter_Combinator__/graphics/entities/hr-filter-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.west.hr_version.scale,
			shift = main.and_symbol_sprites.west.hr_version.shift
		}
	}
}

main.name = "signal-filter-combinator"
main.minable.result = "signal-filter-combinator"
main.and_symbol_sprites = full_display_sprite
main.divide_symbol_sprites = full_display_sprite
main.left_shift_symbol_sprites = full_display_sprite
main.minus_symbol_sprites = full_display_sprite
main.modulo_symbol_sprites = full_display_sprite
main.multiply_symbol_sprites = full_display_sprite
main.or_symbol_sprites = full_display_sprite
main.plus_symbol_sprites = full_display_sprite
main.power_symbol_sprites = full_display_sprite
main.right_shift_symbol_sprites = full_display_sprite
main.xor_symbol_sprites = full_display_sprite
main.icon = "__Filter_Combinator__/graphics/icons/filter-combinator.png"

local blank_sprite = {
	filename = "__Filter_Combinator__/graphics/entities/blank.png",
	width = 1,
	height = 1,
	frame_count = 1,
	shift = {0, 0}
}

output.name = "signal-filter-combinator-output"
output.selection_box = {{0, 0}, {0, 0}}
output.selection_priority = 0
output.flags = {"hidden", "hide-alt-info", "not-selectable-in-game", "not-upgradable", "not-in-kill-statistics"}
output.sprites = {
	north = blank_sprite,
	east = blank_sprite,
	south = blank_sprite,
	west = blank_sprite
}
output.activity_led_sprites = {
	north = blank_sprite,
	east = blank_sprite,
	south = blank_sprite,
	west = blank_sprite
}

local output_connection_points = table.deepcopy(main.output_connection_points)

-- N
output_connection_points[1].shadow.green[2]	=	output_connection_points[1].shadow.green[2] + 0.5
output_connection_points[1].shadow.red[2]	=	output_connection_points[1].shadow.red[2] + 0.5
output_connection_points[1].wire.green[2]	=	output_connection_points[1].wire.green[2] + 0.5
output_connection_points[1].wire.red[2]		=	output_connection_points[1].wire.red[2] + 0.5

-- E
output_connection_points[2].shadow.green[1]	=	output_connection_points[2].shadow.green[1] - 0.5
output_connection_points[2].shadow.red[1]	=	output_connection_points[2].shadow.red[1] - 0.5
output_connection_points[2].wire.green[1]	=	output_connection_points[2].wire.green[1] - 0.5
output_connection_points[2].wire.red[1]		=	output_connection_points[2].wire.red[1] - 0.5

-- S
output_connection_points[3].shadow.green[2]	=	output_connection_points[3].shadow.green[2] - 0.5
output_connection_points[3].shadow.red[2]	=	output_connection_points[3].shadow.red[2] - 0.5
output_connection_points[3].wire.green[2]	=	output_connection_points[3].wire.green[2] - 0.5
output_connection_points[3].wire.red[2]		=	output_connection_points[3].wire.red[2] - 0.5

-- W
output_connection_points[4].shadow.green[1]	=	output_connection_points[4].shadow.green[1] + 0.5
output_connection_points[4].shadow.red[1]	=	output_connection_points[4].shadow.red[1] + 0.5
output_connection_points[4].wire.green[1]	=	output_connection_points[4].wire.green[1] + 0.5
output_connection_points[4].wire.red[1]		=	output_connection_points[4].wire.red[1] + 0.5

output.circuit_wire_connection_points = output_connection_points

data:extend{main}
data:extend{output}