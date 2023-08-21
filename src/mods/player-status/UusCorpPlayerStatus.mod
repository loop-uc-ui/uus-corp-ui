<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UusCorpPlayerStatus" version="0.1" date="03/07/2023">

		<Author name="Loop" />
		<Description text="https://github.com/loop-uc-ui/uus-corp-ui/" />

		<Dependencies>
			<Dependency name="UusCorpCore" />
		</Dependencies>

		<Files>
            <File name="UusCorpPlayerStatusWindow.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="UusCorpPlayerStatusWindow.initialize" />
		</OnInitialize>

		<OnShutdown>
			<CallFunction name="UusCorpPlayerStatusWindow.shutdown"/>
		</OnShutdown>

		<SavedVariables>
			<SavedVariable name="UusCorpPlayerStatusWindow.isPlayerStatusOpen"/>
		</SavedVariables>
	</UiMod>
</ModuleFile>