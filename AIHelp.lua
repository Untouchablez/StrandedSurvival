--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Markers = import("/maps/survival_stranded.v0016/Markers.lua")
local Defenceobject = import("/maps/survival_stranded.v0016/Defenceobject.lua")

-- determine all the locations
local spawn = Markers.PickRandomPosition(Markers.spawnArmyallyMarkers)
local army = "ARMY_ALLY"
local position = Markers.PickRandomPosition(Markers.destArmyallyMarkers)

ForkThread(function ()

        -- 300 default
        WaitSeconds(300.0);

        local text = 'center \r\n enter \r\n row3';
        local size = 25;
        local fade = 9;
        -- what other options are there?
        local alignment = 'center';
        -- what format should the color be in?
        local color = '00bfff';
        local offset = "          "

        -- print title
        PrintText(offset .. "The Alliance have sent you their latest Prototype,", size, color, fade, alignment);
        PrintText(offset .. "     The Galactic Colossus V2 Use it wisely!  ", size, color, fade, alignment);
        --- Rhiza dialogue to introuduce the GC as reinforcement
        ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_M01_055, nil, true)        
        
        
        
        -- order the gc to patrol the area
        function PingCallback(units, location)
            -- forget all previous commands
            IssueClearCommands(units)
            IssueMove(units, location)
            --IssueFormMove({GC}, position, 'GrowthFormation', 0)
        end
                  
        -- Spawn the GC
        local GC = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
     
        -- Set the GC properties
        GC:CreateShield({
            ImpactEffects = 'AeonShieldHit01',
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
        --GC:EnableShield()
        --GC:ShieldIsOn()
        GC:SetProductionPerSecondEnergy(1000)
        GC:SetConsumptionPerSecondEnergy(0)
        GC:SetMaxHealth(100000)
        GC:SetHealth(nil, 100000)
        --GC:SetReclaimable(false)
        GC:SetRegenRate(100)
        --GC:SetCapturable(false)
        --GC:SetDoNotTarget(true)
        --GC:SetCanBeKilled(false)
         -- set gc name
        GC:SetCustomName("GaryTheGoat")
        --local weapon = unit:GetWeapon(i)
        --weapon:SetTargetingPriorities(preparedPrioTables[blueprintId][i])
        --GC:SetTargetPriorities(categories.NAVAL)
               
        -- allow the player to control the scout
        local PingGroups = import('/lua/SimPingGroup.lua')
        --- attack, alert, move
        local group = PingGroups.AddPingGroup('GaryTheGoat', 'ual0401', 'move', 'Order GarytheGoat to attack the located area.')
        -- add the click 
        group:AddCallback(function(location) PingCallback({GC}, location) end)
        -- issue move command
        IssueFormMove({GC}, position, 'GrowthFormation', 0)

        
        --ForkThread(GC)
        --local unit = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
        --CreateUnitHPR('ual0401',army, spawn, spawn, spawn, 0, 0, 0)
        --CreateUnitHPR(blueprint, army, x, y, z, pitch, yaw, roll)
        -- pick random destination to go to help destallyhelp 
        
       
        
        --function SpawnGC()
            --local POS = ScenarioUtils.MarkerToPosition("prop-1")
            --GC = CreateUnitHPR('UEB5103', "ARMY_SURVIVAL_ALLY", POS[1], POS[2], POS[3], 0, 0.785398,0)
            --local GC = CreateUnitHPR('ual0401',army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
        
            --GC:SetCustomName("HEX: 48 69 20 47 61 72 72 79")
         
        --end   
   






    end);


    ForkThread(function ()

        local AIHelp1 = false
        local AIHelp2 = false
        
        LOG("HI")
        while not (AIHelp1 and AIHelp2) do 

            local gameTime = Defenceobject.GametimegoalFunction()
            LOG("WHILE")
            LOG(repr(gameTime))

            if not AIHelp1 then 
                --26
                if gameTime == 26  then
                    LOG("AIHelp1")
                    local BS = CreateUnitHPR('UES0302',army, 370, 10, 1010, 0, 0, 0) --Battleship UEF
                    local SB = CreateUnitHPR('XES0205',army, 370, 10, 1010, 0, 0, 0) --Shield Boat UEF
                    local CB = CreateUnitHPR('UES0202',army, 370, 10, 1010, 0, 0, 0) --Cruiser Boat UEF
                    local SC = CreateUnitHPR('UES0201',army, 370, 10, 1010, 0, 0, 0) --Destroyer Boat UEF
                    
                    IssueMove({BS},ScenarioUtils.MarkerToPosition("NavyAIHelp1"))
                    IssuePatrol({SC},ScenarioUtils.MarkerToPosition("NavyAIHelp1"))
                    IssuePatrol({SB},ScenarioUtils.MarkerToPosition("NavyAIHelp1"))
                    IssuePatrol({CB},ScenarioUtils.MarkerToPosition("NavyAIHelp1"))
                    AIHelp1 = true
                end
            end
            if not AIHelp2 then 
                if gameTime == 26  then
                    LOG("AIHelp2")
                    local BS = CreateUnitHPR('URS0302',army, 650, 10, 1010, 0, 0, 0) --Battleship CYB
                    local DE = CreateUnitHPR('URS0201',army, 650, 10, 1010, 0, 0, 0) --Destro CYB
                    local CBC = CreateUnitHPR('URS0202',army, 650, 10, 1010, 0, 0, 0) --Cruiser Boat  CYB
                    IssueMove({BS},ScenarioUtils.MarkerToPosition("NavyAIHelp2"))
                    IssuePatrol({DE},ScenarioUtils.MarkerToPosition("NavyAIHelp2"))
                    IssuePatrol({CBC},ScenarioUtils.MarkerToPosition("NavyAIHelp2"))
                    AIHelp2 = true
                end
            end
            WaitSeconds(10)
        end
    
    end)
