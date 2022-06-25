UserAction = {}

function UserAction.useSkill(id)
    UserActionUseSkill(id)
end

function UserAction.typeSkill()
    return SystemData.UserAction.TYPE_SKILL
end

function UserAction.useItem(id, flag)
    UserActionUseItem(id, flag)
end

function UserAction.castSpell(serverId)
    UserActionCastSpell(serverId)
end