--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Wrecks = import("/maps/survival_stranded.v0019/Wrecks.lua")

cachelandPlatoons = { }

function RandomArmyGroup()
    local n = table.getn(cachelandPlatoons)
    local i = math.floor(Random() * n) + 1
    return cachelandPlatoons[i]
end

function SpawnArmyGroup(tblData, army, position)
    local units = { }
    ----LOGHEEEEEEEEEEEEEEEEEEEEEEEEEEERRRRRRRRRRRRRRRRRRRRRREEEEEEEE);
    for k, bp in tblData do 
    local unit = CreateUnitHPR(bp, army, position[1], position[2], position[3], 0, 0, 0)
    
    -- Set the health mutiplier
    --- this is 5 times as setveterancy(5) does not work
    unit:SetVeterancy(0)
    -- unit:SetVeterancy(1)
    -- unit:SetVeterancy(1)
    -- unit:SetVeterancy(1)
    -- unit:SetVeterancy(1)
     unit:SetMaxHealth(unit:GetMaxHealth() * ScenarioInfo.Options.opt_Survival_HealthMultiplier)
     unit:SetHealth(unit,unit:GetMaxHealth())
               -- Set the damadge multiplier
               for i = 1, unit:GetWeaponCount() do
                local Weapon = unit:GetWeapon(i)
                --if Weapon.Label ~= 'DeathWeapon' and Weapon.Label ~= 'DeathImpact' then
                    Weapon:AddDamageMod(Weapon:GetBlueprint().Damage * (ScenarioInfo.Options.opt_Survival_DamageMultiplier - 1))
                --end
            end
            
            --for i = 1, unit:GetWeaponCount() do
            --local Weapon = unit:GetWeapon(i)
            --Weapon:AddDamageMod(Weapon:GetBlueprint().Damage * ScenarioInfo.Options.opt_Survival_DamageMultiplier)
            --for i = 1, unit:GetWeapon(i) do
            --for i = 1, unit:GetWeaponCount() do
            --local Weapon = unit:GetWeapon(i)
            --Weapon:AddDamageMod(9999)
            
            --end


    
    table.insert(units, unit)
    --LOG("check1: " .. repr(units))
    end
    return units
    
    --CreateUnitHPR('UEB0101','ARMY_ENEMY',300,40,400,0,0,0)
    --local transports = { }
    --for k, bp in tblData.transports do 
    --    local unit = CreateUnitHPR(bp, army, position[1], position[2], position[3], 0, 0, 0)
    --    table.insert(transports, unit)
   -- end

end

--function SpawnArmyGroup()
 --   CreateUnitHPR('UEB0101','ARMY_ENEMY',300,40,400,0,0,0)
--end

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
local timeToUnlockTech = 480 -- in seconds

---- Starting tech lvl
local techIntegral = 1
local techIdentifiers = {
    -- land tech 1,2,3 group x
    "LT1G", "LT2G", "LT3G", "LT4G", "LEXP"
}

local techIdentifier = techIdentifiers[techIntegral]

function OnStart()

    local army = "ARMY_ENEMY"
    local scenario = ScenarioInfo.Env.Scenario 
    local tblNode = Scenario.Armies[army].Units

    techIdentifier = techIdentifiers[techIntegral]
 
    for k = 1, 30 do 
        -- construct the name of the unit group x
        local name = techIdentifier .. k 

        -- check if the group exists
        local group = ScenarioUtils.FindUnitGroup(name, tblNode)
        if group then 
            local units = ScenarioUtils.CreateArmyGroup(army, name, false, false)
            local bps = UnitsToBlueprintID(units)
                
            -- Create them for the group then After they have spawned kill them        
            for k, unit in units do 
                
                ---- CHeck if Wrecks is enabled or not
                if ScenarioInfo.Options.opt_Wrecks == 1 then
                    local bp = unit:GetBlueprint()
                    if (bp != nil) then
                    bp.Wreckage = nil
                    end 
                end

                    unit:Destroy()
            end

            table.insert(cachelandPlatoons, bps)
        end
    end
end

function OnTick()

    local army = "ARMY_ENEMY"
    local scenario = ScenarioInfo.Env.Scenario 
    local tblNode = Scenario.Armies[army].Units
    

    while true do 

        -- get current game time in seconds  
        local time = (GetGameTimeSeconds() - offset)  
        --local k = math.random(1,10)
        -- want to map time to integral value that represents tech
        if time > techIntegral * timeToUnlockTech then 

            -- make sure we stay within the size of techIdentifiers
            --techIdentifier = techIdentifiers[math.min(2, techIntegral)]
            
           
                if techIntegral >= 5 then
                    techIntegral = 5
                    --LOG"land tech is already maxed out: " .. techIntegral)
                else
                    techIntegral = techIntegral + 1
                    --LOG"Upgrading land tech to " .. techIntegral)
                end
             -- update the tech identifier
                techIdentifier = techIdentifiers[(techIntegral)]

            cachelandPlatoons = { }

            for k = 1, 30 do 
                -- construct the name of the unit group
                
                local name = techIdentifier .. k 
                --LOG"group name is" .. name)

                -- check if the group exists
                local group = ScenarioUtils.FindUnitGroup(name, tblNode)
                if group then 
                    local units = ScenarioUtils.CreateArmyGroup(army, name, false, false)
                    local bps = UnitsToBlueprintID(units)
                        
                    -- Create them for the group then After they have spawned kill them        
                    for k, unit in units do 
                        unit:Destroy()
                    end
        
                    table.insert(cachelandPlatoons, bps)
                end
            end

        end

        -- this needs to be in forkthread
        WaitSeconds(1)
    end
end
