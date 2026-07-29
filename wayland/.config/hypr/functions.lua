---@param layout string
local function change_active_window_layout(layout)
    local workspace = hl.get_active_workspace()

    if hl.get_active_special_workspace() then
        workspace = hl.get_active_special_workspace()
    end

    if not workspace then
        return
    end

    if workspace.special then
        hl.workspace_rule({ workspace = tostring(workspace.name), layout = layout })
    else
        hl.workspace_rule({ workspace = tostring(workspace.id), layout = layout })
    end
end
