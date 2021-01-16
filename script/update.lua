local function onTick(e)
	for _, entity in pairs(global.entities) do
        if entity.main_entity and entity.main_entity.valid == true then
            local control = entity.main_entity.get_control_behavior()
            local red = control.get_circuit_network(defines.wire_type.red, defines.circuit_connector_id.combinator_input)
            local green = control.get_circuit_network(defines.wire_type.green, defines.circuit_connector_id.combinator_input)

            local entity_output = entity.output_entity
            if entity_output and entity_output.valid == true then
                if green and green.signals and red and red.signals then
                    
                    local control_mode = control.parameters.second_constant or 0
                    
                    local parameters = {}
                    local index = 0
                    local signals = {}
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
                            if signal and signal.signal and signal.count and value then
                                index = index + 1
                                parameters[index] = { index = index, signal = signal.signal, count = value }
                            end
                        end
                    else -- blacklist
                        for signalId, signal in ipairs(input.signals) do
                            local control_value = control.get_signal({type = signal.signal.type, name = signal.signal.name})
                            if signal and signal.signal and signal.count and control_value == 0 then
                                index = index + 1
                                parameters[index] = { index = index, signal = signal.signal, count = signal.count }
                            end
                        end
                    end

                    entity_output.get_control_behavior().parameters = parameters
                else
                    entity_output.get_control_behavior().parameters = nil
                end
            end
        end
    end
end

script.on_event(defines.events.on_tick, onTick)