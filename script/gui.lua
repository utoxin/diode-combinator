local function get_switch_position(switch, control_mode)
    if switch == "control-wire-switch" then
        if control_mode == 0 or control_mode == 2 then
            return "left"
        else
            return "right"
        end
    elseif switch == "filter-mode-switch" then
        if control_mode == 0 or control_mode == 1 then
            return "left"
        else
            return "right"
        end
    end
end

local function on_gui_opened(e)
	if not (e.entity and e.entity.name == 'signal-filter-combinator') then return end
	
    local player = game.players[e.player_index]
    global.opened_entity[e.player_index] = e.entity.unit_number

	if not getEntity(e.entity.unit_number) then return end
    
    local gui_elements = {}
    local caption
    local control_mode = e.entity.get_control_behavior().parameters.second_constant

    caption = {"gui.title"}
    gui_elements.waypoint = "default"

    local frame = player.gui.screen.add{type="frame", caption=caption, direction="vertical"}
    frame.force_auto_center()
    gui_elements.frame = frame

    local vertical_flow_1 = frame.add{type="frame", style="item_and_count_select_background", direction="horizontal"}
    vertical_flow_1.add{type="label", style="heading_2_label", caption={"gui.control-wire"}, tooltip={"gui.control-wire-tooltip"}}
    gui_elements.switch = vertical_flow_1.add{
        type="switch",
        name="control-wire-switch",
        horizontal_align="right",
        left_label_caption={"gui.red-wire"},
        right_label_caption={"gui.green-wire"},
        allow_none_state = false,
        switch_state = get_switch_position("control-wire-switch", control_mode),
        tooltip={"gui.control-wire-tooltip"}
    }

    local vertical_flow_2 = frame.add{type="frame", style="item_and_count_select_background", direction="horizontal"}
    vertical_flow_2.add{type="label", style="heading_2_label", caption={"gui.filter-mode"}, tooltip={"gui.filter-mode-tooltip"}}
    gui_elements.switch = vertical_flow_2.add{
        type="switch",
        name="filter-mode-switch",
        horizontal_align="right",
        left_label_caption={"gui.whitelist"},
        right_label_caption={"gui.blacklist"},
        allow_none_state = false,
        switch_state = get_switch_position("filter-mode-switch", control_mode),
        tooltip={"gui.filter-mode-tooltip"}
    }

    player.opened = frame
end

local function on_gui_closed(e)
    if not (e.element and global.opened_entity) then return end

    local unit_number = global.opened_entity[e.player_index]

    -- Check if the entity is owned by this mod
    if not getEntity(unit_number) then
        return
    end

    e.element.destroy()
    e.element = nil
    game.players[e.player_index].opened = nil
    global.opened_entity[e.player_index] = nil
end

local function on_gui_switch_state_changed(e)
    if not (e.element and global.opened_entity) then return end

    local unit_number = global.opened_entity[e.player_index]
    if not (unit_number and getEntity(unit_number)) then return end

    local entity = getEntity(unit_number).main_entity
    local control_mode = entity.get_control_behavior().parameters.second_constant

    if not (entity and control_mode) then return end

    if e.element.name == "control-wire-switch" then
        if e.element.switch_state == "left" then
            control_mode = control_mode - 1
        else
            control_mode = control_mode + 1
        end
    elseif e.element.name == "filter-mode-switch" then
        if e.element.switch_state == "left" then
            control_mode = control_mode - 2
        else
            control_mode = control_mode + 2
        end
    end

    entity.get_control_behavior().parameters = {second_constant = control_mode}
end

script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_switch_state_changed, on_gui_switch_state_changed)