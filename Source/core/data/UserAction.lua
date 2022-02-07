UserAction = {}

function UserAction.useSkill(id)
    UserActionUseSkill(id)
end

function UserAction.typeSkill()
    return SystemData.UserAction.TYPE_SKILL
end