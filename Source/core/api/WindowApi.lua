WindowApi = {}

function WindowApi.destroyWindow(id)
    DestroyWindow(id)
end

function WindowApi.setShowing(id, show)
    WindowSetShowing(id, show)
end

function WindowApi.isShowing(id)
    return WindowGetShowing(id)
end

---Clears all of the anchors from the window.
---When all the anchors are removed from a window, it will
---reposition itself to it’s parent position.
---@param id - (string) The name of the window.
function WindowApi.clearAnchors(id)
    WindowClearAnchors(id)
end

---Adds a new anchor to the window.
---@param id - (string) The name of the window.
---@param anchorPoint - (string) The name point on the at which to anchor the window.
---@param relativeTo - (string) The name of another window to which you want to anchor this one.
---@param relativePoint - (string) The point on this that you wish to attach to the anchor window.
---@param pointX - (number) The x pixel offset from this anchor location.
---@param pointY - (number) The y pixel offset from this anchor location.
function WindowApi.addAnchor(
        id,
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowAddAnchor(id, anchorPoint, relativeTo, relativePoint, pointX, pointY)
end

---Returns anchor information
---@param id - (string) The name of the window.
---@param anchorId - (number) Desired anchor’s id.  Ranges from 1 to WindowGetAnchorCount for this window.
---@return @local point (string), relativePoint (string), relativeTo (string), xOffs (number), yOffs (number)
function WindowApi.getAnchor(id, anchorId)
    return WindowGetAnchor(id, anchorId)
end

---Returns how many anchors this window has.
---@param id - (string) The name of the window.
---@return @number of anchors this window has.
function WindowApi.getAnchorCount(id)
    return WindowGetAnchorCount(id)
end

---Forces the window anchors to be processed.
---This is helpful to “fix” you window positions if you have done some odd combination of
---sizing/anchoring that is incorrect.
---@param id - (string) The name of the window.
function WindowApi.forceProcessAnchors(id)
    WindowForceProcessAnchors(id)
end

---Assigns or clears the direct focus to this window element.
---As a result, all parent window element will also come into focus.
---Certain window elements, such as the EditBox can hold focus when they are not visible.
---Be careful when showing/hiding elements that you have explicitly given focus.
---@param id - (string) The name of the window.
---@param doFocus - (string) True = Set Focus, False = Clear Focus
function WindowApi.assignFocus(id, doFocus)
    return WindowAssignFocus(id, doFocus)
end

---Returns whether or not the window has focus.
---@param id - (string) The name of the window.
---@return @boolean True = Has Focus, False = No Focus
function WindowApi.hasFocus(id)
    return WindowHasFocus(id)
end

---Sets the window to be continuously resized while the mouse is dragging.
---Resizing can potentially very slow for complex windows.  Rather than resizing a window directly,
---use the <WindowUtils> <WindowUtils.BeginResize> and <WindowUtils.EndResize> functions that create a gray
---resizing box around the window during the resize, so the actually window dimensions are only updated once.
---@param id - (string) The name of the window.
---@param isResizing - (string) True = Resizing is on, False = Resizing is off.
function WindowApi.setResizing(id, isResizing)
    WindowSetResizing(id, isResizing)
end

---Returns if a window is currently being resized
---@param id - (string) The name of the window.
---@return @isResizing (string) True = Resizing is on, False = Resizing is off.
function WindowApi.isResizing(id)
    return WindowGetResizing(id)
end

---Starts an automated alpha-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The actual alpha value on the window is multiplied into the alpha fade.
---If you set the window alpha in the middle of the animation, the value you set will not necessarily be
---the value you see on screen until the animation stop.
---@param id - (string) The name of the window.
---@param animType - (number) The animation type, see Animation Types for valid values.
---@param startAlpha - (number) The starting alpha value for the animation.
---@param endAlpha - (number) The ending alpha value for the animation.
---@param duration - (number) The duration (in seconds) to fade between the min alpha and max alpha.
---@param setStartBeforeDelay - (boolean) Should the window be set to the start animation value prior to the delay?
---@param delay - (number) The delay between this function call and when the animation should start.
---@param numLoop - (number) The number of times to loop the animation.  When 0, loops indefinably.
function WindowApi.startAlphaAnimation(
        id,
        animType,
        startAlpha,
        endAlpha,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartAlphaAnimation(id, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current alpha animation and resets the window to its true alpha value.
---@param id - (string) The name of the window.
function WindowApi.stopAlphaAnimation(id)
    WindowStopAlphaAnimation(id)
end

---Starts an automated scale-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The animation will override the actual scale value on the window
---for the duration of the animation.
---@param id - (string) The name of the window.
---@param animType - (number) The animation type, see Animation Types for valid values.
---@param startScale - (number) The starting scale value for the animation.
---@param endScale - (number) The ending scale value for the animation.
---@param duration - (number) The duration (in seconds) to fade between the min scale and max scale.
---@param setStartBeforeDelay - (boolean) Should the window be set to the start animation value prior to the delay?
---@param delay - (number) The delay between this function call and when the animation should start.
---@param numLoop - (number) The number of times to loop the animation.  When 0, loops indefinably.
function WindowApi.startScaleAnimation(
        id,
        animType,
        startScale,
        endScale,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartScaleAnimation(id, animType, startScale, endScale, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current scale animation and resets the window to its true scale.
---@param id - (string) The name of the window.
function WindowApi.stopScaleAnimation(id)
    WindowStopScaleAnimation(id)
end

---Starts an automated position-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The animation will override the window’s anchors for the
---duration of the animation.
---@param id - (string) The name of the window.
---@param animType - (number) The animation type, see Animation Types for valid values.
---@param startX - (number) The starting x offset from parent for the animation (start and end for POP type anims)
---@param startY - (number) The starting y offset from parent for the animation (start and end for POP type anims)
---@param endX - (number) The ending x offset from parent for the animation (mid-point for POP type anims)
---@param endY - (number) The ending y offset from parent for the animation (mid-point for POP type anims)
---@param duration - (number) The duration (in seconds) to fade between the min alpha and max alpha.
---@param setStartBeforeDelay - (boolean) Should the window be set to the start animation value prior to the delay?
---@param delay - (number) The delay between this function call and when the animation should start.
---@param numLoop - (number) The number of times to loop the animation.  When 0, loops indefinably.
function WindowApi.startScaleAnimation(
        id,
        animType,
        startX,
        startY,
        endX,
        endY,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartScaleAnimation(id, animType, startX, startY, endX, endY, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current position animation and resets the window to its true scale.
---@param id - (string) The name of the window.
function WindowApi.stopScaleAnimation(id)
    WindowStopPositionAnimation(id)
end

function WindowApi.setAlpha(id, alpha)
    WindowSetAlpha(id, alpha)
end

function WindowApi.setColor(id, color)
    WindowSetTintColor(id, color.r, color.g, color.b)
end

---Determines the existence of the specified window.
---@param id - (string) The name of the window.
---@return @true if the window named by windowName exists, false otherwise.
function WindowApi.doesExist(id)
    return DoesWindowNameExist(id)
end

function WindowApi.createFromTemplate(id, template, parent)
    CreateWindowFromTemplate(id, template, parent)
end

function WindowApi.setId(id, newId)
    WindowSetId(id, newId)
end

---Sets if the window is currently attached to the cursor.
---@param id - (string) The name of the window.
---@param isMoving - (boolean) Should the window be moving?
function WindowApi.setMoving(id, isMoving)
    WindowSetMoving(id, isMoving)
end

---Returns if the window is currently being moved.
---@param id - (string) The name of the window.
---@return @true or false Is the window be moving?
function WindowApi.isMoving(id)
    return WindowGetMoving(id)
end

function WindowApi.registerEventHandler(id, event, callback)
    WindowRegisterEventHandler(id, event, callback)
end

function WindowApi.unregisterEventHandler(id, event)
    WindowUnregisterEventHandler(id, event)
end

---This will remove the window from it’s current parent, and adds it as a child of the specified window.
---@param id - (string) The name of the window.
---@param parentId - (string) The name of the new parent window.
function WindowApi.setParent(id, parentId)
    WindowSetParent(id, parentId)
end

---Returns the parent for the specified window.
---This function is very useful for nested window elements, where you want to use a parent window’s id
---number but still allow a child windows to process input and handle click events.
---@param id - (string) The name of the window.
---@return @parentWindowName (string) The name of the new parent window.
function WindowApi.getParent(id)
    return WindowGetParent(id)
end

---Sets the current scale value on the window. A window’s visual size on the screen are determined
---by multiplying it’s scale value and dimensions.
---@param id - (string) The name of the window.
---@param scale - (number) Value between 0.0 and 1.0.
function WindowApi.setScale(id, scale)
    WindowSetScale(id, scale)
end

---Returns the current scale value on the window. A window’s visual size on the screen are determined by
---multiplying it’s scale value and dimensions.
---@param id - (string) The name of the window.
---@return @scale (number) Value between 0.0 and 1.0.
function WindowApi.getScale(id)
    return WindowGetScale(id)
end

---Scales the window relative to it’s current scale.  For example, a relative scale
---of 0.5 will scale a window to half it’s current size.
---@param id - id - (string) The name of the window.
---@return @scale (number) Value between 0.0 and 1.0.
function WindowApi.setRelativeScale(id, scale)
    WindowSetRelativeScale(id, scale)
end

---Resizes a parent window based upon the max sizes of its children
---@param id - (string) Name of the parent window to resize.
---@param isRecursive - (boolean) Whether or not to recurse through the children of your children.
---@param borderSpacing - (number) Amount of padding to add to the bottom and right.
function WindowApi.resizeOnChildren(id, isRecursive, borderSpacing)
    WindowResizeOnChildren(id, isRecursive, borderSpacing)
end

---Associates a a key-bindable action to clicking on this window.
---@param id - (string) Name of the window
---@param action - (number) The keybinding action id to trigger when the window is clicked.
function WindowApi.setGameActionTrigger(id, action)
    WindowSetGameActionTrigger(id, action)
end

---Associates a game action (a key-bindable action) to clicking on this window.
---@param id - (string) Name of the window
---@param actionType - (number) The Type of the action.
---@param actionId - (number) The id number of the action.
---@param actionText - (number) The text associated with the action.
function WindowApi.setGameActionData(id, actionType, actionId, actionText)
    WindowSetGameActionData(id, actionType, actionId, actionText)
end

---Sets the GameActionButton to use to trigger the Game Action associated with this window.
---@param id - (string) The name of the window.
---@param button - (number) The GameActionButton to use for this window see Game Action Buttons for values
function WindowApi.setGameActionButton(id, button)
    WindowSetGameActionButton(id, button)
end