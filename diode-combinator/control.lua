local function onBuiltEntity(e)
    if
    (e.created_entity and e.created_entity.name == "signal-diode-combinator") or
            (e.entity and e.entity.name == "signal-diode-combinator")
    then
        local main_entity = e.created_entity or e.entity
        main_entity.operable = false

        local control_behavior = main_entity.get_or_create_control_behavior()
        control_behavior.parameters = {
            first_signal = {type = "virtual", name = "signal-each"},
            second_constant = 0,
            operation = "+",
            output_signal = {type = "virtual", name = "signal-each"}
        }
    end
end

local filter = {{filter = "name", name = "signal-diode-combinator"}}

script.on_event(defines.events.on_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.on_robot_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_built, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_revive, onBuiltEntity, filter)
