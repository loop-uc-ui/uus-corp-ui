AbilityApi = {}

AbilityApi.RacialAbilityOffset = 3000
AbilityApi.WeaponAbilityOffset = 1000

function AbilityApi.getMaxRacialAbilities()
    return GetMaxRacialAbilities()
end

function AbilityApi.getRacialAbilityId(index)
    return GetRacialAbilityId(index) + AbilityApi.RacialAbilityOffset
end

function AbilityApi.getAbilityData(id)
    return GetAbilityData(id)
end

function AbilityApi.getWeaponAbilityId(index)
    return GetWeaponAbilityId(index) + AbilityApi.WeaponAbilityOffset
end