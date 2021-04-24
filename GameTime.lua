local Defenceobject = import("/maps/survival_stranded.v0017/Defenceobject.lua")


function UpdateGameTimeObjective()
    while true do
        local text = 'center \r\n enter \r\n row3';
        local size = 15;
        local fade = 9;
        --possible locations = lefttop, leftcenter, leftbottom,  righttop, rightcenter, rightbottom, 
        --rightbottom, centertop, center, centerbottom
        local alignment = 'centertop';
        -- what format should the color be in?
        local color = '#000000';
        -- alignment
        local offset = "                                                                                                "
         Gametimegoal = Defenceobject.GametimegoalFunction()
         --Survival_DefUnit:SetCustomName("Time " .. Gametimegoal .. " Minutes Remaining ")
         PrintText(offset .. " Goal: " .. Gametimegoal .. " Minutes Left! ", size + 10, color, fade, alignment);
         WaitSeconds(60.0)
    end
end
