
UusCorp = {
    Api = {
        Ability = {
            GetMaxRacialAbilities = function ()
                return GetMaxRacialAbilities()
            end,
            GetRacialAbilityId = function (index)
                return GetRacialAbilityId(index) + 3000
            end,
            GetAbilityData = function (id)
                return GetAbilityData(id)
            end,
            GetWeapnAbilityId = function (index)
                return GetWeaponAbilityId(index) + 1000
            end
        },
        AnimatedImage = {
            SetTexture = function (imageName, texture)
                AnimatedImageSetTexture(imageName, texture)
            end,
            StartAnimation = function (imageName, startFrame, loop, hideWhenDone, delay)
                AnimatedImageStartAnimation(imageName, startFrame, loop, hideWhenDone, delay)
            end,
            StopAnimaton = function (imageName)
                AnimatedImageStopAnimation(imageName)
            end,
            SetPlaySpeed = function (imageName, fps)
                AnimatedImageSetPlaySpeed(imageName, fps)
            end
        },
        Button = {
            SetText = function (id, text)
                ButtonSetText(id, text)
            end,
            GetText = function (id)
                return ButtonGetText(id)
            end,
            SetDisabled = function (id, isDisabled)
                ButtonSetDisabledFlag(id, isDisabled)
            end,
            IsDisabled = function (id)
                return ButtonGetDisabledFlag(id)
            end,
            SetEnabled = function (id, isEnabled)
                ButtonSetCheckButtonFlag(id, isEnabled)
            end,
            SetChecked = function (id, isChecked)
                ButtonSetPressedFlag(id, isChecked)
            end,
            IsChecked = function (id)
                return ButtonGetPressedFlag(id)
            end,
            SetTexture = function (id, state, texture, x, y)
                ButtonSetTexture(id, state, texture, x, y)
            end,
            SetHighlight = function (id, doHighlight)
                ButtonSetHighlightFlag(id, doHighlight)
            end,
            SetStayDown = function (id, stayDown)
                ButtonSetStayDownFlag(id, stayDown)
            end,
            IsStayDown = function (id)
                return ButtonGetStayDownFlag(id)
            end,
            SetTextColor = function (id, r, g, b, a)
                ButtonSetTextColor(id, r, g, b, a)
            end
        },
        Chat = {
            SendChat = function (channel, text)
                SendChat(channel, text)
            end,
            PrintToChatWindow = function (wString, filter)
                PrintWStringToChatWindow(wString, filter)
            end
        },
        CircleImage = {
            SetTexture = function (id, texture, xCord, yCord)
                CircleImageSetTexture(id, texture, xCord, yCord)
            end,
            SetTextureScale = function (id, scale)
                CircleImageSetTextureScale(id, scale)
            end,
            SetRotation = function (id, rotation)
                CircleImageSetRotation(id, rotation)
            end
        },
        ComboBox = {
            AddItem = function (id, item)
                ComboBoxAddMenuItem(id, item)
            end,
            ClearItems = function (id)
                ComboBoxClearMenuItems(id)
            end,
            SetSelectedItem = function (id, item)
                ComboBoxSetSelectedMenuItem(id, item)
            end,
            GetSelectedItem = function (id)
                return ComboBoxGetSelectedMenuItem(id)
            end
        },
        ContextMenu = {
            RequestMenu = function (id)
                RequestContextMenu(id)
            end
        },
        CSV = {
            Load = function (path, name)
                UOBuildTableFromCSV(path, name)
            end,
            Unload = function (name)
                UOUnloadCSVTable(name)
            end
        },
        Drag = {
            DragToObject = function (id)
                DragSlotDropObjectToObject(id)
            end,
            SetActionMouseClickData = function (userAction, actionId, iconId)
                DragSlotSetActionMouseClickData(userAction, actionId, iconId)
            end,
            SetObjectMouseClickData = function (objectId, dragSource)
                DragSlotSetObjectMouseClickData(objectId, dragSource)
            end,
            DropOnPaperdollEquipment = function (objectId)
                DragSlotDropObjectToPaperdollEquipment(objectId)
            end,
            DropOnPaperdoll = function (paperdollId)
                DragSlotDropObjectToPaperdoll(paperdollId)
            end,
            DropOnObjectAtIndex = function (objectId, gridIndex)
                DragSlotDropObjectToObjectAtIndex(objectId, gridIndex)
            end,
            DropOnContainer = function (containerId, gridIndex)
                DragSlotDropObjectToContainer(containerId, gridIndex)
            end,
            AutoPickupObject = function (objectId)
                DragSlotAutoPickupObject(objectId)
            end
        },
        DynamicImage = {
            SetTexture = function (dynamicImageName, texture, x, y)
                DynamicImageSetTexture(dynamicImageName, texture or "", x or 0, y or 0)
            end,
            SetTextureScale = function (dynamicImageName,textureScale)
                DynamicImageSetTextureScale(dynamicImageName, textureScale)
            end,
            SetTextureDimensions = function (dynamicImageName, x, y)
                DynamicImageSetTextureDimensions(dynamicImageName, x, y)
            end,
            SetTextureOrientation = function (dynamicImageName, mirrored)
                DynamicImageSetTextureOrientation(dynamicImageName, mirrored)
            end,
            SetTextureSlice = function (dynamicImageName, sliceName)
                DynamicImageSetTextureSlice(dynamicImageName, sliceName)
            end,
            SetRotation = function (dynamicImageName, rotation)
                DynamicImageSetRotation(dynamicImageName, rotation)
            end,
            HasTexture = function (dynamicImageName)
                return DynamicImageHasTexture(dynamicImageName)
            end,
            SetCustomShader = function (dynamicImageName, shader, hue)
                DynamicImageSetCustomShader(dynamicImageName, shader, hue)
            end
        },
        EditTextBox = {
            SetText = function (editBoxName, text)
                TextEditBoxSetText(editBoxName, text or L"")
            end,
            GetText = function (editBoxName)
                return TextEditBoxGetText(editBoxName)
            end,
            GetTextLines = function (editBoxName)
                return TextEditBoxGetTextLines(editBoxName)
            end,
            InsertText = function (editBoxName, text)
                TextEditBoxInsertText(editBoxName, text)
            end,
            SetTextColor = function (editBoxName, color)
                TextEditBoxSetTextColor(editBoxName, color.r, color.g, color.b)
            end,
            GetTextColor = function (editBoxName)
                return TextEditBoxGetTextColor(editBoxName)
            end,
            SelectAll = function (editBoxName)
                TextEditBoxSelectAll(editBoxName)
            end,
            SetFont = function (editBoxName, fontName, lineSpacing)
                TextEditBoxSetFont(editBoxName, fontName, lineSpacing)
            end,
            GetFont = function (editBoxName)
                return TextEditBoxGetFont(editBoxName)
            end,
            GetHistory = function (editBoxName)
                return TextEditBoxGetHistory(editBoxName)
            end,
            SetHistory = function (editBoxName, history)
                TextEditBoxSetHistory(editBoxName, history)
            end,
            HandleKeyDown = function (editBoxName, handle)
                TextEditBoxSetHandleKeyDown(editBoxName, handle)
            end
        },
        Event = {
            Broadcast = function (event)
                BroadcastEvent(event)
            end
        },
        Gump = {
            OnLeftClick = function (gumpId, windowName)
                GenericGumpOnClicked(gumpId, windowName)
            end,
            OnDoubleClick = function (gumpId, windowName)
                GenericGumpOnDoubleClicked(gumpId, windowName)
            end,
            OnRightClick = function (gumpId)
                GenericGumpOnRClicked(gumpId)
            end,
            GetTooltipText = function (gumpId, windowName)
                return GenericGumpGetToolTipText(gumpId, windowName)
            end,
            OpenWebBrowser = function (link)
                OpenWebBrowser(tostring(link))
            end,
            OnCloseContainer = function (id)
                GumpManagerOnCloseContainer(id)
            end,
            GetItemPropertiesObjectId = function (gumpId, windowName)
                return GenericGumpGetItemPropertiesId(gumpId, windowName)
            end
        },
        Icon = {
            GetIconData = function (textureId)
                return GetIconData(textureId)
            end,
            GetTextureSize = function (textureId)
                return UOGetTextureSize(textureId)
            end,
            RequestTileArt = function (type, width, height)
                return RequestTileArt(type, width, height)
            end
        },
        Label = {
            SetText = function (name, text)
                if text == nil then
                    return
                elseif type(text) == "number" then
                    text = StringFormatter.fromTid(text)
                elseif type(text) == "string" then
                    text = StringFormatter.toWString(text)
                end
                LabelSetText(name, text)
            end,
            GetText = function (name)
                return LabelGetText(name)
            end,
            SetTextColor = function (name, color)
                LabelSetTextColor(name, color.r, color.g, color.b)
            end,
            SetTextAlignment = function (name, alignment)
                LabelSetTextAlign(name, alignment)
            end,
            SetWordWrap = function (name, wordWrap)
                LabelSetWordWrap(name, wordWrap)
            end
        },
        ListBox = {
            SetDataTable = function (name, data)
                ListBoxSetDataTable(name, data)
            end,
            GetDataIndex = function (name, rowIndex)
                return ListBoxGetDataIndex(name, rowIndex)
            end,
            SetDisplayOrder = function (name, orderArray)
                ListBoxSetDisplayOrder(name, orderArray)
            end,
            SetVisibleRowCount = function (name, count)
                ListBoxSetVisibleRowCount(name, count)
            end
        },
        LogDisplay = {
            ShowTimestamp = function (name, doShow)
                LogDisplaySetShowTimestamp(name, doShow == nil or doShow)
            end,
            IsTimestampShowing = function (name)
                return LogDisplayGetShowTimestamp(name)
            end,
            ShowLogName = function (name, doShow)
                LogDisplaySetShowLogName(name, doShow == nil or doShow)
            end,
            ShowFilterName = function (name,ndoShow)
                LogDisplaySetShowFilterName(name, doShow == nil or doShow)
            end,
            AddLog = function (name, log, bool)
                LogDisplayAddLog(name, log, bool == nil or bool)
            end,
            RemoveLog = function (name, log)
                LogDisplayRemoveLog(name, log)
            end,
            SetFilterColor = function (name, log, level, color)
                LogDisplaySetFilterColor(name, log, level, color.r, color.g, color.b)
            end,
            SetFilterState = function (name, log, filterId, filter)
                LogDisplaySetFilterState(name, log, filterId, filter)
            end,
            SetTextFadeTime = function (name, time)
                LogDisplaySetTextFadeTime(name, time)
            end,
            GetTextFadeTime = function (name)
                return LogDisplayGetTextFadeTime(name)
            end,
            IsScrollbarActive = function (name)
                return LogDisplayIsScrollbarActive(name)
            end,
            SetFont = function (name, font)
                LogDisplaySetFont(name, font)
            end,
            GetFont = function (name)
                return LogDisplayGetFont(name)
            end,
            ScrollToBottom = function ()
                LogDisplayScrollToBottom(name)
            end,
            IsScrolledToBottom = function (name)
                return LogDisplayIsScrolledToBottom(name)
            end,
            ResetLineFadeTime = function (name)
                LogDisplayResetLineFadeTime(name)
            end,
            ShowScrollbar = function (name, showScrollbar)
                LogDisplayShowScrollbar(name, showScrollbar)
            end,
            ScrollToTop = function (name)
                LogDisplayScrollToTop(name)
            end,
            IsScrolledToTop = function (name)
                return LogDisplayIsScrolledToTop(name)
            end
        },
        Mod = {
            SetEnabled = function (moduleName, isEnabled)
                ModuleSetEnabled(moduleName, isEnabled)
            end,
            Initialize = function (moduleName)
                ModuleInitialize(moduleName)
            end,
            GetData = function ()
                return ModulesGetData()
            end,
            InitializeRestricted = function ()
                ModulesInitializeRestricted()
            end,
            InitializeAllEnabled = function ()
                ModulesInitializeAllEnabled()
            end,
            LoadModuleAsRestricted = function (modFilePath, allowRaw)
                ModuleRestrictedLoad(modFilePath, allowRaw)
            end,
            LoadModule = function (modFilePath, setName, allowRaw)
                ModuleLoad(modFilePath, setName, allowRaw)
            end,
            LoadModulesFromList = function (listFilePath, setName, allowRaw)
                ModulesLoadFromListFile(listFilePath, setName, allowRaw)
            end,
            LoadModulesFromDirectory = function (directory, setName)
                ModulesLoadFromDirectory(directory, setName)
            end
        },
        Object = {
            GetDistanceFromPlayer = function (id)
                return GetDistanceFromPlayer(id)
            end,
            IsValid = function (id)
                return IsValidObject(id)
            end,
            IsMobile = function (id)
                return IsMobile(id)
            end,
            GetPaperdollObject = function (paperdollId, scale)
                return GetPaperdollObject(paperdollId, scale or 1.0)
            end
        },
        Radar = {
            SetWindowSize = function (sizeX, sizeY, boolOne, centerOnPlayer)
                UORadarSetWindowSize(sizeX, sizeY, boolOne, centerOnPlayer)
            end,
            GetFacet = function ()
                return UOGetRadarFacet()
            end,
            GetArea = function ()
                return UOGetRadarArea()
            end,
            SetOffset = function (offsetX, offsetY)
                UORadarSetWindowOffset(offsetX, offsetY)
            end,
            GetMaxZoom = function (facet, area)
                return UORadarGetMaxZoomForMap(facet, area)
            end,
            SetZoom = function (zoom)
                UOSetRadarZoom(zoom)
            end,
            SetCenterOnPlayer = function (isCenter)
                UORadarSetCenterOnPlayer(isCenter)
            end,
            GetPhysicalFacet = function ()
                return UOGetPhysicalRadarFacet()
            end,
            GetPhysicalArea = function (facet, area)
                return UORadarGetAreaDimensions(facet, area)
            end,
            GetFacetLabel = function (facet)
                return UORadarGetFacetLabel(facet)
            end,
            GetAreaLabel = function (facet, area)
                return UORadarGetAreaLabel(facet, area)
            end,
            GetFacetDimensions = function (num)
                return UORadarGetFacetDimensions(num)
            end,
            GetCenter = function ()
                return UOGetRadarCenter()
            end,
            SetRotation = function (rotation)
                UOSetRadarRotation(rotation)
            end,
            CenterOnLocation = function (x, y, facet, area, bool)
                UOCenterRadarOnLocation(x, y, facet, area, bool)
            end,
            IsLocationInArea = function (x, y, facet, area)
                return UORadarIsLocationInArea(x, y, facet, area)
            end,
            TranslateRadarPositionToWorldPosition = function (offsetX, offsetY, useScale)
                return UOGetRadarPosToWorld(offsetX, offsetY, useScale)
            end,
            TranslateWorldPositionToRadarPosition = function (x, y)
                return UOGetWorldPosToRadar(x, y)
            end,
            GetAreaCount = function (facet)
                return UORadarGetAreaCount(facet)
            end
        },
        Resources = {
            LoadResources = function (path, file, resource)
                LoadResources(path, file, resource)
            end
        },
        ScrollWindow = {
            SetOffset = function (id, offset)
                ScrollWindowSetOffset(id, offset)
            end,
            UpdateScrollRect = function (id)
                ScrollWindowUpdateScrollRect(id)
            end
        },
        Settings = {
            NotifyChange = function ()
                --This is some variable that the client understands
                needsReload = UserSettingsChanged()
                return needsReload
            end
        },
        Slider = {
            SetCurrentPosition = function (id, position)
                SliderBarSetCurrentPosition(id, position)
            end,
            GetCurrentPosition = function (id)
                return SliderBarGetCurrentPosition(id)
            end
        },
        StatusBar = {
            SetMaxValue = function (id, value)
                StatusBarSetMaximumValue(id, value or 0)
            end,
            SetCurrentValue = function (id, value)
                StatusBarSetCurrentValue(id, value or 0)
            end,
            SetForegroundTint = function (id, color)
                StatusBarSetForegroundTint(id, color.r, color.g, color.b)
            end,
            SetBackgroundTint = function (id, color)
                StatusBarSetBackgroundTint(id, color.r, color.g, color.b)
            end
        },
        String = {
            GetStringFromTid = function (tid)
                return GetStringFromTid(tid)
            end,
            StringToWString = function (string)
                return StringToWString(string)
            end,
            WStringToString = function (wString)
                return WStringToString(wString)
            end
        },
        Target = {
            LeftClick = function (id)
                HandleSingleLeftClkTarget(id)
            end,
            GetAllMobileTargets = function ()
                return GetAllMobileTargets()
            end
        },
        TextLog = {
            Create = function (name, num)
                TextLogCreate(name, num)
            end,
            Destroy = function ()
                TextLogDestroy(name)
            end,
            SetEnabled = function (name, isEnable)
                TextLogSetEnabled(name, isEnable == nil or isEnable)
            end,
            Clear = function (name)
                TextLogClear(name)
            end,
            SetIncrementalSaving = function (name, doSave, path)
                TextLogSetIncrementalSaving(name, doSave, path)
            end,
            IsEnabled = function (name)
                return TextLogGetEnabled(name)
            end,
            GetNumEntries = function (name)
                return TextLogGetNumEntries(name)
            end,
            GetEntry = function (name, index)
                return TextLogGetEntry(name, index)
            end,
            AddEntry = function (name, filterId, text)
                TextLogAddEntry(name, filterId, text)
            end
        },
        Time = {
            GetCurrentDateTime = function ()
                return GetCurrentDateTime()
            end
        },
        UserAction = {
            UseItem = function (id, flag)
                UserActionUseItem(id, flag)
            end,
            ToggleWarMode = function ()
                UserActionToggleWarMode()
            end
        },
        Viewport = {
            Update = function (x1, y1, x2, y2)
                UpdateViewport(x1, y1, x2, y2)
            end
        },
        Waypoint = {
            SetFacet = function (facet)
                UOSetWaypointMapFacet(facet)
            end,
            Create = function (type, facet, x, y, id)
                UOCreateUserWaypoint(type, facet, x, y, id)
            end,
            Delete = function (id)
                UODeleteUserWaypoint(id)
            end,
            Edit = function (id)
                UOEditUserWaypoint(id)
            end,
            ResetFacet = function ()
                UOResetWaypointMapFacet()
            end,
            SetTypeDisplayInfo = function ()
                UOSetWaypointTypeDisplayInfo()
            end,
            SetDisplayMode = function (mode)
                UOSetWaypointDisplayMode(mode)
            end,
            GetInfo = function (id)
                return UOGetWaypointInfo(id)
            end
        },
        Window = {
            Destroy = function (windowName)
                if UusCorp.Api.Window.DoesExist(windowName) then
                    DestroyWindow(windowName)
                    return true
                end

                return false
            end,
            DoesExist = function (windowName)
                return DoesWindowNameExist(windowName)
            end,
            SetShowing = function (windowName, show)
                WindowSetShowing(windowName, show)
            end,
            IsShowing = function (windowName)
                return WindowGetShowing(windowName)
            end,
            SetLayer = function (windowName, layer)
                WindowSetLayer(windowName, layer)
            end,
            GetLayer = function (windowName)
                return WindowGetLayer(windowName)
            end,
            SetHandleInput = function (windowName, handleInput)
                WindowHandleInput(windowName, handleInput)
            end,
            GetHandleInput = function (windowName)
                return WindowGetHandleInput(windowName)
            end,
            SetPopable = function (windowName, popable)
                WindowSetPopable(windowName, popable)
            end,
            IsPopable = function (windowName)
                return windowGetPopable(windowName)
            end,
            SetMovable = function (windowName, movable)
                WindowSetMovable(windowName, movable)
            end,
            IsMovable = function (windowName)
                return WindowGetMovable(windowName)
            end,
            SetOffsetFromParent = function (windowName, xOffset, yOffset)
                WindowSetOffsetFromParent(windowName, xOffset, yOffset)
            end,
            GetOffsetFromParent = function (windowName)
                return WindowGetOffsetFromParent(windowName)
            end,
            SetDimensions = function (windowName, xOffset, yOffset)
                WindowSetDimensions(windowName, xOffset, yOffset)
            end,
            GetDimensions = function (windowName)
                return WindowGetDimensions(windowName)
            end,
            IsSticky = function (windowName)
                return WindowIsSticky(windowName)
            end,
            ClearAnchors = function (windowName)
                WindowClearAnchors(windowName)
            end,
            AddAnchor = function (windowName, anchorPoint, relativeTo, relativePoint, pointX, pointY)
                WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, pointX or 0, pointY or 0)
            end,
            GetAnchor = function (windowName, anchorId)
                return WindowGetAnchor(windowName, anchorId)
            end,
            GetAnchorCount = function (windowName)
                return WindowGetAnchorCount(windowName)
            end,
            ForceProcessAnchors = function (windowName)
                WindowForceProcessAnchors(windowName)
            end,
            AssignFocus = function (windowName, doFocus)
                return WindowAssignFocus(windowName, doFocus)
            end,
            HasFocus = function (windowName)
                return WindowHasFocus(windowName)
            end,
            SetResizing = function (windowName, isResizing)
                WindowSetResizing(windowName, isResizing)
            end,
            IsResizing = function (windowName)
                return WindowGetResizing(windowName)
            end,
            StartAlphaAnimation = function (windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
                WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
            end,
            StopAlphaAnimation = function (windowName)
                WindowStopAlphaAnimation(windowName)
            end,
            StopScaleAnimation = function (windowName)
                WindowStopScaleAnimation(windowName)
            end,
            StartScaleAnimation = function (windowName, animType, startX, startY, endX, endY, duration, setStartBeforeDelay, delay, numLoop)
                WindowStartScaleAnimation(
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
            end,
            StopPositionAnimation = function (windowName)
                WindowStopPositionAnimation(windowName)
            end,
            SetAlpha = function (windowName, alpha)
                WindowSetAlpha(windowName, alpha)
            end,
            GetAlpha = function (windowName)
                return WindowGetAlpha(windowName)
            end,
            SetColor = function (windowName, color)
                WindowSetTintColor(windowName, color.r, color.g, color.b)
            end,
            CreateFromTemplate = function (windowName, template, parent, doShow)
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    CreateWindowFromTemplateShow(windowName, template or windowName, parent or "Root", doShow == nil or doShow)
                    return true
                end
                return false
            end,
            Create = function (windowName, doShow)
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    CreateWindow(windowName, doShow == nil or doShow)
                    return true
                end
                return false
            end,
            ToggleWindow = function ()
                if not UusCorp.Api.Window.DoesExist(windowName) then
                    return UusCorp.Api.Window.Create(windowName, true)
                end
                return true
            end,
            SetId = function (windowName, id)
                WindowSetId(windowName, id)
            end,
            GetId = function (windowName)
                return WindowGetId(windowName)
            end,
            SetTabOrder = function (windowName, tabOrder)
                WindowSetTabOrder(windowName, tabOrder)
            end,
            GetTabOrder = function (windowName)
                return WindowGetTabOrder(windowName)
            end,
            SetMoving = function (windowName, isMoving)
                WindowSetMoving(windowName, isMoving)
            end,
            IsMoving = function (windowName)
                return WindowGetMoving(windowName)
            end,
            RegisterEventHandler = function (windowName, event, callback)
                WindowRegisterEventHandler(windowName, event, callback)
            end,
            UnregisterEventHandler = function (windowName, event)
                WindowUnregisterEventHandler(windowName, event)
            end,
            RegisterCoreEventHandler = function (windowName, event, callback)
                WindowRegisterCoreEventHandler(windowName, event, callback)
            end,
            UnregisterCoreEventHandler = function (windowName, event)
                WindowUnregisterCoreEventHandler(windowName, event)
            end,
            SetParent = function (windowName, parentId)
                WindowSetParent(windowName, parentId)
            end,
            GetParent = function (windowName)
                return WindowGetParent(windowName)
            end,
            SetScale = function (windowName, scale)
                WindowSetScale(windowName, scale)
            end,
            GetScale = function (windowName)
                return WindowGetScale(windowName)
            end,
            SetRelativeScale = function (windowName, scale)
                WindowSetRelativeScale(windowName, scale)
            end,
            SetResizeOnChildren = function (windowName, isRecursive, borderSpacing)
                WindowResizeOnChildren(windowName, isRecursive, borderSpacing)
            end,
            SetGameActionTrigger = function (windowName, action)
                WindowSetGameActionTrigger(windowName, action)
            end,
            SetGameActionData = function (windowName, actionType, actionId, actionText)
                WindowSetGameActionData(windowName, actionType, actionId, actionText)
            end,
            SetGameActionButton = function (windowName, button)
                WindowSetGameActionButton(windowName, button)
            end,
            GetGameActionButton = function (windowName)
                return WindowGetGameActionButton(windowName)
            end,
            IsGameActionLocked = function (windowName)
                return WindowIsGameActionLocked(windowName)
            end,
            SetDrawWhenInterfaceHidden = function (windowName, doDraw)
                WindowSetDrawWhenInterfaceHidden(windowName, doDraw)
            end,
            RestoreDefaults = function (windowName)
                WindowRestoreDefaultSettings(windowName)
            end,
            SetUpdateFrequency = function (windowName, frequency)
                WindowSetUpdateFrequency(windowName, frequency)
            end,
            GetPosition = function (id)
                return WindowGetScreenPosition(id)
            end,
            AttachToWorldObject = function (objectId, window)
                AttachWindowToWorldObject(objectId, window)
            end,
            DetachFromWorldObject = function (objectId, window)
                DetachWindowFromWorldObject(objectId, window)
            end,
            RegisterData = function (data, id)
                RegisterWindowData(data, id or 0)
            end,
            UnregisterData = function (data, id)
                UnregisterWindowData(data, id or 0)
            end,
            SavePostion = function (window, closing, alias)
                WindowUtils.SaveWindowPosition(window, closing, alias)
            end,
            RestorePostion = function (window, trackSize, alias, ignoreBounds)
                WindowUtils.RestoreWindowPosition(window, trackSize, alias, ignoreBounds)
            end
        }
    }
}