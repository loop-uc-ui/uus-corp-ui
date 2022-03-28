LegacyRunebook = {
    Name = "LEGACY_Runebook_GUMP",
    init = function()
        local self = UusCorpWindow.init(LegacyRunebook.Name)
        local gumpData = {}
        local selectedRune

        local function castSpell(spellId, index)
            GameData.UseRequests.UseSpellcast = spellId
            Interface.SpellUseRequest()
            UO_GenericGump.broadcastButtonPress(index, gumpData)
            self.destroy()
        end

        local renameBook = RunebookButton.init(
			nil,
			self.getName() .. "RenameBook",
			nil,
			1011299
		)

        renameBook.getLifeCycle().onLButtonDown = function()
            UO_GenericGump.broadcastButtonPress(1000, gumpData)
            self.destroy()
        end

        self.getChildAdapter().addChild(renameBook)

        local dropRune = RunebookButton.init(
			nil,
			self.getName() .. "DropRune",
			nil,
            1011298
		)

        dropRune.getLifeCycle().onLButtonDown = function()
            if selectedRune == nil then return end

            UO_GenericGump.broadcastButtonPress(
				199 + selectedRune.index,
                gumpData
			)
            self.destroy()
        end

        self.getChildAdapter().addChild(dropRune)

        local recall = RunebookButton.init(
			nil,
			self.getName() .. "Recall",
			nil,
			1077594
		)

        recall.getLifeCycle().onLButtonDown = function()
            if selectedRune ~= nil then
                castSpell(32, selectedRune.getRecallChargeIndex())
            end
        end

        self.getChildAdapter().addChild(recall)

        local recallSpell = RunebookButton.init(
			nil,
			self.getName() .. "RecallSpell",
			nil,
			1077595
		)

        recallSpell.getLifeCycle().onLButtonDown = function()
            if selectedRune ~= nil then
                castSpell(32, selectedRune.getRecallSpellIndex())
            end
        end

        self.getChildAdapter().addChild(recallSpell)

        local gateTravel = RunebookButton.init(
			nil,
			self.getName() .. "GateTravel",
			nil,
			1062723
		)

        gateTravel.getLifeCycle().onLButtonDown = function()
            if selectedRune ~= nil then
                castSpell(52, selectedRune.getGateTravelIndex())
            end
        end

        self.getChildAdapter().addChild(gateTravel)

        local sacredJourney = RunebookButton.init(
			nil,
			self.getName() .. "Sacred",
			nil,
			1062724
		)

        sacredJourney.getLifeCycle().onLButtonDown = function()
            if selectedRune ~= nil then
                castSpell(210, selectedRune.getSacredJourneyIndex())
            end
        end

        self.getChildAdapter().addChild(sacredJourney)

        local coords = UusCorpLabel.init(self.getName() .. "CoordsName")

        self.getChildAdapter().addChild(coords)

        local location = UusCorpLabel.init(self.getName() .. "LocationName")

        self.getChildAdapter().addChild(location)

        self.getLifeCycle().onInitialize = function()
            gumpData = GenericGumpCore:new()

            -- This call is needed for all buttons to work.
            -- It must do some gump registration behind the scenes.
            if not UO_GenericGump.retrieveWindowData(gumpData) then
                return
            end

			local charges = UusCorpLabel.init(
				self.getName() .. "Charges",
				StringFormatter.fromTid(1011296)..gumpData:getStringData()[19]..
					L"/"..gumpData:getStringData()[20]
			)
			self.getChildAdapter().addChild(charges)

            for i = 3, 18 do
				local button = RunebookButton.init(
					i - 2,
					nil,
					gumpData:getTextHueData()[i -2],
					gumpData:getStringData()[i]
				)

                if i == 3 then selectedRune = button end

				button.getLifeCycle().onLButtonDown = function ()
					if selectedRune ~= nil then
						selectedRune.onClick(false)
					end	

					selectedRune = button
					selectedRune.onClick(true)
				end

				self.getChildAdapter().addChild(button)
            end

            UusCorpWindow.onInitialize(self)
			selectedRune.onClick(true)
        end

        return self
    end
}

-- LegacyRunebook.gumpData = {}

-- local selectedRune

-- local function toggleHardCodedButtons(isDisabled)
-- 	for key, value in pairs(LegacyRunebook.adapter.views) do
-- 		if string.find(key, "Icon") and not string.find(key, "Button") then
-- 			value:setDisabledFlag(isDisabled)
-- 		end
-- 	end
-- end

-- local function castSpell(spellId, index)
-- 	GameData.UseRequests.UseSpellcast = spellId
-- 	Interface.SpellUseRequest()
-- 	Debug.Print(LegacyRunebook.gumpData)
-- 	UO_GenericGump.broadcastButtonPress(
-- 			index,
-- 			LegacyRunebook.gumpData
-- 	)
-- 	LegacyRunebook:destroy()
-- end

-- function LegacyRunebook.Initialize()
-- 	WindowUtils.RestoreWindowPosition(LegacyRunebook.id)
-- 	LegacyRunebook.gumpData = GenericGumpCore:new()

-- 	--This call is needed for all buttons to work.
-- 	--It must do some gump registration behind the scenes.
-- 	if not UO_GenericGump.retrieveWindowData(LegacyRunebook.gumpData) then
-- 		return
-- 	end

-- 	for i = 3, 18 do
-- 		local button = RunebookButtonWindow:new(
-- 				i - 2,
-- 				LegacyRunebook.gumpData:getTextHueData()[i - 2],
-- 				LegacyRunebook.gumpData:getStringData()[i]
-- 		)
-- 		button:initialize()
-- 		button:anchor()
-- 		LegacyRunebook.adapter.views[button.id] = button

-- 		if i == 3 then
-- 			selectedRune = button
-- 		end
-- 	end

-- 	LegacyRunebook.adapter:addLabel(
-- 			LegacyRunebook.id.."RenameBookName",
-- 			1011299
-- 	):addLabel(
-- 			LegacyRunebook.id.."DropRuneName",
-- 			1011298
-- 	):addLabel(
-- 			LegacyRunebook.id.."RecallName",
-- 			1077594
-- 	):addLabel(
-- 			LegacyRunebook.id.."RecallSpellName",
-- 			1077595
-- 	):addLabel(
-- 			LegacyRunebook.id.."GateTravelName",
-- 			1062723
-- 	):addLabel(
-- 			LegacyRunebook.id.."SacredName",
-- 			1062724
-- 	):addLabel(
-- 			LegacyRunebook.id.."CoordsName"
-- 	):addLabel(
-- 			LegacyRunebook.id.."LocationName"
-- 	):addButton(
-- 			LegacyRunebook.id.."RecallIcon"
-- 	):addButton(
-- 			LegacyRunebook.id.."RecallSpellIcon"
-- 	):addButton(
-- 			LegacyRunebook.id.."GateTravelIcon"
-- 	):addButton(
-- 			LegacyRunebook.id.."SacredIcon"
-- 	):addButton(
-- 			LegacyRunebook.id.."DropRuneIcon"
-- 	):addLabel(
-- 			LegacyRunebook.id.."Charges",
-- 			StringFormatter.fromTid(1011296)..LegacyRunebook.gumpData:getStringData()[19]..
-- 					L"/"..LegacyRunebook.gumpData:getStringData()[20]
-- 	)

-- 	if not selectedRune:icon():isDisabled() then
-- 		selectedRune:onClick(true)
-- 		toggleHardCodedButtons(false)
-- 		LegacyRunebook:UpdateCoordTextandLoc(selectedRune)
-- 	end
-- end

-- function LegacyRunebook.OnRecallSpellClicked()
-- 	if selectedRune ~= nil then
-- 		castSpell(32, selectedRune:recallSpellIndex())
-- 	end
-- end

-- function LegacyRunebook.OnRecallChargeClicked()
-- 	if selectedRune ~= nil then
-- 		castSpell(32, selectedRune:recallChargeIndex())
-- 	end
-- end

-- function LegacyRunebook.OnGateTravelClicked()
-- 	if selectedRune ~= nil then
-- 		castSpell(52, selectedRune:gateTravelIndex())
-- 	end
-- end

-- function LegacyRunebook.OnSacredClicked()
-- 	if selectedRune ~= nil then
-- 		castSpell(210, selectedRune:sacredJourneyIndex())
-- 	end
-- end

-- function LegacyRunebook.Shutdown()
-- 	LegacyRunebook.gumpData = {}
-- 	WindowUtils.SaveWindowPosition(LegacyRunebook.id, false, "LEGACY_Runebook_GUMP")
-- end

-- function LegacyRunebook:UpdateCoordTextandLoc(rune)
-- 	if rune == nil then
-- 		return
-- 	end

-- 	local label = self.adapter.views[self.id.."CoordsName"]
-- 	label:setText(
-- 			rune:coords()
-- 	)

-- 	label = self.adapter.views[self.id.."LocationName"]
-- 	label:setText(
-- 			rune:label():getText()
-- 	)
-- end

-- function LegacyRunebook.OnRuneClicked()
-- 	if selectedRune ~= nil then
-- 		selectedRune:onClick(false)
-- 	end

-- 	local button = LegacyRunebook.adapter.views[ActiveWindow.name()]
-- 	selectedRune = button
-- 	selectedRune:onClick(true)
-- 	toggleHardCodedButtons(false)
-- 	LegacyRunebook:UpdateCoordTextandLoc(selectedRune)
-- end

-- function LegacyRunebook.OnRenameClicked()
-- 	UO_GenericGump.broadcastButtonPress(1000, LegacyRunebook.gumpData)
-- 	LegacyRunebook:destroy()
-- end

-- function LegacyRunebook.OnDropRuneClicked()
-- 	if selectedRune == nil then
-- 		return
-- 	end

-- 	UO_GenericGump.broadcastButtonPress(199 + selectedRune.index, LegacyRunebook.gumpData)
-- 	LegacyRunebook:destroy()
-- end

-- function LegacyRunebook.Close()
-- 	LegacyRunebook:destroy()
-- end
