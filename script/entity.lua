function getEntity(unit_number)
    return global.entities[unit_number] or global.deactivated_entities[unit_number]
end

local function getOutputPosition(main_entity)
    local position = main_entity.position

    if main_entity.direction == defines.direction.north then
        position.y = position.y - 1
    end
    if main_entity.direction == defines.direction.west then
        position.x = position.x - 1
    end

    return position
end

local function setupGlobals()
    global.opened_entity = global.opened_entity or {}
    global.entities = global.entities or {}
    global.deactivated_entities = global.deactivated_entities or {}
end

local function onRotated(e)
    if e.entity and e.entity.name == "signal-filter-combinator" then
        local output_entity = getEntity(e.entity.unit_number).output_entity
        output_entity.teleport(getOutputPosition(e.entity))
        output_entity.direction = e.entity.direction
    end
end

local function onBuiltEntity(e)
    if 
        (e.created_entity and e.created_entity.name == "signal-filter-combinator") or
        (e.entity and e.entity.name == "signal-filter-combinator")
    then
        local main_entity = e.created_entity or e.entity

        local output_entity = main_entity.surface.create_entity{
            name = "signal-filter-combinator-output",
            position = getOutputPosition(main_entity),
            direction = main_entity.direction,
            force = main_entity.force,
            fast_replace = false,
            raise_built = false,
            create_built_effect_smoke = false
        }
        
        output_entity.destructible = false
        output_entity.operable = false
        output_entity.rotatable = false
        output_entity.minable = false
        
        global.entities[main_entity.unit_number] = {}
        global.entities[main_entity.unit_number].main_entity = main_entity
        global.entities[main_entity.unit_number].output_entity = output_entity

        main_entity.connect_neighbour({
            wire = defines.wire_type.red, 
            target_entity = output_entity, 
            source_circuit_id = defines.circuit_connector_id.combinator_output,
            target_circuit_id = defines.circuit_connector_id.constant_combinator
        })
        main_entity.connect_neighbour({
            wire = defines.wire_type.green,
            target_entity = output_entity,
            source_circuit_id = defines.circuit_connector_id.combinator_output,
            target_circuit_id = defines.circuit_connector_id.constant_combinator
        })
    end
end

local function onMinedEntity(e)
    if not (e.entity and e.entity.name == "signal-filter-combinator") then return end

    getEntity(e.entity.unit_number).output_entity.destroy({raise_destroy = false})

    if global.entities[e.entity.unit_number] then
        table.remove(global.entities, e.entity.unit_number)
    end
    if global.deactivated_entities[e.entity.unit_number] then
        table.remove(global.deactivated_entities, e.entity.unit_number)
    end
end

script.on_init(setupGlobals)
script.on_configuration_changed(setupGlobals)

local filter = {{filter = "name", name = "signal-filter-combinator"}}

script.on_event(defines.events.on_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.on_robot_built_entity, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_built, onBuiltEntity, filter)
script.on_event(defines.events.script_raised_revive, onBuiltEntity, filter)
script.on_event(defines.events.on_player_mined_entity, onMinedEntity, filter)
script.on_event(defines.events.on_robot_mined_entity, onMinedEntity, filter)
script.on_event(defines.events.script_raised_destroy, onMinedEntity, filter)
script.on_event(defines.events.on_entity_died, onMinedEntity, filter)

script.on_event(defines.events.on_player_rotated_entity, onRotated)