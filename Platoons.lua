--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Wrecks = import("/maps/survival_stranded.v0016/Wrecks.lua")

cacheDropPlatoons = { }

function RandomArmyGroup()
    local n = table.getn(cacheDropPlatoons)
    local i = math.floor(Random() * n) + 1
    return cacheDropPlatoons[i]
end

function SpawnArmyGroup(tblData, army, position)
    local transports = { }
    
    for k, bp in tblData.transports do
        
        local unit = CreateUnitHPR(bp, army, position[1], position[2], position[3], 0, 0, 0)
                       
        -- Set the health mutiplier               
        unit:SetMaxHealth(unit:GetMaxHealth() * ScenarioInfo.Options.opt_Survival_HealthMultiplier)               
        unit:SetHealth(unit, unit:GetMaxHealth())
        unit:SetVeterancy(5)
            -- Set the damadge multiplier
            for i = 1, unit:GetWeaponCount() do
                local Weapon = unit:GetWeapon(i)
                if Weapon.Label ~= 'DeathWeapon' and Weapon.Label ~= 'DeathImpact' then
                    Weapon:AddDamageMod(Weapon:GetBlueprint().Damage * (ScenarioInfo.Options.opt_Survival_DamageMultiplier - 1))
                end
            end

        table.insert(transports, unit)
    end
    local transportees = { }
   
    for k, bp in tblData.transportees do
        local unit = CreateUnitHPR(bp, army, position[1], position[2], position[3], 0, 0, 0)

        -- Set the health mutiplier               
        unit:SetMaxHealth(unit:GetMaxHealth() * ScenarioInfo.Options.opt_Survival_HealthMultiplier)               
        unit:SetHealth(unit, unit:GetMaxHealth())

        table.insert(transportees, unit)
    end

    return transports, transportees
end

local function UnitToBlueprintID(unit)
    return unit:GetBlueprint().BlueprintId
end

local function UnitsToBlueprintID(units)
    local ids = { }
    for k, unit in units do 
        table.insert(ids, UnitToBlueprintID(unit))
    end
    return ids
end

--local offset = 0 -- set to startup time
local offset = ScenarioInfo.Options.opt_Survival_BuildTime
local timeToUnlockTech = 900 -- time in seconds between each tech unlock (every 15 mins)

---- Starting tech lvl
local techIntegral = 1
local techIdentifiers = {
    -- transport tech 1,2,3 group x
    "TT1G", "TT2G", "TT3G" 
}

local techIdentifier = techIdentifiers[techIntegral]

local function CheckValidityOfCache(cache)
    if table.getn(cache) == 0 then
        WARN("Cache is empty: cacheDropPlatoons")
    end
end

local function CreateCachedPlatoon(army, name)
    local units = ScenarioUtils.CreateArmyGroup(army, name, false, false)

    -- about category operators
    -- + = or 
    -- - = subtracting
    -- * = and 
    -- / = ?

    -- filter the units into categories
    local transports = UnitsToBlueprintID(
        EntityCategoryFilterDown(categories.TRANSPORTATION, units )
    )
    local transportees = UnitsToBlueprintID(
        EntityCategoryFilterDown(categories.ALLUNITS - categories.TRANSPORTATION, units)
    )

    -- take 'em all out (to dinner)
    for k, unit in units do 

          --- CHeck if Wrecks is enabled or not
          if ScenarioInfo.Options.opt_Wrecks == 1 then
            local bp = unit:GetBlueprint()
            if (bp != nil) then
            bp.Wreckage = nil
            end 
        end
         
       unit:Destroy()
    end

    -- prepare the cache format
    local cache = { }
    cache.transports = transports
    cache.transportees = transportees 
    return cache
end

local function CreateCachedPlatoons(army, identifier)

    local cache = { }

    -- makes our life easier to check if the group exists
    local scenario = ScenarioInfo.Env.Scenario 
    local tblNode = Scenario.Armies[army].Units

    -- go find up to 20 groups
    for k = 1, 20 do 
        -- construct the name of the unit group x
        local name = identifier .. k 

        -- check if the group exists
        local group = ScenarioUtils.FindUnitGroup(name, tblNode)
        if group then 
            table.insert(cache, CreateCachedPlatoon(army, name))
        -- groups are ordered, we can stop
        else 
            break
        end
    end

    -- give ourselves some feedback
    LOG("We found " .. table.getn(cache) .. " unit groups for " .. identifier)
    CheckValidityOfCache(cache)

    return cache
end

function OnStart()

    -- constants
    local army = "ARMY_ENEMY"

    -- initialisation
    techIdentifier = techIdentifiers[techIntegral]
    cacheDropPlatoons = CreateCachedPlatoons(army, techIdentifier)
end

function OnTick()

    local army = "ARMY_ENEMY"
  
    while true do 

        -- get current game time in seconds  
        local time = (GetGameTimeSeconds() - offset)  
        --local k = math.random(1,10)
        -- want to map time to integral value that represents tech
        if time > techIntegral * timeToUnlockTech then 

            -- we don't have more than three techs
            if techIntegral >= 3 then
                techIntegral = 3
                LOG("Transport tech is already maxed out: " .. techIntegral)
            -- we're still below tech three, so keep going
            else
                techIntegral = techIntegral + 1
                LOG("Upgrading transport tech to " .. techIntegral)
            end

            -- update the tech identifier
            techIdentifier = techIdentifiers[(techIntegral)]

            -- populate the cache with new data
            cacheDropPlatoons = CreateCachedPlatoons(army, techIdentifier)
        end

        -- this needs to be in forkthread
        WaitSeconds(1)
    end
end
