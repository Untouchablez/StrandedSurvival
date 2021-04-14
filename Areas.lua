--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

spawnNavyArea = { }
spawnLandArea = { }

function PickRandomArea(areas)
    local n = table.getn(areas)
    local i = math.floor(Random() * n) + 1
    return areas[i]
    
end

function PickRandomPointInArea(area)
    
    local diffx = area.x1 - area.x0
    local diffy = area.y1 - area.y0

    local rx = Random() * diffx
    local ry = Random() * diffy

    local x = area.x0 + rx 
    local z = area.y0 + ry
    local y = GetSurfaceHeight(x, z)
    

    return VECTOR3(x, y, z)
end

function OnStart()
-- get the navy spawn areas
    local areas = ScenarioInfo.Env.Scenario.Areas
   for k = 1, 10, 1 do 
        local name = "NavySpawn_" .. k 
            if areas[name] then 
            local area = areas[name]
           local rect = Rect(area.rectangle[1], area.rectangle[2], area.rectangle[3], area.rectangle[4])
            table.insert(spawnNavyArea, rect)
        end
    end

-- get the land spawn areas
    local areas = ScenarioInfo.Env.Scenario.Areas
    for k = 1, 10, 1 do 
        local name = "LandSpawn_" .. k 
            if areas[name] then 
         local area = areas[name]
           local rect = Rect(area.rectangle[1], area.rectangle[2], area.rectangle[3], area.rectangle[4])
           table.insert(spawnLandArea, rect)
        end
    end
end

