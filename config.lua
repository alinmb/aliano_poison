Config = {
    Effects = {
        damageInterval = 600000, -- Damage every 10 min
        damageAmount = 5,        -- 5HP lost
        blackoutChance = 0.5,       -- 50% chance of blackout
        blackoutInterval = 600000,   -- 10min cooldown between blackouts
        blackoutDuration = 20000,   -- 20sec on the floor
        walkStyle = "move_m@drunk@slightlydrunk", -- Drunken gait
        screenEffectStrength = 0.9   -- Visual effect intensity
    },
    Animations = {
        injectDict = 'anim@gangops@facility@servers@',
        injectAnim = 'hotwire',
        injectDuration = 2500,
        getUpAnim = {
            dict = "get_up@directional@movement@from_knees@action",
            anim = "getup_l_0"
            }
    },
    Keys = {
        use = 38,    -- E
        self = 73,   -- X
        cancel = 194 -- Back
    },
    -- IN FRENCH --
    Messages = {
                use_poison = "~INPUT_CONTEXT~ Empoisonner\n~INPUT_VEH_DUCK~ S'auto-empoisonner\n~INPUT_FRONTEND_RRIGHT~ Ranger",
                use_antidote = "~INPUT_CONTEXT~ Soigner\n~INPUT_VEH_DUCK~ S'auto-soigner\n~INPUT_FRONTEND_RRIGHT~ Ranger",
                poisoned = "~r~Quelqu'un vous a empoisonné!",
                cured = "~g~Antidote administré.",
                self_poisoned = "~r~Vous vous êtes empoisonné.",
                self_cured = "~g~Vous avez pris l'antidote.",
                cancel_poison = "~b~Vous rangez le poison.",
                cancel_antidote = "~b~Vous rangez l'antidote.",
                timeout_poison = "Poison rangé, solution instable, ne la gardez pas longtemps en main !",
                timeout_antidote = "Antidote rangé, solution instable, ne la gardez pas longtemps en main !",
                no_player = "~r~Aucun joueur en face de vous.",
                blackout_warning = "~o~Votre vision se trouble, trouvez l'antidote !",
                antidote_warning = "~p~Trouvez un antidote, votre vie est en danger !",
                blackout_alert = "~r~Vous perdez connaissance...",
                health_loss = "~r~Votre santé se dégrade. [-%dHP]"
                },
    -- IN ENGLISH --
                -- Messages = {
                --     use_poison = "~INPUT_CONTEXT~ Poison\n~INPUT_VEH_DUCK~ Poison yourself\n~INPUT_FRONTEND_RRIGHT~ Cancel",
                --     use_antidote = "~INPUT_CONTEXT~ Cure\n~INPUT_VEH_DUCK~ Cure yourself\n~INPUT_FRONTEND_RRIGHT~ Cancel",
                --     poisoned = "~r~Someone poisoned you!",
                --     cured = "~g~Antidote administered.",
                --     self_poisoned = "~r~You poisoned yourself.",
                --     self_cured = "~g~You took the antidote.",
                --     cancel_poison = "~b~You put away the poison.",
                --     cancel_antidote = "~b~You put away the antidote.",
                --     timeout_poison = "Poison put away - unstable solution, don't keep it in hand too long!",
                --     timeout_antidote = "Antidote put away - unstable solution, don't keep it in hand too long!",
                --     no_player = "~r~No player in front of you.",
                --     blackout_warning = "~o~Your vision is blurring, find the antidote!",
                --     antidote_warning = "~p~Find an antidote, your life is in danger!",
                --     blackout_alert = "~r~You're losing consciousness...",
                --     health_loss = "~r~Your health is deteriorating. [-%dHP]"
                -- },
}