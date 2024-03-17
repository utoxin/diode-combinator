local main = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])

local full_display_sprite = {
	north = {
		filename = "__diode-combinator__/graphics/entities/diode-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.north.scale,
		shift = main.and_symbol_sprites.north.shift,
		hr_version = {
			filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.north.hr_version.scale,
			shift = main.and_symbol_sprites.north.hr_version.shift
		}
	},
	east = {
		filename = "__diode-combinator__/graphics/entities/diode-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.east.scale,
		shift = main.and_symbol_sprites.east.shift,
		hr_version = {
			filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.east.hr_version.scale,
			shift = main.and_symbol_sprites.east.hr_version.shift
		}
	},
	south = {
		filename = "__diode-combinator__/graphics/entities/diode-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.south.scale,
		shift = main.and_symbol_sprites.south.shift,
		hr_version = {
			filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.south.hr_version.scale,
			shift = main.and_symbol_sprites.south.hr_version.shift
		}
	},
	west = {
		filename = "__diode-combinator__/graphics/entities/diode-combinator-display.png",
		width = 15,
		height = 11,
		scale = main.and_symbol_sprites.west.scale,
		shift = main.and_symbol_sprites.west.shift,
		hr_version = {
			filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
			width = 30,
			height = 22,
			scale = main.and_symbol_sprites.west.hr_version.scale,
			shift = main.and_symbol_sprites.west.hr_version.shift
		}
	}
}

main.name = "signal-diode-combinator"
main.minable.result = "signal-diode-combinator"
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
main.icon = "__diode-combinator__/graphics/icons/diode-combinator.png"

data:extend{main}
