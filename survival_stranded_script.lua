local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

-- Addtional
local Areas = import("/maps/survival_stranded.v0018/Areas.lua")
local Markers = import("/maps/survival_stranded.v0018/Markers.lua")
local Platoons = import("/maps/survival_stranded.v0018/Platoons.lua")
local Drops = import("/maps/survival_stranded.v0018/Drops.lua")
local NavyPlatoons = import("/maps/survival_stranded.v0018/Navyplatoons.lua")
local Navyattack = import("/maps/survival_stranded.v0018/Navyattack.lua")
local LandPlatoons = import("/maps/survival_stranded.v0018/Landplatoons.lua")
local Landattack = import("/maps/survival_stranded.v0018/Landattack.lua")
local Defaultoptions = import("/maps/survival_stranded.v0018/Defaultoptions.lua")
local Defenceobject = import("/maps/survival_stranded.v0018/Defenceobject.lua")
--local EnemyAI = import("/maps/survival_stranded.v0018/EnemyAI.lua")
local allfactions = import("/maps/survival_stranded.v0018/Allfactions.lua")
local Gates = import("/maps/survival_stranded.v0018/Gates.lua")
local GatePlatoons = import("/maps/survival_stranded.v0018/Gateplatoons.lua")
local Wrecks = import("/maps/survival_stranded.v0018/Wrecks.lua")
local GameTime = import("/maps/survival_stranded.v0018/GameTime.lua")

function OnPopulate()
    ScenarioUtils.InitializeArmies()
    ScenarioInfo.CampaignMode = true
    Sync.CampaignMode = true
    import('/lua/sim/simuistate.lua').IsCampaign(true)
end

function OnStart(self)
    ScenarioInfo.Debug = false
    ----
    --ScenarioUtils.CreateArmyGroup("ARMY_1", "Sams", false, false)
	--ScenarioFramework.CreateTimerTrigger(function() Drops.OnStart() end , 30, false)
   -- TEST
   allfactions.OnStart()
   ----
 
    -- initialise everything
    Areas.OnStart()
	Markers.OnStart()
	
    --DropPlattoons
    Platoons.OnStart()
    --Drops.OnStart()
    ForkThread(Platoons.OnTick) 
    --Drops
    ForkThread(Drops.KeepThemDroppingThread)

    --Navyplatoons
    NavyPlatoons.OnStart()
    ForkThread(NavyPlatoons.OnTick)  
    -- Navyattack
    --Navyattack.OnStart()
    ForkThread(Navyattack.Spawntheunitsthread)
    
    --Land
    LandPlatoons.OnStart()
    ForkThread(LandPlatoons.OnTick)  
    --* Landattack.OnStart()
    ForkThread(Landattack.Spawntheunitsthread)




    -- Defence object timer / objective
    Defenceobject.OnStart()
    ForkThread(Defenceobject.UpdateGameTimeObjective)
    
    -- other scripts
	doscript("/maps/survival_stranded.v0018/PlayableArea.lua")
    doscript("/maps/survival_stranded.v0018/message.lua")
    doscript("/maps/survival_stranded.v0018/AIHelp.lua")
    doscript("/maps/survival_stranded.v0018/EnemyAI.lua")
    --doscript("/maps/survival_stranded.v0018/.lua")
    
    ---gameoptions
    Defaultoptions.OnStart()
 --- Update players on remaining time every 60 seconds
    ForkThread(GameTime.UpdateGameTimeObjective)

    ---Gateplatoons
    GatePlatoons.OnStart()
    ForkThread(GatePlatoons.OnTick)  
    -- Gates
    Gates.OnStart()
    ForkThread(Gates.Spawntheunitsthread)
    ForkThread(Gates.Spawntheunitsthread2)
    
	-- misc settings
	ScenarioInfo.Options.Victory = 'sandbox'	-- custom victory condition
	--Utilities.UserConRequest("ui_ForceLifbarsOnEnemy")	--show enemy life bars

	-- setup army specific things
	for i, army in ListArmies() do
		if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4"  or army == "ARMY_5"  or army == "ARMY_6") then
			-- restrict players from building walls
			ScenarioFramework.AddRestriction(army, categories.WALL)
            for x, ArmyX in ListArmies() do
                -- if human army
                if (ArmyX == "ARMY_1" or ArmyX == "ARMY_2" or ArmyX == "ARMY_3" or ArmyX == "ARMY_4" or army == "ARMY_5"  or army == "ARMY_6") then
                    SetAlliance(army, ArmyX, 'Ally')
                    SetAlliance(army, "ARMY_ENEMY", "Enemy")
                    SetAlliance(army, "ARMY_ALLY", "Ally")
                    SetAlliance("ARMY_ENEMY", "ARMY_ALLY", 'Enemy') 
			        SetAlliedVictory(army, true)
			    end
            end
        end    
    end
    
    -- set army colours
	SetArmyColor("ARMY_ENEMY", 128, 0, 0)
	SetArmyColor("ARMY_ALLY",128, 128, 128)
	-- spawnwaves don't have a unit cap
	SetIgnoreArmyUnitCap("ARMY_ENEMY", true)



       
end





	
