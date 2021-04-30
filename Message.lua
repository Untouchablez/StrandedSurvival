--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')
local Defenceobject = import("/maps/survival_stranded.v0020/Defenceobject.lua")
local MapVersion = import("/maps/survival_stranded.v0020/survival_stranded_scenario.lua")
  
do

    ForkThread(function ()

        WaitSeconds(12.0);

        local text = 'center \r\n enter \r\n row3';
        local size = 25;
        local fade = 9;

        -- what other options are there?
        local alignment = 'lefttop';

        -- what format should the color be in?
        local color = '00bfff';
        

        -- alignment
        local offset = "          "
        for k = 1, 7 do 
            PrintText("", size + 10, color, fade, alignment);
        end

         ---- testing
         Gametimegoal = Defenceobject.GametimegoalFunction()
         StartupTime = ScenarioInfo.Options.opt_Survival_BuildTime/60
         --Survival_DefUnit:SetCustomName("Time " .. Gametimegoal .. " Minutes Remaining ")
         PrintText(offset .. "Time " .. Gametimegoal .. " Minutes To Survive ", size + 10, color, fade, alignment);
         PrintText(offset .. offset .. "Build Time " .. StartupTime .. " Minutes ", size - 3, color, fade, alignment);
         PrintText(" ", size + 10, color, fade, alignment);

        -- print title
        PrintText(offset .. "Survival Stranded Version: " .. MapVersion.ScenarioInfo.map_version, size + 10, color, fade, alignment);
        PrintText(offset .. offset .. "Made By GaryTheGoat", size - 3, color, fade, alignment);
        PrintText(offset .. offset .. "Help from Jip/Jammer: Coding", size - 4, color, fade, alignment);
        PrintText(offset .. offset .. "WasserMelon: Making the map look pretty!", size - 4, color, fade, alignment);
        PrintText("", size + 10, color, fade, alignment);
        WaitSeconds(2.0)

        -- print graphics
        PrintText(offset .. " Recommended graphics ", size + 5, color, fade, alignment);
        PrintText(offset .. "     Fidelity: high ", size, color, fade, alignment);
        PrintText(offset .. "     Texture detail: high ", size, color, fade, alignment);
        PrintText(offset .. "     Bloom Render: on ", size, color, fade, alignment);
        
        WaitSeconds(10.0)

        -- alignment
        local offset = "          "
        for k = 1, 7 do 
            PrintText("", size + 10, color, fade, alignment);
        end

        PrintText(offset .. "Your Objective", size + 10, color, fade, alignment);
        PrintText(offset .. offset .. "Protect the Black Sun", size - 3, color, fade, alignment);
        PrintText(offset .. offset .. "at all costs", size - 3, color, fade, alignment);
        
        WaitSeconds(5)
               -- alignment
               local offset = "          "
               for k = 1, 3 do 
                   PrintText("", size + 10, color, fade, alignment);
               end
       
        
        
        --PrintText(offset .. "Time " .. tostring(Defenceobject.GametimegoalFunction()) .. " Minutes Remaining ", size + 10, color, fade, alignment);
        PrintText(offset ..  "   Hover over The Black Sun", size - 3, color, fade, alignment);
        PrintText(offset .. offset .. "to check the remaining game time", size - 3, color, fade, alignment);

    end);

end


