fx_version 'cerulean'
game 'gta5'

--  █████╗ ██╗    █████╗ ███╗   ██╗ ██████╗ 
-- ██╔══██╗██║██╗ ██╔══██╗████╗  ██║██╔═══██╗
-- ███████║██║██║ ███████║██╔██╗ ██║██║   ██║
-- ██╔══██║██║██║ ██╔══██║██║╚██╗██║██║   ██║
-- ██║  ██║██║██║ ██║  ██║██║ ╚████║╚██████╔╝
-- ╚═╝  ╚═╝╚═╝╚═╝ ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ 

author 'Aliano'
description 'Realistic poisoning mechanics and antidote in FiveM'
version '1.0'

repository 'https://github.com/alinmb/aliano_poison'

client_scripts {
    'client/utils.lua',
    'client/effects.lua',
    'client/main.lua'
}

server_script 'server/main.lua'

shared_script 'config.lua'

dependencies {
    'ox_inventory',
    'es_extended'
}