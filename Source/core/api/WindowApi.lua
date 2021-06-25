WindowApi = {}

function WindowApi.destroyWindow(windowName)
    DestroyWindow(windowName)
end

---Sets if a window should be shown (and drawn) on the screen.  When a window is not showing,
---it will not receive updates or mouse events.  Generic event handlers will still be processed.
---If a window is popable, it will be popped to the top of it’s layer when shown.
---If a window’s children have a specified tab order, the first item will have focus when shown.
---@param windowName - (string) The name of the window.
---@param show - (boolean) Should the window be drawn?
function WindowApi.setShowing(windowName, show)
    WindowSetShowing(windowName, show)
end

---Returns if the window is currently shown (and being drawn) on the screen.
---@param windowName - (string) The name of the window.
---@return @(boolean) Is the window currently being drawn?
function WindowApi.isShowing(windowName)
    return WindowGetShowing(windowName)
end

---Sets the layer that the window should be drawn on.
---@param windowName - (string) The name of the window.
---@param layer - (number) The layer the window is drawn on.  See Window Layers for values.
function WindowApi.setLayer(windowName, layer)
    WindowSetLayer(windowName, layer)
end

---Returns if the layer the window is currently drawn on.
---@param windowName - (string) The name of the window.
---@return @(number) The layer the window is drawn on.  See Window Layers for values.
function WindowApi.getLayer(windowName)
    return WindowGetLayer(windowName)
end

---Sets if the window should handle mouse input.
---@param windowName - (string) The name of the window.
---@param handleInput - (number) Should the window handle mouse input?
function WindowApi.setHandleInput(windowName, handleInput)
    WindowHandleInput(windowName, handleInput)
end

---Returns if the the is window currently handling mouse input.
---@param windowName - (string) The name of the window.
---@return @(boolean) Is the window currently handling mouse input?
function WindowApi.getHandleInput(windowName)
    return WindowGetHandleInput(windowName)
end

---Returns if the window is currently set to popable.  When popable is true, the window will ‘pop’
---to the front of it’s layer when clicked.
---@param windowName - (string) The name of the window.
---@param popable - (number) Should the window be popable?
function WindowApi.setPopable(windowName, popable)
    WindowSetPopable(windowName, popable)
end

---Returns if the window is currently set to popable.
---@param windowName - (string) The name of the window.
---@return @(boolean) Is the window popable
function WindowApi.isPopable(windowName)
    return windowGetPopable(windowName)
end

---Sets if a window can be moved.  When true, the window can be clicked on and dragged around the screen.
---@param windowName - (string) The name of the window.
---@param movable - (boolean) Should the window be movable?
function WindowApi.setMovable(windowName, movable)
    WindowSetMovable(windowName, movable)
end

---Returns if the window can be moved with the mouse.
---@param windowName - (string) The name of the window.
---@return @(boolean) Is the window currently movable?
function WindowApi.isMovable(windowName)
    return WindowGetMovable(windowName)
end

function WindowApi.setOffsetFromParent(windowName, xOffset, yOffset)
    WindowSetOffsetFromParent(windowName, xOffset, yOffset)
end

function WindowApi.setDimensions(windowName, xOffset, yOffset)
    WindowSetDimensions(windowName, xOffset, yOffset)
end

function WindowApi.getDimensions(windowName)
    return WindowGetDimensions(windowName)
end

---Determines whether or not the window is sticky or unsticky.
---@param windowName - (string) The name of the window.
---@return @(boolean) Is the window sticky?  True, or false.
function WindowApi.isSticky(windowName)
    return WindowIsSticky(windowName)
end

---Clears all of the anchors from the window.
---When all the anchors are removed from a window, it will
---reposition itself to it’s parent position.
---@param windowName - (string) The name of the window.
function WindowApi.clearAnchors(windowName)
    WindowClearAnchors(windowName)
end

---Adds a new anchor to the window.
---@param windowName - (string) The name of the window.
---@param anchorPoint - (string) The name point on the at which to anchor the window.
---@param relativeTo - (string) The name of another window to which you want to anchor this one.
---@param relativePoint - (string) The point on this that you wish to attach to the anchor window.
---@param pointX - (number) The x pixel offset from this anchor location.
---@param pointY - (number) The y pixel offset from this anchor location.
function WindowApi.addAnchor(
        windowName,
        anchorPoint,
        relativeTo,
        relativePoint,
        pointX,
        pointY
)
    WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX, pointY)
end

---Returns anchor information
---@param windowName - (string) The name of the window.
---@param anchorId - (number) Desired anchor’s id.  Ranges from 1 to WindowGetAnchorCount for this window.
---@return @local point (string), relativePoint (string), relativeTo (string), xOffs (number), yOffs (number)
function WindowApi.getAnchor(windowName, anchorId)
    return WindowGetAnchor(windowName, anchorId)
end

---Returns how many anchors this window has.
---@param windowName - (string) The name of the window.
---@return @number of anchors this window has.
function WindowApi.getAnchorCount(windowName)
    return WindowGetAnchorCount(windowName)
end

---Forces the window anchors to be processed.
---This is helpful to “fix” you window positions if you have done some odd combination of
---sizing/anchoring that is incorrect.
---@param windowName - (string) The name of the window.
function WindowApi.forceProcessAnchors(windowName)
    WindowForceProcessAnchors(windowName)
end

---Assigns or clears the direct focus to this window element.
---As a result, all parent window element will also come into focus.
---Certain window elements, such as the EditBox can hold focus when they are not visible.
---Be careful when showing/hiding elements that you have explicitly given focus.
---@param windowName - (string) The name of the window.
---@param doFocus - (string) True = Set Focus, False = Clear Focus
function WindowApi.assignFocus(windowName, doFocus)
    return WindowAssignFocus(windowName, doFocus)
end

---Returns whether or not the window has focus.
---@param windowName - (string) The name of the window.
---@return @boolean True = Has Focus, False = No Focus
function WindowApi.hasFocus(windowName)
    return WindowHasFocus(windowName)
end

---Sets the window to be continuously resized while the mouse is dragging.
---Resizing can potentially very slow for complex windows.  Rather than resizing a window directly,
---use the <WindowUtils> <WindowUtils.BeginResize> and <WindowUtils.EndResize> functions that create a gray
---resizing box around the window during the resize, so the actually window dimensions are only updated once.
---@param windowName - (string) The name of the window.
---@param isResizing - (string) True = Resizing is on, False = Resizing is off.
function WindowApi.setResizing(windowName, isResizing)
    WindowSetResizing(windowName, isResizing)
end

---Returns if a window is currently being resized
---@param windowName - (string) The name of the window.
---@return @isResizing (string) True = Resizing is on, False = Resizing is off.
function WindowApi.isResizing(windowName)
    return WindowGetResizing(windowName)
end

---Starts an automated alpha-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The actual alpha value on the window is multiplied into the alpha fade.
---If you set the window alpha in the middle of the animation, the value you set will not necessarily be
---the value you see on screen until the animation stop.
---@param windowName - (string) The name of the window.
---@param animType - (number) The animation type, see Animation Types for valid values.
---@param startAlpha - (number) The starting alpha value for the animation.
---@param endAlpha - (number) The ending alpha value for the animation.
---@param duration - (number) The duration (in seconds) to fade between the min alpha and max alpha.
---@param setStartBeforeDelay - (boolean) Should the window be set to the start animation value prior to the delay?
---@param delay - (number) The delay between this function call and when the animation should start.
---@param numLoop - (number) The number of times to loop the animation.  When 0, loops indefinably.
function WindowApi.startAlphaAnimation(
        windowName,
        animType,
        startAlpha,
        endAlpha,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current alpha animation and resets the window to its true alpha value.
---@param windowName - (string) The name of the window.
function WindowApi.stopAlphaAnimation(windowName)
    WindowStopAlphaAnimation(windowName)
end

---Starts an automated scale-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The animation will override the actual scale value on the window
---for the duration of the animation.
---@param windowName - (string) The name of the window.
---@param animType - (number) The animation type, see Animation Types for valid values.
---@param startScale - (number) The starting scale value for the animation.
---@param endScale - (number) The ending scale value for the animation.
---@param duration - (number) The duration (in seconds) to fade between the min scale and max scale.
---@param setStartBeforeDelay - (boolean) Should the window be set to the start animation value prior to the delay?
---@param delay - (number) The delay between this function call and when the animation should start.
---@param numLoop - (number) The number of times to loop the animation.  When 0, loops indefinably.
function WindowApi.startScaleAnimation(
        windowName,
        animType,
        startScale,
        endScale,
        duration,
        setStartBeforeDelay,
        delay,
        numLoop
)
    WindowStartScaleAnimation(windowName, animType, startScale, endScale, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current scale animation and resets the window to its true scale.
---@param windowName - (string) The name of the window.
function WindowApi.stopScaleAnimation(windowName)
    WindowStopScaleAnimation(windowName)
end

---Starts an automated position-animation on the window derived from the function parameters.
---You must issue a <StopAlphaAnimation()> call to end the animation.  This currently necessary even
---for single-pass animations. The animation will override the window’s anchors for the
---duration of the animation.
---@param windowName - (string) The name of the window.
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
        windowName,
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
    WindowStartScaleAnimation(windowName, animType, startX, startY, endX, endY, duration, setStartBeforeDelay, delay, numLoop)
end

---Stops the current position animation and resets the window to its true scale.
---@param windowName - (string) The name of the window.
function WindowApi.stopPositionAnimation(windowName)
    WindowStopPositionAnimation(windowName)
end

---Sets the alpha value for the window’s texture elements.  This value is propagated to all
---child elements as the ‘parent alpha’ value.  A window’s alpha and parent alpha values are
---multiples to produce the combined alpha result seen on the screen. If you want to animate the alpha for a window
---element, it is better to use the animation functions rather than directly call WindowSetAlpha every frame
---@param windowName - (string) The name of the window.
---@param alpha - (number) The alpha value 0.0 to 1.0.
function WindowApi.setAlpha(windowName, alpha)
    WindowSetAlpha(windowName, alpha)
end

---Returns the current alpha value for the window. This alpha value is the value set for this particular window
---element.  The perceived alpha value may be less if one of the window’s parent elements has
---less an alpha value < 1.0.
---@param windowName - (string) The name of the window.
---@return @(number) The alpha value 0.0 to 1.0.
function WindowApi.getAlpha(windowName)
    return WindowGetAlpha(windowName)
end

---Sets the tint color window’s texture elements.
---@param windowName - (string) The name of the window.
---@param color - (table) { r (number), g (number), b (number) }
function WindowApi.setColor(windowName, color)
    WindowSetTintColor(windowName, color.r, color.g, color.b)
end

---Determines the existence of the specified window.
---@param windowName - (string) The name of the window.
---@return @true if the window named by windowName exists, false otherwise.
function WindowApi.doesExist(windowName)
    return DoesWindowNameExist(windowName)
end

function WindowApi.createFromTemplate(windowName, template, parent)
    CreateWindowFromTemplate(windowName, template, parent)
end

---Sets the id value for the window. The id number for a window needs not be unique.  The window’s name is
---its unique identifier, so the id value is entirely defined by its use in xml/lua.
---@param windowName - (string) The name of the window.
---@param newId - (number) The id number to assign to the window.  May be any integer value.
function WindowApi.setId(windowName, newId)
    WindowSetId(windowName, newId)
end

---Returns the id for the specified window.
---@param windowName - (string) The name of the window.
---@return @(number) The id number for the window.
function WindowApi.getId(windowName)
    return WindowGetId(windowName)
end

---Sets the tab order for the window
---@param windowName - (string) The name of the window.
---@param tabOrder - (number) The TabOrder number to assign to the window.  May be any integer value.
function WindowApi.setTabOrder(windowName, tabOrder)
    WindowSetTabOrder(windowName, tabOrder)
end

---Returns the TabOrder for the specified window.
---@param windowName - (string) The name of the window.
---@return @(number) The tab order number for the window.
function WindowApi.getTabOrder(windowName)
    return WindowGetTabOrder(windowName)
end

---Sets if the window is currently attached to the cursor.
---@param windowName - (string) The name of the window.
---@param isMoving - (boolean) Should the window be moving?
function WindowApi.setMoving(windowName, isMoving)
    WindowSetMoving(windowName, isMoving)
end

---Returns if the window is currently being moved.
---@param windowName - (string) The name of the window.
---@return @true or false Is the window be moving?
function WindowApi.isMoving(windowName)
    return WindowGetMoving(windowName)
end

function WindowApi.registerEventHandler(windowName, event, callback)
    WindowRegisterEventHandler(windowName, event, callback)
end

function WindowApi.unregisterEventHandler(windowName, event)
    WindowUnregisterEventHandler(windowName, event)
end

---This will remove the window from it’s current parent, and adds it as a child of the specified window.
---@param windowName - (string) The name of the window.
---@param parentId - (string) The name of the new parent window.
function WindowApi.setParent(windowName, parentId)
    WindowSetParent(windowName, parentId)
end

---Returns the parent for the specified window.
---This function is very useful for nested window elements, where you want to use a parent window’s id
---number but still allow a child windows to process input and handle click events.
---@param windowName - (string) The name of the window.
---@return @parentWindowName (string) The name of the new parent window.
function WindowApi.getParent(windowName)
    return WindowGetParent(windowName)
end

---Sets the current scale value on the window. A window’s visual size on the screen are determined
---by multiplying it’s scale value and dimensions.
---@param windowName - (string) The name of the window.
---@param scale - (number) Value between 0.0 and 1.0.
function WindowApi.setScale(windowName, scale)
    WindowSetScale(windowName, scale)
end

---Returns the current scale value on the window. A window’s visual size on the screen are determined by
---multiplying it’s scale value and dimensions.
---@param windowName - (string) The name of the window.
---@return @scale (number) Value between 0.0 and 1.0.
function WindowApi.getScale(windowName)
    return WindowGetScale(windowName)
end

---Scales the window relative to it’s current scale.  For example, a relative scale
---of 0.5 will scale a window to half it’s current size.
---@param windowName - id - (string) The name of the window.
---@return @scale (number) Value between 0.0 and 1.0.
function WindowApi.setRelativeScale(windowName, scale)
    WindowSetRelativeScale(windowName, scale)
end

---Resizes a parent window based upon the max sizes of its children
---@param windowName - (string) Name of the parent window to resize.
---@param isRecursive - (boolean) Whether or not to recurse through the children of your children.
---@param borderSpacing - (number) Amount of padding to add to the bottom and right.
function WindowApi.resizeOnChildren(windowName, isRecursive, borderSpacing)
    WindowResizeOnChildren(windowName, isRecursive, borderSpacing)
end

---Associates a a key-bindable action to clicking on this window.
---@param windowName - (string) Name of the window
---@param action - (number) The keybinding action id to trigger when the window is clicked.
function WindowApi.setGameActionTrigger(windowName, action)
    WindowSetGameActionTrigger(windowName, action)
end

---Associates a game action (a key-bindable action) to clicking on this window.
---@param windowName - (string) Name of the window
---@param actionType - (number) The Type of the action.
---@param actionId - (number) The id number of the action.
---@param actionText - (number) The text associated with the action.
function WindowApi.setGameActionData(windowName, actionType, actionId, actionText)
    WindowSetGameActionData(windowName, actionType, actionId, actionText)
end

---Sets the GameActionButton to use to trigger the Game Action associated with this window.
---@param windowName - (string) The name of the window.
---@param button - (number) The GameActionButton to use for this window see Game Action Buttons for values
function WindowApi.setGameActionButton(windowName, button)
    WindowSetGameActionButton(windowName, button)
end

---Returns if the current button used to trigger game actions.
---@param windowName - (string) The name of the window.
---@return @(number) The current GameAction button See Game Action Buttons for values.
function WindowApi.getGameActionButton(windowName)
    return WindowGetGameActionButton(windowName)
end

---Returns if this window is currently locked for editing game actions.
---@param windowName - (string) The name of the window.
---@return @(number) Returns if the window is locked for game actions or not.
function WindowApi.isGameActionLocked(windowName)
    return WindowIsGameActionLocked(windowName)
end

---This function sets if the window should be drawn if the main UI is hidden.
---@param windowName - (string) The name of the window.
---@param doDraw - (boolean) Should this window be drawn the the main UI is hidden?
function WindowApi.setDrawWhenInterfaceHidden(windowName, doDraw)
    WindowSetDrawWhenInterfaceHidden(windowName, doDraw)
end

---This function restores a window to it’s default anchors, size, scale, and alpha
---@param windowName - (string) The name of the window.
function WindowApi.restoreDefaultSettings(windowName)
    WindowRestoreDefaultSettings(windowName)
end
