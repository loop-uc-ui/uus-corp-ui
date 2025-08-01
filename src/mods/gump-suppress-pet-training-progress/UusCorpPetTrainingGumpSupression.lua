UusCorpPetTrainingGumpSuppression = UusCorp.Mod {
    Name = "UusCorpPetTrainingGumpSuppression",
    Path = "/src/mods/gump-suppress-pet-training-progress",
    OnInitialize = function (context)
        context.Views.Defaults.GumpsParsing:appendToFunction(
            "MainParsingCheck",
            ---@param self GumpsParsing
            function(self)
                self.ToShow[999139] = nil -- Suppress pet training progress gump
            end
        )
    end
}