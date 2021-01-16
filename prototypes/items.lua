local combinator = table.deepcopy(data.raw["item"]["arithmetic-combinator"])

combinator.name = "signal-filter-combinator"
combinator.place_result="signal-filter-combinator"
combinator.order = "b[combinators]-d[signal-filter-combinator]"
combinator.icon = "__Filter_Combinator__/graphics/icons/filter-combinator.png"

data:extend{combinator}