--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')


    function OnStart()
        if (ScenarioInfo.Options.opt_Survival_BuildTime == nil) then
            ScenarioInfo.Options.opt_Survival_BuildTime = 0
        end

        if (ScenarioInfo.Options.opt_Survival_NavySpawnInterval == nil) then
            ScenarioInfo.Options.opt_Survival_NavySpawnInterval = 4
        else     
            ScenarioInfo.Options.opt_Survival_NavySpawnInterval = tonumber(ScenarioInfo.Options.opt_Survival_NavySpawnInterval)
        end
        
        if (ScenarioInfo.Options.opt_Survival_DropSpawnInterval == nil) then
            ScenarioInfo.Options.opt_Survival_DropSpawnInterval = 3
        else
            ScenarioInfo.Options.opt_Survival_DropSpawnInterval = tonumber(ScenarioInfo.Options.opt_Survival_DropSpawnInterval)
        end

        if (ScenarioInfo.Options.opt_Survival_LandSpawnInterval == nil) then
            ScenarioInfo.Options.opt_Survival_LandSpawnInterval = 4
        else 
            ScenarioInfo.Options.opt_Survival_LandSpawnInterval = tonumber(ScenarioInfo.Options.opt_Survival_LandSpawnInterval)
        end

        if (ScenarioInfo.Options.opt_Survival_GateSpawnInterval == nil) then
            ScenarioInfo.Options.opt_Survival_GateSpawnInterval = 4
        else
            ScenarioInfo.Options.opt_Survival_GateSpawnInterval = tonumber(ScenarioInfo.Options.opt_Survival_GateSpawnInterval)
        end

        if (ScenarioInfo.Options.opt_Survival_HealthMultiplier == nil) then
            ScenarioInfo.Options.opt_Survival_HealthMultiplier = 1
        end

        if (ScenarioInfo.Options.opt_Survival_DamageMultiplier == nil) then
            ScenarioInfo.Options.opt_Survival_DamageMultiplier = 1
        end
        
        if (ScenarioInfo.Options.opt_SurvivalAllFactions == nil) then
            ScenarioInfo.Options.opt_SurvivalAllFactions = 0
        end

        if (ScenarioInfo.Options.opt_Wrecks == nil) then
            ScenarioInfo.Options.opt_Wrecks = 0
        end
        


    end


    
 
   

   
