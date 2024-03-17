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

script.on_init(setupGlobals)
script.on_configuration_changed(setupGlobals)

local filter = {{filter = "name", name = "signal-diode-combinator"}}

script.on_event(defines.events.on_player_rotated_entity, onRotated)