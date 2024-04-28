
local function configure_diode_combinator(entity)
    entity.operable = false

    local control_behavior = entity.get_or_create_control_behavior()
    control_behavior.parameters = {
        first_signal = {type = "virtual", name = "signal-each"},
        second_constant = 0,
        operation = "+",
        output_signal = {type = "virtual", name = "signal-each"}
    }
end

local function onBuiltEntity(e)
    if
    (e.created_entity and e.created_entity.name == "signal-diode-combinator") or
            (e.entity and e.entity.name == "signal-diode-combinator")
    then
        local main_entity = e.created_entity or e.entity

        configure_diode_combinator(main_entity)
    end
end

local filter = {{filter = "name", name = "signal-diode-combinator"}}

script.on_event(defines.events.on_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.on_robot_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_built, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_revive, onBuiltEntity, filter)

local function register_compakt_circuits()
    if remote.interfaces["compaktcircuit"] then

        local diode_combinator_description = {
            name = "signal-diode-combinator",
            packed_names = {
                "signal-diode-combinator-packed"
            },
            interface_name = "compakt-circuits-signal-diode-combinator"
        }

        remote.call("compaktcircuit", "add_combinator", diode_combinator_description)

        remote.add_interface("compakt-circuits-signal-diode-combinator", {
            get_info = function(entity)
                return {
                    position = entity.position,
                    direction = entity.direction
                }
            end,

            create_packed_entity = function(info, surface, position, force)
                local packed_entity = surface.create_entity {
                    name = "signal-diode-combinator-packed",
                    force = force,
                    position = position,
                    direction = info.direction }

                configure_diode_combinator(packed_entity)

                return packed_entity
            end,

            create_entity = function(info, surface, force)
                local entity = surface.create_entity {
                    name = "signal-diode-combinator",
                    force = force,
                    position = info.position,
                    direction = info.direction
                }

                configure_diode_combinator(entity)

                script.raise_script_built { entity = entity }

                return entity
            end
        })
    end
end

script.on_load(function()
    register_compakt_circuits()
end)

script.on_init(function()
    register_compakt_circuits()
end)
