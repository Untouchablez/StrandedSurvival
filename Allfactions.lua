local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local opt_SurvivalAllFactions = ScenarioInfo.Options.opt_SurvivalAllFactions

function OnStart(armies,players) 

        -- find all the players
       local armies = ListArmies();
       local players = { };
      
        for v, army in armies do
            if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4"  or army == "ARMY_5"  or army == "ARMY_6") then
               table.insert(players, army)
            end
        end

         ---------- SPAWNS ALL ACUS OR ENGINEERS
        for k, player in players do   
            if opt_SurvivalAllFactions == 2 then       
                     --  Check if option 1 or 2 is picked then
                    Brain = GetArmyBrain(player)
                    FactionID = GetArmyBrain(player):GetFactionIndex();    
                    local posX, posZ = Brain:GetArmyStartPos()
                    -- Acu identifiers
                    local CYB = "URL0001"
                    local SER = "XSL0001"
                    local AEO = "UAL0001"
                    local UEF = "UEL0001"
                
                if FactionID == 1 then -- Faction ID 1 UEF 
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                    elseif FactionID == 2 then -- Faction ID 2 Aeon
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    elseif FactionID == 3 then -- Faction ID 3 Cybran
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                    elseif FactionID == 4 then -- Faction ID 4 Sera
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                end
                       
            elseif opt_SurvivalAllFactions == 1 then
                    Brain = GetArmyBrain(player)    
                    FactionID = GetArmyBrain(player):GetFactionIndex(); 
                    local posX, posZ = Brain:GetArmyStartPos()
                    --- Engineer identifiers
                    local UEF = "UEL0105"
                    local CYB = "URL0105"
                    local SER = "XSL0105"
                    local AEO = "UAL0105"

                if FactionID == 1 then -- Faction ID 1 UEF 
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                    elseif FactionID == 2 then -- Faction ID 2 Aeon
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    elseif FactionID == 3 then -- Faction ID 3 Cybran
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(SER, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                    elseif FactionID == 4 then -- Faction ID 4 Sera
                    Brain:CreateUnitNearSpot(UEF, posX, posZ)
                    Brain:CreateUnitNearSpot(CYB, posX, posZ)
                    Brain:CreateUnitNearSpot(AEO, posX, posZ)
                end
            end           
        end
end


