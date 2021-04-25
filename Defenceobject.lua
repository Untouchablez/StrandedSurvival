--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')



function GametimegoalFunction()
    -- TOTAL Game Time (45 mins)
    local GameTimeLength = 2700
    --- Forumla to work out game time remainining (Including startup time) math.floor(x + 0.5) (to round up or down to the nearest whole)
    return math.floor((((GameTimeLength + ScenarioInfo.Options.opt_Survival_BuildTime) - GetGameTimeSeconds())/60) +0.5)
end

--Forkthread (UpdateGameTimeObjective) & Check for Win condition
function UpdateGameTimeObjective()
    while true do
        -- Set the game time timer (2400 = 40mins) and count down
        -- works Gametimegoal = math.floor((((GameTimeLength + ScenarioInfo.Options.opt_Survival_BuildTime) - GetGameTimeSeconds())/60))-1
        Gametimegoal = GametimegoalFunction()
        Survival_DefUnit:SetCustomName("Time " .. Gametimegoal .. " Minutes Remaining ")
        WaitSeconds(60)

        if (Gametimegoal == 0) then
			ScenarioFramework.Dialogue(import('/maps/X1CA_004/X1CA_004_strings.lua').X04_M03_210, nil, true) -- took care of business
            local text = 'center \r\n enter \r\n row3';
            local size = 25;
            local fade = 9;
    
            -- what other options are there?
            local alignment = 'center';
            -- what format should the color be in?
            local color = '00bfff';
            -- alignment
            local offset = "          "
                for k = 1, 7 do 
                    PrintText("", size + 10, color, fade, alignment);
                end
                -- print title
                PrintText(offset .. "The Black Sun has been protected", size + 10, color, fade, alignment);
                PrintText(offset .. " You Have Won Well Done!", size + 10, color, fade, alignment);
	
                for i, army in ListArmies() do
                    if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5" or army == "ARMY_6") then
                        GetArmyBrain(army):OnVictory()
                    end
			    end
			EndGame()
		end
    end
end

function OnStart()
--do
    ----LOG"----- Initializing defense object...");
    local POS = ScenarioUtils.MarkerToPosition("SURVIVAL_CENTER_1");
	Survival_DefUnit = CreateUnitHPR('UEC1901', "ARMY_ALLY", POS[1], POS[2], POS[3], 0,0,0);

	Survival_DefUnit:SetReclaimable(false);
	Survival_DefUnit:SetCapturable(false);
	--Survival_DefUnit:SetProductionPerSecondEnergy((Survival_PlayerCount * 100) + 0);
	Survival_DefUnit:SetConsumptionPerSecondEnergy(1);

	Survival_DefUnit:SetMaxHealth(205000);
	Survival_DefUnit:SetHealth(nil, 205000);
	Survival_DefUnit:SetRegenRate(200);
    

	local Survival_DefUnitBP = Survival_DefUnit:GetBlueprint();
	Survival_DefUnitBP.Intel.MaxVisionRadius = 100;
	Survival_DefUnitBP.Intel.MinVisionRadius = 100;
	Survival_DefUnitBP.Intel.VisionRadius = 100;

	Survival_DefUnit:SetIntelRadius('Vision', 100);

       	local ShieldSpecs = {
            ImpactEffects = 'SeraphimShieldHit01',
            ImpactMesh = '/effects/entities/ShieldSection01/ShieldSection01_mesh',
            Mesh = '/effects/entities/SeraphimShield01/SeraphimShield01_mesh',
            MeshZ = '/effects/entities/Shield01/Shield01z_mesh',
            RegenAssistMult = 60,
            ShieldEnergyDrainRechargeTime = 60,
            ShieldMaxHealth = 55000,
            ShieldRechargeTime = 60,
            ShieldRegenRate = 290,
            ShieldRegenStartTime = 1,
            ShieldSize = 90,
            ShieldVerticalOffset = -10,
        };

	Survival_DefUnit.OldOnKilled = Survival_DefUnit.OnKilled;

	Survival_DefUnit.OnKilled = function(self, instigator, type, overkillRatio)

		--BroadcastMSG("The Black Sun has been destroyed by the Aeon Illuminate!", 8);
		local text = 'center \r\n enter \r\n row3';
        local size = 25;
        local fade = 9;

        -- what other options are there?
        local alignment = 'center';

        -- what format should the color be in?
        local color = '00bfff';
        

        -- alignment
        local offset = "          "
        for k = 1, 7 do 
            PrintText("", size + 10, color, fade, alignment);
        end

        -- print title
        PrintText(offset .. "The Black Sun has been destroyed", size + 10, color, fade, alignment);
        PrintText(offset .. " You have failed us commander!", size + 10, color, fade, alignment);
				
		self.OldOnKilled(self, instigator, type, overkillRatio);

		Survival_GameState = 3; --defenders defeat

		for i, army in ListArmies() do

			if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5" or army == "ARMY_6" or army == "ARMY_7" or army == "ARMY_8") then
				--killAllCommanders(army);
				GetArmyBrain(army):OnDefeat();
			end
		end
	end

	Survival_DefLastHP = Survival_DefUnit:GetHealth();
    

end

