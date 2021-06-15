Cursor = {}

function Cursor.exists()
    return WindowData.Cursor ~= nil
end

function Cursor.target()
    return WindowData.Cursor.target
end