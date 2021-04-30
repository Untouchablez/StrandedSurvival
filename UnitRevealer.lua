-- Can reveal units to the specified armies by granting those armies a visible area centered on the unit
function newInstance(armyNames)
    local ScenarioFramework = import('/lua/ScenarioFramework.lua')

    local function revealUnitToArmy(unit, armyName, visionRadius)
        local vizMarker = ScenarioFramework.CreateVisibleAreaAtUnit(visionRadius, unit, 0, GetArmyBrain(armyName))
        vizMarker:AttachBoneTo(-1, unit, -1)
        return vizMarker
    end

    local function destoryVizMarkersOnUnitKilled(unit, vizMarkers)
        local onKilledFunction = unit.OnKilled

        unit.OnKilled = function(self, instigator, type, overkillRatio)
            for _, vizMarker in vizMarkers do
                vizMarker:Destroy()
            end

            onKilledFunction(self, instigator, type, overkillRatio)
        end
    end

    local function revealUnitToPlayers(unit, visionRadius)
        local vizMarkers = {}

        for _, armyName in armyNames do
            table.insert(vizMarkers, revealUnitToArmy(unit, armyName, visionRadius))
        end

        destoryVizMarkersOnUnitKilled(unit, vizMarkers)
    end

    return {
        revealUnit = revealUnitToPlayers
    }
end