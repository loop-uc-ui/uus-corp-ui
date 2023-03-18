<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UusCorpCharacterAbilities" version="0.1" date="03/07/2023">

		<Author name="Loop" />
		<Description text="https://github.com/loop-uc-ui/uus-corp-ui/" />

		<Dependencies>
			<Dependency name="UusCorpCore" />
		</Dependencies>

		<Files>
			<File name="UusCorpCharacterAbilitiesWindow.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="UusCorpCharacterAbilitiesWindow.initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>