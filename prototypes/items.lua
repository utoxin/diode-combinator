local combinator = table.deepcopy(data.raw["item"]["arithmetic-combinator"])

combinator.name = "signal-filter-combinator"
combinator.place_result="signal-filter-combinator"
combinator.order = "b[combinators]-d[signal-filter-combinator]"
combinator.icon = "__Filter_Combinator__/graphics/icons/filter-combinator.png"

local alert = table.deepcopy(combinator)
alert.name = "signal-filter-combinator-alert"
alert.icon = "__Filter_Combinator__/graphics/icons/overflow.png"
alert.icon_size = 64

data:extend{combinator}
data:extend{alert}