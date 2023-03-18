Cursor = {}

function Cursor.cursor()
    return WindowData.Cursor
end

function Cursor.hasTarget()
    return Cursor.cursor() ~= nil and Cursor.cursor().target == true
end