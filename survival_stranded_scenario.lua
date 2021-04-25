version = 3 -- Lua Version. Dont touch this
ScenarioInfo = {
    name = "Survival Stranded",
    description = "You and youir comrades have stumbled accross a key artifiact in enemy terriority, Your job is to keep the defence object alive untill key information is transmitted back to HQ and reinforcements arrive to help!  This information will help win the war do not let the alliance down!",
    preview = '',
    map_version = 19,
    type = 'skirmish',
    starts = true,
    size = {1024, 1024},
    reclaim = {754811.5, 7048.156},
    map = '/maps/survival_stranded.v0019/survival_stranded.scmap',
    save = '/maps/survival_stranded.v0019/survival_stranded_save.lua',
    script = '/maps/survival_stranded.v0019/survival_stranded_script.lua',
    norushradius = 40,
    Configurations = {
        ['standard'] = {
            teams = {
                {
                    name = 'FFA',
                    armies = {'ARMY_1', 'ARMY_2', 'ARMY_3', 'ARMY_4', 'ARMY_5', 'ARMY_6'}
                },
            },
            customprops = {
                ['ExtraArmies'] = STRING( 'ARMY_ENEMY ARMY_ALLY' ),
            },
        },
    },
}
