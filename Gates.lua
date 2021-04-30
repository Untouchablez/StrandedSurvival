local Markers = import("/maps/survival_stranded.v0020/Markers.lua")
local Utilities = import('/lua/utilities.lua')
local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Gateplatoons = import("/maps/survival_stranded.v0020/Gateplatoons.lua")
local Areas = import("/maps/survival_stranded.v0020/Areas.lua")
local UnitRevealer
local Defenceobject = import("/maps/survival_stranded.v0020/Defenceobject.lua")

function OnStart()   



		
		local r = Utilities.GetRandomInt(1,4)
		local gateFaction
        local armies = ListArmies();
        
        UnitRevealer = import('/maps/survival_stranded.v0020/UnitRevealer.lua').newInstance(armies)
        local players = { };
		
        if (r == 1) then
			gateFaction = 'UAB0304'
		elseif (r == 2) then
			gateFaction = 'URB0304'
		elseif (r == 3) then
			gateFaction = 'UEB0304'
		else
			gateFaction = 'XSB0304'
		end
		
        local pos = ScenarioUtils.MarkerToPosition("gate-1")
        --spawn gate 1
        EnemyGate1 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate1:SetMaxHealth(110000)
		EnemyGate1:SetHealth(nil,110000)
		EnemyGate1:SetReclaimable(false)
		EnemyGate1:SetCapturable(false)
		EnemyGate1:SetProductionPerSecondEnergy(9999)
		EnemyGate1:SetProductionPerSecondMass(9999)
		EnemyGate1:SetCustomName("Enemy Gate 1")

        local pos = ScenarioUtils.MarkerToPosition("gate-2")
        --spawn gate 2
        EnemyGate2 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate2:SetMaxHealth(110000)
		EnemyGate2:SetHealth(nil,110000)
		EnemyGate2:SetReclaimable(false)
		EnemyGate2:SetCapturable(false)
		EnemyGate2:SetProductionPerSecondEnergy(9999)
		EnemyGate2:SetProductionPerSecondMass(9999)
		EnemyGate2:SetCustomName("Enemy Gate 2")

        local pos = ScenarioUtils.MarkerToPosition("gate-3")
        --spawn gate 2
        EnemyGate3 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate3:SetMaxHealth(110000)
		EnemyGate3:SetHealth(nil,110000)
		EnemyGate3:SetReclaimable(false)
		EnemyGate3:SetCapturable(false)
		EnemyGate3:SetProductionPerSecondEnergy(9999)
		EnemyGate3:SetProductionPerSecondMass(9999)
		EnemyGate3:SetCustomName("Enemy Gate 3")

        local pos = ScenarioUtils.MarkerToPosition("gate-4")
        --spawn gate 2
        EnemyGate4 = CreateUnitHPR( gateFaction, "ARMY_ENEMY", pos[1], pos[2], pos[3], 0,0,0)
		EnemyGate4:SetMaxHealth(110000)
		EnemyGate4:SetHealth(nil,110000)
		EnemyGate4:SetReclaimable(false)
		EnemyGate4:SetCapturable(false)
		EnemyGate4:SetProductionPerSecondEnergy(9999)
		EnemyGate4:SetProductionPerSecondMass(9999)
		EnemyGate4:SetCustomName("Enemy Gate 4")
        --ScenarioFramework.CreateVisibleAreaAtUnit(visionRadius, unit, 0, GetArmyBrain(armyName))
        --ScenarioFramework.CreateVisibleAreaAtUnit(60, ScenarioInfo.ArnoldCDR, 0, ArmyBrains[Player1])
        --ScenarioFramework.CreateVisibleAreaAtUnit(60, EnemyGate1, 0, GetArmyBrain("ARMY_1"))
        
        --- make the gates visable to all human allied armys in the game
        for v, army in armies do
            if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4"  or army == "ARMY_5"  or army == "ARMY_6") then
                table.insert(players, army)
             end
        end
        for k, player in players do   
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate1, 0, GetArmyBrain(player))
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate2, 0, GetArmyBrain(player))
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate3, 0, GetArmyBrain(player))
        ScenarioFramework.CreateVisibleAreaAtUnit(15, EnemyGate4, 0, GetArmyBrain(player))
        end



          -- maximum number of group spawns
    --local maximum = 1000
    --local thread = ForkThread(Spawntheunitsthread, maximum)
    --local thread2 = ForkThread(Spawntheunitsthread2, maximum)
end




function Spawntheunitsthread()

    -- wait time before Land starts to spawn default 35 + )
    local seconds = 10 + ScenarioInfo.Options.opt_Survival_BuildTime
 
    --- seconds before Land starts to attack
    WaitSeconds (seconds)
    while true do
        -- Warn of incomming Land attacks
        --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) 
   
        -- get number of human armies
        --local armies = ListArmies()
        --local playerCount = table.getn(armies) - 1

        --local count = 0
       -- while count < maximum do
        
            --- adjust number of units dependant on players in game
        --if  playerCount == 1 then
        --   WaitSeconds (ScenarioInfo.Options.opt_Survival_GateSpawnInterval * 2)
        --end

        -- seconds in between each Land group spawn  
        WaitSeconds (ScenarioInfo.Options.opt_Survival_GateSpawnInterval) 
       -- count = count + 1
       
        --if count > maximum then
       --     break
        if EnemyGate1.Dead and EnemyGate2.Dead then
            WaitSeconds (5)
            ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT33, nil, true) --Sera Taunt4

            local area = Areas.PickRandomArea(Areas.spawnLandArea)
            local spawn = Areas.PickRandomPointInArea(area)
            local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
            local army = "ARMY_ENEMY"
            local rand = Utilities.GetRandomInt(1,4)
                if (rand == 1) then
                    ENEMYBOSS = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                    
                    elseif (rand == 2) then
                    ENEMYBOSS = CreateUnitHPR('xsl0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                    
                    elseif (rand == 3) then
                    ENEMYBOSS = CreateUnitHPR('xrl0403',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                    
                    elseif (rand == 4) then
                    ENEMYBOSS = CreateUnitHPR('uel0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                    
                end
             ENEMYBOSS:CreateShield({
                ImpactEffects = 'SeraphimShieldHit01',
                ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
                Mesh = '/effects/entities/AeonShield01/AeonShield01_mesh',
                MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
                RegenAssistMult = 60,
                ShieldEnergyDrainRechargeTime = 5,
                ShieldMaxHealth = 18000,
                ShieldRechargeTime = 24,
                ShieldRegenRate = 150,
                ShieldRegenStartTime = 3,
                ShieldSize = 35,
                ShieldVerticalOffset = -5,
                })
         

                ENEMYBOSS:SetProductionPerSecondEnergy(1000)
                ENEMYBOSS:SetConsumptionPerSecondEnergy(0)
                ENEMYBOSS:SetRegenRate(100)
                ENEMYBOSS:SetCustomName("JammerZoid V1")
                
                ENEMYBOSS:SetMaxHealth((400000) * ScenarioInfo.Options.opt_Survival_HealthMultiplier)
                ENEMYBOSS:SetHealth(ENEMYBOSS,ENEMYBOSS:GetMaxHealth())
                IssueAggressiveMove({ENEMYBOSS}, Markers.PickRandomPosition(Markers.dropAttackMarkers))
                ---- Reveal the Boss to all players
                UnitRevealer.revealUnit(ENEMYBOSS, 42)                        

            break
        end

       -- if unit.Dead then
       --     break
       --   end

       
        local r = Utilities.GetRandomInt(1,2)
        if (r == 1) then
		    if EnemyGate1.Dead then
                spawn = ScenarioUtils.MarkerToPosition("gate-2")
             else
                spawn = ScenarioUtils.MarkerToPosition("gate-1")
            end
	    elseif (r == 2) then
            if EnemyGate2.Dead then
                spawn = ScenarioUtils.MarkerToPosition("gate-1")
             else
		        spawn = ScenarioUtils.MarkerToPosition("gate-2")
            end
        end    

        


        local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
        -- identify the AI 
        local army = "ARMY_ENEMY"
        -- Call Landplatoons lua and pick a random army group
        local group = Gateplatoons.RandomArmyGroup()    
        local units = Gateplatoons.SpawnArmyGroup(group, army, spawn)
 
            -- Randomizer pick a random function - In this case a radmon attack move for groups of units and random path to tyarget. 
            function a()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then
                    if spawn == ScenarioUtils.MarkerToPosition("gate-1") then
                            
                        local rand2 = Utilities.GetRandomInt(1,2)
                        if (rand2 == 1) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand3")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                            elseif (rand2 == 2) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand4")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                        end
                        
                        elseif spawn == ScenarioUtils.MarkerToPosition("gate-2") then
                            
                        local rand3 = Utilities.GetRandomInt(1,2)
                        if (rand3 == 1) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand5")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                            elseif (rand3 == 2) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand6")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                        end    

                    end

                    position = ScenarioUtils.MarkerToPosition("attackpointrand1")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)

                    elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                    elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)    
                end
            end

            function b()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then

                    if spawn == ScenarioUtils.MarkerToPosition("gate-1") then
                            
                        local rand2 = Utilities.GetRandomInt(1,2)
                        if (rand2 == 1) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand3")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                            elseif (rand2 == 2) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand4")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                        end
                        
                        elseif spawn == ScenarioUtils.MarkerToPosition("gate-2") then
                            
                        local rand3 = Utilities.GetRandomInt(1,2)
                        if (rand3 == 1) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand5")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                            elseif (rand3 == 2) then
                            position = ScenarioUtils.MarkerToPosition("attackpointrand6")
                            IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                        end    
                          
                    end

                    position = ScenarioUtils.MarkerToPosition("attackpointrand2")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)
                end
                
            end

            function execute_random(f_tbl)
                local random_index = math.floor(Random() * table.getn(f_tbl)) + 1 --pick random index from 1 to #f_tbl
                f_tbl[random_index]() --execute function at the random_index we've picked
            end

            -- prepare/fill our function table 
            local funcs = {a, b}

            for i = 0, 20 do
                execute_random(funcs)
            end


            --- local formationTable = {
           -- 'AttackFormation',
           -- 'GrowthFormation',
           -- 'SixWideFormation',
           -- 'TravellingFormation',
           -- }

    end
---- break here
end

function Spawntheunitsthread2()

    -- wait time before Land starts to spawn default 35 + )
    local seconds = 10 + ScenarioInfo.Options.opt_Survival_BuildTime
 
    --- seconds before Land starts to attack
    WaitSeconds (seconds)
    while true do
    -- Warn of incomming Land attacks
    --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) 
   
        -- get number of human armies
        --local armies = ListArmies()
        --local playerCount = table.getn(armies) - 1

        --local count = 0
        --while count < maximum do
        
            --- adjust number of units dependant on players in game
        --if  playerCount == 1 then
        --   WaitSeconds (ScenarioInfo.Options.opt_Survival_GateSpawnInterval * 2)
        --end

        -- seconds in between each Land group spawn  ( Set manually as want to test will add in option later 15/04/2021) 
        WaitSeconds (20) 
       -- count = count + 1
       
        --if count > maximum then
        --    break
        if EnemyGate3.Dead and EnemyGate4.Dead then
        
            break
        end

          -- if unit.Dead then
          --     break
          --   end

            --function OnStart()
        local r = Utilities.GetRandomInt(1,2)
        if (r == 1) then
		    if EnemyGate3.Dead then
             spawn = ScenarioUtils.MarkerToPosition("gate-4")
             else
             spawn = ScenarioUtils.MarkerToPosition("gate-3")
            end
	        elseif (r == 2) then
            if EnemyGate4.Dead then
                spawn = ScenarioUtils.MarkerToPosition("gate-3")
                else
	    		spawn = ScenarioUtils.MarkerToPosition("gate-4")
            end
        end    

        local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
        -- identify the AI 
        local army = "ARMY_ENEMY"
        -- Call Landplatoons lua and pick a random army group
        local group = Gateplatoons.RandomArmyGroup()    
        local units = Gateplatoons.SpawnArmyGroup(group, army, spawn)
 
            -- Randomizer pick a random function - In this case a radmon attack more for groups of units. 
            function a()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then
                    position = ScenarioUtils.MarkerToPosition("attackpointrand1")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)    
                end
            end

            function b()
                local rand = Utilities.GetRandomInt(1,3)
                if (rand == 1) then
                    position = ScenarioUtils.MarkerToPosition("attackpointrand2")
                    IssueFormAggressiveMove(units, position, 'GrowthFormation', 0)
                elseif (rand == 2) then
                    IssueFormAggressiveMove(units, attack, 'GrowthFormation', 0)
                elseif (rand == 3) then
                    IssueFormMove(units, attack, 'AttackFormation', 0)
                end
                
            end

            function execute_random(f_tbl)
                local random_index = math.floor(Random() * table.getn(f_tbl)) + 1 --pick random index from 1 to #f_tbl
                f_tbl[random_index]() --execute function at the random_index we've picked
            end

            -- prepare/fill our function table
            local funcs = {a, b}

            for i = 0, 20 do
                execute_random(funcs)
            end


            --- local formationTable = {
           -- 'AttackFormation',
           -- 'GrowthFormation',
           -- 'SixWideFormation',
           -- 'TravellingFormation',
           -- }

    end
    ---- break here
end

function SpawnRandomBossThread()
    
    local JammerBoss1 = false
    local JammerBoss2 = false
    local JammerBoss3 = false
    --LOG"HI")
    while not (JammerBoss1 and JammerBoss2 and JammerBoss3) do 

        local gameTime = Defenceobject.GametimegoalFunction()
        --LOG"WHILE")
        --LOGrepr(gameTime))

        if not JammerBoss1 then 
            if gameTime == 30  then
 
                PrintText(" WARNING BOSS DETECTED AND IS INCOMMING ON YOUR POSITION ", 40, '00bfff', 9, 'center')
            
                ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_090, nil, true)
                local area = Areas.PickRandomArea(Areas.spawnLandArea)
                local spawn = Areas.PickRandomPointInArea(area)
                local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
                local army = "ARMY_ENEMY"
                local rand = Utilities.GetRandomInt(1,4)
                    if (rand == 1) then
                        ENEMYBOSS = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 2) then
                        ENEMYBOSS = CreateUnitHPR('xsl0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 3) then
                        ENEMYBOSS = CreateUnitHPR('xrl0403',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 4) then
                        ENEMYBOSS = CreateUnitHPR('uel0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                    end
                 ENEMYBOSS:CreateShield({
                    ImpactEffects = 'SeraphimShieldHit01',
                    ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
                    Mesh = '/effects/entities/AeonShield01/AeonShield01_mesh',
                    MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
                    RegenAssistMult = 60,
                    ShieldEnergyDrainRechargeTime = 5,
                    ShieldMaxHealth = 18000,
                    ShieldRechargeTime = 24,
                    ShieldRegenRate = 150,
                    ShieldRegenStartTime = 3,
                    ShieldSize = 35,
                    ShieldVerticalOffset = -5,
                    })
             
    
                    ENEMYBOSS:SetProductionPerSecondEnergy(1000)
                    ENEMYBOSS:SetConsumptionPerSecondEnergy(0)
                    ENEMYBOSS:SetRegenRate(100)
                    ENEMYBOSS:SetCustomName("JammerZoid V1")
                    
                    ENEMYBOSS:SetMaxHealth((300000) * ScenarioInfo.Options.opt_Survival_HealthMultiplier)
                    ENEMYBOSS:SetHealth(ENEMYBOSS,ENEMYBOSS:GetMaxHealth())
                    IssueAggressiveMove({ENEMYBOSS}, Markers.PickRandomPosition(Markers.dropAttackMarkers))
                    ---- Reveal the Boss to all players
                    UnitRevealer.revealUnit(ENEMYBOSS, 42)     
                JammerBoss1 = true
            end
        end

        if not JammerBoss2 then 
            if gameTime == 20 then

                PrintText(" WARNING BOSS DETECTED AND IS INCOMMING ON YOUR POSITION ", 40, '00bfff', 9, 'center')

                local area = Areas.PickRandomArea(Areas.spawnLandArea)
                local spawn = Areas.PickRandomPointInArea(area)
                local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
                local army = "ARMY_ENEMY"
                local rand = Utilities.GetRandomInt(1,4)
                    if (rand == 1) then
                        ENEMYBOSS = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 2) then
                        ENEMYBOSS = CreateUnitHPR('xsl0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 3) then
                        ENEMYBOSS = CreateUnitHPR('xrl0403',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 4) then
                        ENEMYBOSS = CreateUnitHPR('uel0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                    end
                 ENEMYBOSS:CreateShield({
                    ImpactEffects = 'SeraphimShieldHit01',
                    ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
                    Mesh = '/effects/entities/AeonShield01/AeonShield01_mesh',
                    MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
                    RegenAssistMult = 60,
                    ShieldEnergyDrainRechargeTime = 5,
                    ShieldMaxHealth = 40000,
                    ShieldRechargeTime = 24,
                    ShieldRegenRate = 150,
                    ShieldRegenStartTime = 3,
                    ShieldSize = 35,
                    ShieldVerticalOffset = -5,
                    })
             
    
                    ENEMYBOSS:SetProductionPerSecondEnergy(1000)
                    ENEMYBOSS:SetConsumptionPerSecondEnergy(0)
                    ENEMYBOSS:SetRegenRate(100)
                    ENEMYBOSS:SetCustomName("JammerZoid V2")
                    
                    ENEMYBOSS:SetMaxHealth((600000) * ScenarioInfo.Options.opt_Survival_HealthMultiplier)
                    ENEMYBOSS:SetHealth(ENEMYBOSS,ENEMYBOSS:GetMaxHealth())
                    IssueAggressiveMove({ENEMYBOSS}, Markers.PickRandomPosition(Markers.dropAttackMarkers))
                    ---- Reveal the Boss to all players
                    UnitRevealer.revealUnit(ENEMYBOSS, 42)     
                JammerBoss2 = true 
            end
        end

        if not JammerBoss3 then 
            if gameTime == 8 then

                PrintText(" WARNING BOSS DETECTED AND IS INCOMMING ON YOUR POSITION ", 40, '00bfff', 9, 'center')

                local area = Areas.PickRandomArea(Areas.spawnLandArea)
                local spawn = Areas.PickRandomPointInArea(area)
                local attack = Markers.PickRandomPosition(Markers.dropAttackMarkers)
                local army = "ARMY_ENEMY"
                local rand = Utilities.GetRandomInt(1,4)
                    if (rand == 1) then
                        ENEMYBOSS = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 2) then
                        ENEMYBOSS = CreateUnitHPR('xsl0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 3) then
                        ENEMYBOSS = CreateUnitHPR('xrl0403',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                        elseif (rand == 4) then
                        ENEMYBOSS = CreateUnitHPR('uel0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
                        
                    end
                 ENEMYBOSS:CreateShield({
                    ImpactEffects = 'SeraphimShieldHit01',
                    ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
                    Mesh = '/effects/entities/AeonShield01/AeonShield01_mesh',
                    MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
                    RegenAssistMult = 60,
                    ShieldEnergyDrainRechargeTime = 5,
                    ShieldMaxHealth = 100000,
                    ShieldRechargeTime = 24,
                    ShieldRegenRate = 150,
                    ShieldRegenStartTime = 3,
                    ShieldSize = 35,
                    ShieldVerticalOffset = -5,
                    })
             
    
                    ENEMYBOSS:SetProductionPerSecondEnergy(1000)
                    ENEMYBOSS:SetConsumptionPerSecondEnergy(0)
                    ENEMYBOSS:SetRegenRate(100)
                    ENEMYBOSS:SetCustomName("JammerZoid V3")
                    
                    ENEMYBOSS:SetMaxHealth((1000000) * ScenarioInfo.Options.opt_Survival_HealthMultiplier)
                    ENEMYBOSS:SetHealth(ENEMYBOSS,ENEMYBOSS:GetMaxHealth())
                    IssueAggressiveMove({ENEMYBOSS}, Markers.PickRandomPosition(Markers.dropAttackMarkers))
                    ---- Reveal the Boss to all players
                    UnitRevealer.revealUnit(ENEMYBOSS, 42)     
                JammerBoss3 = true
            end
        end

        WaitSeconds(10)
    end


    
end