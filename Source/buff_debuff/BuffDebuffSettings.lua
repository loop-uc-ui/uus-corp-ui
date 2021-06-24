BuffDebuffSettings = {}

function BuffDebuffSettings.windowDirection(direction)
    if direction == nil then
        return UserInterfaceVariables.LoadNumber("AdvancedBuffGoodDirection", direction)
    else
        UserInterfaceVariables.SaveNumber("AdvancedBuffGoodDirection", direction)
        return direction
    end
end