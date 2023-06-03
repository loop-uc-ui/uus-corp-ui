<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UusCorpCore" version="1.0" date="03/07/2023">

		<Author name="Loop" />
		<Description text="https://github.com/loop-uc-ui/uus-corp-ui/" />

		<Files>
            <File name="UusCorpCore.lua"/>
			<File name="api/AbilityApi.lua" />
			<File name="api/AnimatedImageApi.lua" />
			<File name="api/ButtonApi.lua" />
			<File name="api/ChatApi.lua" />
			<File name="api/CircleImageApi.lua" />
			<File name="api/ComboBoxApi.lua" />
			<File name="api/ContextMenuApi.lua" />
			<File name="api/CSVApi.lua" />
            <File name="api/DragApi.lua" />
			<File name="api/DynamicImageApi.lua" />
			<File name="api/EditTextBoxApi.lua" />
			<File name="api/EventApi.lua" />
			<File name="api/GumpApi.lua" />
			<File name="api/IconApi.lua" />
			<File name="api/LabelApi.lua" />
			<File name="api/ListBoxApi.lua" />
            <File name="api/LogDisplayApi.lua" />
			<File name="api/ModuleApi.lua" />
			<File name="api/ObjectApi.lua" />
			<File name="api/RadarApi.lua" />
            <File name="api/ResourceApi.lua" />
			<File name="api/ScrollWindowApi.lua" />
			<File name="api/SettingsApi.lua" />
			<File name="api/SliderApi.lua" />
			<File name="api/StatusBarApi.lua" />
            <File name="api/StringApi.lua" />
            <File name="api/TargetApi.lua" />
			<File name="api/TextLogApi.lua" />
			<File name="api/TimeApi.lua" />
			<File name="api/UserActionApi.lua" />
			<File name="api/ViewportApi.lua" />
			<File name="api/WaypointApi.lua" />
			<File name="api/WindowApi.lua" />
			<File name="api/WindowDataApi.lua" />
            <File name="data/Active.lua" />
            <File name="data/Animation.lua" />
            <File name="data/Buffs.lua" />
            <File name="data/ButtonFlags.lua" />
            <File name="data/Chat.lua" />
            <File name="data/Container.lua" />
            <File name="data/ContextMenuData.lua" />
            <File name="data/CurrentTarget.lua" />
            <File name="data/Cursor.lua" />
            <File name="data/Drag.lua" />
            <File name="data/Equipment.lua" />
            <File name="data/Events.lua" />
            <File name="data/Gump.lua" />
            <File name="data/ItemPropertiesData.lua" />
            <File name="data/MapSettings.lua" />
            <File name="data/MobileData.lua" />
            <File name="data/MousePosition.lua" />
            <File name="data/ObjectHandles.lua" />
            <File name="data/ObjectInfo.lua" />
            <File name="data/Paperdoll.lua" />
            <File name="data/PlayerEquipment.lua" />
            <File name="data/PlayerLocation.lua" />
            <File name="data/PlayerStatus.lua" />
            <!-- <File name="data/Radar.lua" /
            <File name="data/ScreenResolution.lua" /> -->
            <File name="data/ShopData.lua" />
            <File name="data/Skills.lua" />
            <File name="data/Spells.lua" />
            <File name="data/UserAction.lua" />
            <File name="data/UserContainerSettings.lua" />
            <File name="data/UserControlSettings.lua" />
            <File name="data/UserGraphicsSettings.lua" />
            <File name="data/UserHealthBarsSettings.lua" />
            <File name="data/UserInterfaceVariables.lua" />
            <File name="data/UserOptionsSettings.lua" />
            <File name="data/UserOverheadTextSettings.lua" />
            <File name="data/UserSoundSettings.lua" />
            <!--<File name="data/WaypointDisplay.lua" />
            <File name="data/WaypointList.lua" /> -->
            <File name="resources/Colors.lua"/>
            <File name="resources/TextIds.lua"/>
            <File name="util/CSVUtilities.lua"/>
            <File name="util/StringFormatter.lua"/>
            <File name="util/TableFormatter.lua"/>
            <File name="util/WindowUtilsWrapper.lua"/>
		</Files>

        <OnInitialize>
            <CallFunction name="UusCorpCore.initialize"/>
        </OnInitialize>
	</UiMod>
</ModuleFile>