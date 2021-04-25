--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Markers = import("/maps/survival_stranded.v0019/Markers.lua")
local Defenceobject = import("/maps/survival_stranded.v0019/Defenceobject.lua")

-- determine all the locations
local spawn = Markers.PickRandomPosition(Markers.destenemynuke)
local army = "ARMY_ENEMY"
local unit = 'ual0401'
local POS = ScenarioUtils.MarkerToPosition("SURVIVAL_CENTER_1");
--local Survival_NukeUnits = { };

-- time before 1st nuke on island
local seconds = 450 + ScenarioInfo.Options.opt_Survival_BuildTime
--450 
do
    -- PARAGON
    CreateUnitHPR('XAB1401', army, 300,20,120,0,0,0);
    --if (Survival_NukeUnits:IsDead() == false) then
    --    Survival_NukeUnits[GiveNukeSiloAmmo(2); -- give it 2 ammo
     --   IssueNuke({Survival_NukeUnits}, ScenarioUtils.MarkerToPosition("SURVIVAL_CENTER_1") );
        
    ---IssueNuke({unit}, POS)   
    
    
    ForkThread(
        function ()

            --LOG"HI");
          WaitSeconds(seconds);
        --ScenarioFramework.Dialogue(import('/maps/X1CA_003/X1CA_003_strings.lua').X03_M02_160, nil, true) -- ty champion pincess
	    --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M02_045, nil, true) -- Warn of incomming navy attacks
        --ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M03_290,nil,true) --large alien approaching commander, i see it hit that alien with everything you got!
       -- ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_170,nil,true) --her emy people princess rian burk seraphin are not savoiurs!
        --ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_171,nil,true) -- princess 
        --ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_172,nil,true) -- the order has betrayed you .... she wills acrificae everyone rise up! fight agaisnt those! rise and fight
        --ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_173,nil,true) -- the princess is alive i dont believe it 
        --ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_174,nil,true) -- you were told she was alive and you still turned ure back and now you will live
        --ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_175,nil,true) -- i was wrong so wrong forgivve me
        --ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU02_080,nil,true) -- we don't have all day
		--ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU03_040,nil,true) -- speed this up
		--ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU08_040,nil,true) -- i want that enemy base destroyed
		--ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU03_060,nil,true) -- good job but don't get cocky
		--ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU06_150,nil,true)-- maybe we'll make a Commander out of you yet
		--ScenarioFramework.Dialogue(import('/maps/X1CA_TUT/X1CA_TUT_strings.lua').X1T_TU08_030,nil,true) -- wipe out that enemy base	
		--ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M03_180,nil,true)-- you looking for a medal?
		--ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M01_105,nil,true)-- quit messing around
		--ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').X01_M01_106,nil,true)-- make yourself useful	
		--ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_070,nil,true)-- multiple attack waves incoming
		--ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_080,nil,true)-- another attack
		--ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_090,nil,true)-- enemy forces are converging
		--ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M02_100,nil,true)-- enemy assault inbound
		--ScenarioFramework.Dialogue(import('/maps/X1CA_002/X1CA_002_strings.lua').X02_M03_230,nil,true)-- bladder the size of a melon						
		--ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_017,nil,true)-- Elite Commander, come in
		--ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_040,nil,true)-- Do whatever it takes	
		--ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_M01_012,nil,true)-- get it in gear
		--ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_M03_140,nil,true)-- attack inbound on your position
		--ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_DB01_030,nil,true)-- commander? u there?
		--ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_M01_140,nil,true) -- commander?  you read me?
		--ScenarioFramework.Dialogue(import('/maps/X1CA_006/X1CA_006_strings.lua').X06_M02_013,nil,true) -- nut has cracked

        -- YOLONA
        
        nukelauncher = CreateUnitHPR( 'XSB2401', army, spawn[1], spawn[2], spawn[3], 0, 0, 0);
       
        --CreateUnitHPR(unit ,army, spawn[1], spawn[2], spawn[3], 0, 0, 0)
        --if (Survival_NukeUnits:IsDead() == false) then
        
        
        --end
        if nukelauncher then
            --unit:GiveNukeSiloAmmo(NumToBuild)
            --table.insert(Survival_NukeUnits.mukelauncher)
            --Survival_NukeUnits:GiveNukeSiloAmmo(1)
            nukelauncher:GiveNukeSiloAmmo(1)
        else
            error('*ERROR*Attempting to build nukes in a non-existent unit: '.. arg[arg['n']], 2)
        end

        --LOG"HI")
        WaitSeconds(5)
        ScenarioFramework.Dialogue(import('/maps/X1CA_001/X1CA_001_strings.lua').TAUNT33, nil, true) --Sera Taunt4
        WaitSeconds(1)
        IssueNuke({nukelauncher},ScenarioUtils.MarkerToPosition("enemynukeloc-1"));
        IssueNuke({nukelauncher},ScenarioUtils.MarkerToPosition("enemynukeloc-2"));
        WaitSeconds(5)
        -- get it in gear commander!
        ScenarioFramework.Dialogue(import('/maps/X1CA_005/X1CA_005_strings.lua').X05_M01_012,nil,true)


        -- want to check every second / minute

        local launchedNuke = false
        local spawnedScathis1 = false
        local spawnedScathis2 = false
        --LOG"HI")
        while not (launchedNuke and spawnedScathis1 and spawnedScathis2) do 

            local gameTime = Defenceobject.GametimegoalFunction()
            --LOG"WHILE")
            --LOGrepr(gameTime))

            if not launchedNuke then 
                if gameTime == 7  then
                    --LOG"nukes")
                    ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_090, nil, true)
                    for i = 1,20 do
                        
                        IssueNuke({nukelauncher},ScenarioUtils.MarkerToPosition("SURVIVAL_CENTER_1"))
                    end
                    launchedNuke = true
                end


            end

            if not spawnedScathis1 then 
                if gameTime == 5 then
                    --LOG"scathis1")
                    scathis = CreateUnitHPR("URL0401", army, 90,10,550,0,0,0);
                    IssueMove({scathis}, ScenarioUtils.MarkerToPosition("enemynukeloc-2"))
                    spawnedScathis1 = true 
                end
            end

            if not spawnedScathis2 then 
                if gameTime == 5 then
                    --LOG"scathis2")
                    scathis = CreateUnitHPR("URL0401", army, 960,10,550,0,0,0);
                    IssueMove({scathis}, ScenarioUtils.MarkerToPosition("enemynukeloc-1"))
                    spawnedScathis2 = true
                end
            end

            WaitSeconds(10)
        end

        -- ---- start launching nukes at 5 mins or less..
        -- while true do 
        --     

        -- end
        
        -- while true do    ---- send in the scathis 4 mins or less!

        -- end      
        
        -- while true do    

        -- end

    end)
end

