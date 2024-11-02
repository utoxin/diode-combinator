local collision_mask_util = require('collision-mask-util')

local main = table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"])

local full_display_sprite = {
	north = {
		filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
		width = 30,
		height = 22,
		scale = main.and_symbol_sprites.north.scale,
		shift = main.and_symbol_sprites.north.shift
	},
	east = {
		filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
		width = 30,
		height = 22,
		scale = main.and_symbol_sprites.east.scale,
		shift = main.and_symbol_sprites.east.shift
	},
	south = {
		filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
		width = 30,
		height = 22,
		scale = main.and_symbol_sprites.south.scale,
		shift = main.and_symbol_sprites.south.shift
	},
	west = {
		filename = "__diode-combinator__/graphics/entities/hr-diode-combinator-display.png",
		width = 30,
		height = 22,
		scale = main.and_symbol_sprites.west.scale,
		shift = main.and_symbol_sprites.west.shift
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

if mods["compaktcircuit"] then

	local invisible_sprite = {
		filename = "__diode-combinator__/graphics/entities/blank.png",
		width = 1,
		height = 1
	}

    ---@class data.ArithmeticCombinatorPrototype
	local packed = table.deepcopy(main)

	local packed_wire_conn = {
		wire = {
			red = { 0, 0 },
			green = { 0, 0 }
		},
		shadow = {
			red = { 0, 0 },
			green = { 0, 0 }
		}
	}

	local packed_flags = {
		'placeable-off-grid',
		"hide-alt-info",
		"not-on-map",
		"not-upgradable",
		"not-deconstructable",
		"not-blueprintable"
	}

	packed.name = main.name .. "-packed"
	packed.minable = nil
	packed.sprites = invisible_sprite
	packed.and_symbol_sprites = invisible_sprite
	packed.divide_symbol_sprites = invisible_sprite
	packed.left_shift_symbol_sprites = invisible_sprite
	packed.minus_symbol_sprites = invisible_sprite
	packed.plus_symbol_sprites = invisible_sprite
	packed.power_symbol_sprites = invisible_sprite
	packed.multiply_symbol_sprites = invisible_sprite
	packed.or_symbol_sprites = invisible_sprite
	packed.right_shift_symbol_sprites = invisible_sprite
	packed.xor_symbol_sprites = invisible_sprite
	packed.modulo_symbol_sprites = invisible_sprite

	packed.flags = packed_flags
	packed.collision_mask = collision_mask_util.new_mask()
	packed.layer = collision_mask_util.new_mask()
	packed.selectable_in_game = false
	packed.circuit_wire_max_distance = 64
	packed.hidden = true
	packed.hidden_in_factoriopedia = true

	packed.activity_led_sprites = invisible_sprite
	packed.activity_led_light_offsets = { { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 } }
	packed.circuit_wire_connection_points = {
		packed_wire_conn,
		packed_wire_conn,
		packed_wire_conn,
		packed_wire_conn
	}

	packed.draw_circuit_wires = false
	packed.collision_box = nil
	packed.created_smoke = nil

	data:extend {packed}

end
