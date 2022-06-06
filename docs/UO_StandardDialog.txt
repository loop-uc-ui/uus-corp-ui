----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_StandardDialog = {}

UO_StandardDialog.DialogData = {}

UO_StandardDialog.DIALOG_EDGE_PADDING = 20
UO_StandardDialog.Y_PADDING = 85
UO_StandardDialog.MIN_HEIGHT = 160

UO_StandardDialog.TID_OKAY   = 1011036  -- OKAY
UO_StandardDialog.TID_CANCEL = 1011012  -- CANCEL

UO_StandardDialog.DefaultButtons = { { textTid=UO_StandardDialog.TID_OKAY } }

-- dialogData 
--     windowName   = (string) name of window opening dialog (not optional)
--     title        = (wstring) title in titlebar (default L"")
--     titleTid     = (tid) title in titlebar (overrides title)
--     body         = (wstring) body text (default L"")
--     bodyTid      = (tid) body text (overrides body)
--     buttons      = (table) list of buttons to display (default okay,no callback)
--     hasScrollbar = (boolean) has a scrollbar (default false)
--     focusOnClose = (string) window to set focus to when the dialog closes (default nil)
--
-- buttons[i]
--     text       = (wstring) button text (default L"")
--     textTid    = (tid) button text (overrides text)
--     callback   = (function) function to call on return (default nil)
--     param      = (any type) optional parameter to send to callback (default nil)
--
-- Example:
--     local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=MyWindow.OnDialogOptionSelected, param=1 }
--     local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=MyWindow.OnDialogOptionSelected, param=2 }
--     local dialogData =
--     {
--         windowName = "MyWindow",
--         titleTid = 555555,
--         bodyTid = 123456,
--         buttons = { okayButton, cancelButton },
--         hasScrollbar = false,
--     }
--     UO_StandardDialog.CreateDialog(dialogData)
--
--
function UO_StandardDialog.CreateDialog(dialogData)

    if( dialogData.windowName == nil ) then
        Debug.Print("Window name not specified! Failing to create dialog")
        return false
    end

    local dialogWindowName = dialogData.windowName.."Dialog"
    
    if( UO_StandardDialog.DialogData[dialogWindowName] ~= nil ) then
        Debug.Print("Window already has a dialog open! Failing to create dialog")
        return false
    end
    
    UO_StandardDialog.DialogData[dialogWindowName] = dialogData
    
    CreateWindowFromTemplate(dialogWindowName,"UO_StandardDialog","Root")
    
    return dialogWindowName
end

function UO_StandardDialog.Initialize()
    local dialogWindowName = SystemData.ActiveWindow.name
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]
    
    Interface.DestroyWindowOnClose[dialogWindowName] = true
    
    local dialogWidth, dialogHeight = WindowGetDimensions(dialogWindowName)
    local newHeight = UO_StandardDialog.Y_PADDING
    
    local title = L""
    if( dialogData.titleTid ~= nil ) then
        title = GetStringFromTid(dialogData.titleTid)
    else
        title = dialogData.title
    end
    WindowUtils.SetWindowTitle(dialogWindowName,title)
    
    local body = L""
    if( dialogData.bodyTid ~= nil ) then
        body = GetStringFromTid(dialogData.bodyTid)
    else
        body = dialogData.body
    end
    
    if( dialogData.hasScrollbar == true ) then
        WindowSetShowing(dialogWindowName.."NormalText", false)
        LabelSetText(dialogWindowName.."ScrolledChildText",body)
        ScrollWindowUpdateScrollRect(dialogWindowName.."Scrolled")
    else
        WindowSetShowing(dialogWindowName.."Scrolled", false)
        LabelSetText(dialogWindowName.."NormalText",body)
        local textWidth, textHeight = LabelGetTextDimensions(dialogWindowName.."NormalText")
        newHeight = newHeight + textHeight
    end
    
    if( dialogData.buttons == nil ) then
        dialogData.buttons = UO_StandardDialog.DefaultButtons
    end
    
    local numButtons = table.getn(dialogData.buttons)
    
    local spacing = 0
    for index, button in pairs(dialogData.buttons) do
        local buttonName = dialogWindowName.."Button"..index
        CreateWindowFromTemplate(buttonName,"DialogButtonTemplate",dialogWindowName)
        WindowSetId(buttonName,index)
        
        local text = L""
        if( button.textTid ~= nil ) then
            text = GetStringFromTid(button.textTid)
        else
            text = button.text
        end
        ButtonSetText(buttonName,text)
        
        if( index == 1 ) then
            local buttonWidth, buttonHeight = WindowGetDimensions(buttonName)
            local xOffset = 0
            
            newHeight = newHeight + buttonHeight
            
            spacing = (dialogWidth - (buttonWidth*numButtons)) / (numButtons+1)
            
            WindowAddAnchor(buttonName,"bottomleft",dialogWindowName,"bottomleft",spacing,-UO_StandardDialog.DIALOG_EDGE_PADDING)
        else
            WindowAddAnchor(buttonName,"topright",dialogWindowName.."Button"..(index-1),"topleft",spacing,0)
        end
    end
    
    if( newHeight < UO_StandardDialog.MIN_HEIGHT ) then
        newHeight = UO_StandardDialog.MIN_HEIGHT
    end

    WindowSetDimensions(dialogWindowName,dialogWidth,newHeight)
    WindowSetShowing(dialogWindowName,true)    
end

function UO_StandardDialog.Shutdown()
    local windowName = SystemData.ActiveWindow.name
    UO_StandardDialog.DialogData[windowName] = nil
end

function UO_StandardDialog.OnLButtonUp()
    local dialogWindowName = WindowUtils.GetActiveDialog()
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]
    local index = WindowGetId(SystemData.ActiveWindow.name)
    local button = dialogData.buttons[index]
    
    if( button ~= nil and button.callback ~= nil ) then
        button.callback(button.param)
    end
    
    DestroyWindow(dialogWindowName)
    
    if( dialogData.focusOnClose ~= nil ) then
        WindowAssignFocus (dialogData.focusOnClose, true)
    end
    
    UO_StandardDialog.DialogData[dialogWindowName] = nil
end