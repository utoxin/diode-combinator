local combinator = table.deepcopy(data.raw["item"]["arithmetic-combinator"])

combinator.name = "signal-diode-combinator"
combinator.place_result="signal-diode-combinator"
combinator.order = "b[combinators]-d[signal-diode-combinator]"
combinator.icon = "__Filter_Combinator__/graphics/icons/diode-combinator.png"

data:extend{combinator}
