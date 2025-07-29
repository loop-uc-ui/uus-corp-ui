UusCorpTargetMod = UusCorp.Mod {
    Name = "UusCorpTarget",

    Path = "/src/mods/target",

    OnInitialize = function (context)
        local default = context.Views.Defaults.TargetWindow
        context.Utils.Table.OverrideFunctions(default:getDefault())
        default:unregisterData(CurrentTarget.dataType(), 0)
        default:unregisterEventHandler(CurrentTarget.event())
        default:unregisterEventHandler(MobileStatus.event())
        default:unregisterEventHandler(MobileData.nameEvent())
        default:unregisterEventHandler(ObjectInfo.event())
        default:unregisterEventHandler(HealthBarColorData.event())
        default:unregisterCoreEventHandler("OnUpdate")
        default:setShowing(false)

        WindowDataApi.registerData(CurrentTarget.dataType(), 0)
        WindowApi.registerEventHandler("Root", CurrentTarget.event(), "UusCorpTargetWindow.createWindow")

    end
}