UserInterfaceVariables = {}

-------------------------------------------------------------------------------
-- Interface.SaveBoolean
-- Description:
--     Saves a boolean value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function UserInterfaceVariables.SaveBoolean( settingName, settingValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        return false
    end

    if type( settingValue ) ~= type( true ) then
        return false
    end

    local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames

    if nBools <= 0 then
        table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
        table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
    else
        local found = false
        for i = 1, nBools do
            if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
                SystemData.Settings.Interface.UIVariables.BoolValues[i] = settingValue
                found = true
                break
            end
        end
        if not found then
            table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
            table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
        end
    end
    Broadcast.Event(SystemData.Events.USER_SETTINGS_UPDATED)
end


-------------------------------------------------------------------------------
-- Interface.LoadBoolean
-- Description:
--     Gets the boolean value of a setting
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function UserInterfaceVariables.LoadBoolean( settingName, defaultValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        return defaultValue
    end

    if not SystemData.Settings.Interface.UIVariables.BoolNames then
        return defaultValue
    end

    local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
    for i = 1, nBools do

        if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
            return SystemData.Settings.Interface.UIVariables.BoolValues[i]
        end
    end
    return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.SaveColor
-- Description:
--     Saves a color value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
--                    (table {r=(0-255),g=(0-255),b=(0-255)[,a=(0-255)]})
-------------------------------------------------------------------------------
function UserInterfaceVariables.SaveColor( settingName, settingValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        Debug.Print( "Interface.SaveColor: settingName must be a string" )
        return false
    end
    --Debug.Print("Checking Color: " .. settingName)
    if not Interface.CheckColor( settingValue, "Interface.SaveColor" ) then
        -- Debug printing in CheckColor function
        return false
    end
    --Debug.Print("Saving Color: " .. settingName)

    local r = settingValue.r
    local g = settingValue.g
    local b = settingValue.b
    local a = settingValue.a

    local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
    if nColors <= 0 then
        table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
        table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
        table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
        table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
        table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
    else
        local found = false
        for i = 1, nColors do
            if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
                SystemData.Settings.Interface.UIVariables.ColorRedValues[i] = r
                SystemData.Settings.Interface.UIVariables.ColorGreenValues[i] = g
                SystemData.Settings.Interface.UIVariables.ColorBlueValues[i] = b
                SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i] = a
                found = true
                break
            end
        end
        if not found then
            table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
            table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
            table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
            table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
            table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
        end
    end
end

-------------------------------------------------------------------------------
-- Interface.LoadColor
-- Description:
--     Gets the color value of a setting
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function UserInterfaceVariables.LoadColor( settingName, defaultValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        Debug.Print( "Interface.LoadColor: settingName must be a string" )
        return false
    end

    if not SystemData.Settings.Interface.UIVariables.ColorNames then
        return defaultValue
    end

    local nStrings = #SystemData.Settings.Interface.UIVariables.ColorNames
    for i = 1, nStrings do
        if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
            local color = {
                r = SystemData.Settings.Interface.UIVariables.ColorRedValues[i],
                g = SystemData.Settings.Interface.UIVariables.ColorGreenValues[i],
                b = SystemData.Settings.Interface.UIVariables.ColorBlueValues[i],
                a = SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i]
            }
            return color
        end
    end
    return defaultValue
end


-------------------------------------------------------------------------------
-- Interface.SaveNumber
-- Description:
--     Saves a numeric value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function UserInterfaceVariables.SaveNumber( settingName, settingValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        Debug.Print( "Interface.SaveNumber: settingName must be a string" )
        return false
    end
    if type( settingValue ) ~= type( 0 ) then
        Debug.Print( "Interface.SaveNumber: \"" .. settingName .. "\" settingValue must be a number" )
        return false
    end

    local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
    if nNumbers <= 0 then
        table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
        table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
    else
        local found = false
        for i = 1, nNumbers do
            if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
                SystemData.Settings.Interface.UIVariables.NumberValues[i] = settingValue
                found = true
                break
            end
        end
        if not found then
            table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
            table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
        end
    end

end

-------------------------------------------------------------------------------
-- Interface.LoadNumber
-- Description:
--     Gets the numeric value of a setting
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function UserInterfaceVariables.LoadNumber( settingName, defaultValue )
    -- Check the types of the arguments
    if type( settingName ) ~= type( "" ) then
        Debug.Print( "Interface.LoadNumber: settingName must be a string" )
        return defaultValue
    end

    if not SystemData.Settings.Interface.UIVariables.NumberNames then
        return defaultValue
    end

    local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
    for i = 1, nNumbers do
        if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
            return SystemData.Settings.Interface.UIVariables.NumberValues[i]
        end
    end
    return defaultValue
end