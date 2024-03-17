local combinator = table.deepcopy(data.raw["item"]["arithmetic-combinator"])

combinator.name = "signal-diode-combinator"
combinator.place_result="signal-diode-combinator"
combinator.order = "b[combinators]-d[signal-diode-combinator]"
combinator.icon = "__diode-combinator__/graphics/icons/diode-combinator.png"

data:extend{combinator}
