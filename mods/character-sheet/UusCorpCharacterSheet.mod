<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UusCorpCharacterSheet" version="0.1" date="03/07/2023">

		<Author name="Loop" />
		<Description text="https://github.com/loop-uc-ui/uus-corp-ui/" />

		<Dependencies>
			<Dependency name="UusCorpCore" />
		</Dependencies>

		<Files>
			<File name="UusCorpCharacterSheetWindow.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="UusCorpCharacterSheetWindow.initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>