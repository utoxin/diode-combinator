local max_output_signals

local function getOutputParameters(entity)
    
    local result = {
        isOverflow = false,
        parameters = nil
    }

    local control_behavior = entity.main_entity.get_control_behavior()
    local red = control_behavior.get_circuit_network(defines.wire_type.red, defines.circuit_connector_id.combinator_input)
    local green = control_behavior.get_circuit_network(defines.wire_type.green, defines.circuit_connector_id.combinator_input)

    if not (green and green.signals and red and red.signals) then
        return result
    end

    local control_mode = control_behavior.parameters.second_constant or 0
    
    local parameters = {}
    local index = 0
    local output_slots = max_output_signals
    local control
    local input

    if control_mode == 0 or control_mode == 2 then
        control = red
        input = green
    else -- control_mode == 1 or control_mode == 3
        control = green
        input = red
    end
    
    if control_mode == 0 or control_mode == 1 then -- whitelist
        for signalId, signal in ipairs(control.signals) do
            local value = input.get_signal({type = signal.signal.type, name = signal.signal.name})
            if signal and signal.signal and signal.count and value ~= 0 then
                index = index + 1
                if index > output_slots then
                    result.isOverflow = true
                    break
                end
                parameters[index] = { index = index, signal = signal.signal, count = value }
            end
        end
    else -- blacklist
        for signalId, signal in ipairs(input.signals) do
            local control_value = control.get_signal({type = signal.signal.type, name = signal.signal.name})
            if signal and signal.signal and signal.count and control_value == 0 then
                index = index + 1
                if index > output_slots then
                    result.isOverflow = true
                    break
                end
                parameters[index] = { index = index, signal = signal.signal, count = signal.count }
            end
        end
    end

    if not result.isOverflow then
        result.parameters = parameters
    end

    return result
end

local function sendAlert(entity)
    for _, player in pairs(game.players) do
        player.add_custom_alert(
            entity.main_entity,
            { type = "item", name = "signal-filter-combinator-alert" },
            {"gui-alert-tooltip.filter-combinator-overflow", max_output_signals},
            true
        )
    end
end

local function handleSignalOverflow(entity)
    
    local entity_output = entity.output_entity
    entity_output.get_control_behavior().parameters = nil

    entity.main_entity.active = false

    if not global.deactivated_entities then
        global.deactivated_entities = global.deactivated_entities or {}
    end

    global.deactivated_entities[entity.main_entity.unit_number] = entity
    global.entities[entity.main_entity.unit_number] = nil

    sendAlert(entity)
end

local function onTick(e)
    if not max_output_signals then
        setMaxOutputSignals()
    end

	for _, entity in pairs(global.entities) do
        if 
            entity.main_entity
            and entity.main_entity.valid
            and entity.main_entity.active
            and entity.output_entity
            and entity.output_entity.valid
        then
            if 
                entity.main_entity.status == defines.entity_status.no_power
                or entity.main_entity.status == defines.entity_status.low_power
            then
                entity.output_entity.get_control_behavior().parameters = nil
            else
                local outputParameters = getOutputParameters(entity)

                if not outputParameters.isOverflow then
                    entity.output_entity.get_control_behavior().parameters = outputParameters.parameters
                else
                    handleSignalOverflow(entity)
                end
            end
        end
    end
end

local function reactivateAll()
    if not global.deactivated_entities then
        global.deactivated_entities = global.deactivated_entities or {}
    end

    for _, entity in pairs(global.deactivated_entities) do
        if not getOutputParameters(entity).isOverflow then
            entity.main_entity.active = true
            global.entities[entity.main_entity.unit_number] = entity
            global.deactivated_entities[entity.main_entity.unit_number] = nil
        else
            sendAlert(entity)
        end
    end
end

local function setMaxOutputSignals()
    max_output_signals = settings.startup["filter-combinator-output-slots"].value
end

script.on_load(setMaxOutputSignals)

script.on_event(defines.events.on_tick, onTick)
script.on_nth_tick(60*settings.startup["filter-combinator-reactivate-seconds"].value, reactivateAll)