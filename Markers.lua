--- Made by GaryTheGoat --- 
--- Please do not amend / upload / copy any content without permission
--- feedback welcome samcaunt@hotmail.co.uk

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local ScenarioFramework = import('/lua/ScenarioFramework.lua')

-- lel, refactor
spawnNavyArea = { }

-- cache them
spawnTransportMarkers = { }
dropTransportMarkers = { }
dropAttackMarkers = { }
landspawnmarkers = { }
navyspawnmarkers = { }
spawnArmyallyMarkers = { }
destArmyallyMarkers = { }
destenemynavyMarkers = { }
destenemynuke = { }
gatespawn = { }

function PickRandomPosition(positions)
    local n = table.getn(positions)
    local i = math.floor(Random() * n) + 1
    return positions[i]
end

function OnStart()
    -- get the land spawn points
    local markers = ScenarioInfo.Env.Scenario.MasterChain._MASTERCHAIN_.Markers
    for k = 1, 20, 1 do 
        local name = "land-spawn-" .. k
        
        if markers[name] then 
            table.insert(landspawnmarkers, markers[name].position)
            ----LOG"LandSpawnMarkers" .. repr(markers[name]))
        end
    end

    -- get the drop points up to 20
    for k = 1, 20, 1 do 
        local name = "drop-transport-" .. k
        
        if markers[name] then 
            table.insert(dropTransportMarkers, markers[name].position)
           -- --LOG"droptransportmarkers" .. repr(markers[name]))
        end
    end

    -- get the attack points (todo: smarter)
    for k = 1, 20, 1 do 
        local name = "attack-point-" .. k
       
        if markers[name] then 
            table.insert(dropAttackMarkers, markers[name].position)
            ----LOG"attackpointmarkers" .. repr(markers[name]))
        end
    end
    
    -- spawn transports up to 30
    for k = 1, 30, 1 do 
        local name = "spawn-transport-" .. k
       
        if markers[name] then 
            table.insert(spawnTransportMarkers, markers[name].position)
           -- --LOG"spawntransportsmarkers" .. repr(markers[name]))
        end
    end

     -- get the navy spawn AREAS
    local areas = ScenarioInfo.Env.Scenario.Areas
    for k = 1, 20, 1 do 
        local name = "navy-spawn-" .. k
            if areas[name] then 
            local area = areas[name]
            local rect = Rect(area.rectangle[1], area.rectangle[2], area.rectangle[3], area.rectangle[4])
            table.insert(spawnNavyArea, rect)
            ----LOG"navySpawnMarkers" .. repr(markers[name]))
        end
    end   

    -- spawn ally help from allymarkers 
    for k = 1, 10, 1 do 
        local name = "allyarmyhelp-" .. k
       
        if markers[name] then 
            table.insert(spawnArmyallyMarkers, markers[name].position)
           
        end
    end

      -- destination to send ally help from allymarkers 
      for k = 1, 10, 1 do 
        local name = "allyarmydest-" .. k
       
        if markers[name] then 
            table.insert(destArmyallyMarkers, markers[name].position)
           
        end
    end

        -- destination to send enemy AI Navy 
        for k = 1, 10, 1 do 
            local name = "enemynavydest-" .. k
        
            if markers[name] then 
                table.insert(destenemynavyMarkers, markers[name].position)
            
        end
    end

        -- spawn locations of enemy nukes
        for k = 1, 10, 1 do 
            local name = "enemynuke-" .. k
        
            if markers[name] then 
                table.insert(destenemynuke, markers[name].position)
            
        end
    end 

            -- spawn locations of gates
            for k = 1, 10, 1 do 
                local name = "gate-" .. k
            
                if markers[name] then 
                    table.insert(gatespawn, markers[name].position)
                
            end
        end 

end

