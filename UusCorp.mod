<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="UusCorp" version="1.0" date="03/07/2023">
		<Author name="Loop" />
		<Description text="https://github.com/loop-uc-ui/uus-corp-ui" />

        <Dependencies>
			<Dependency name="UusCorpCore" />
		</Dependencies>

		<Files>
			<File name="UusCorp.lua" />
		</Files>

		<OnInitialize>
			<CallFunction name="UusCorp.initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>