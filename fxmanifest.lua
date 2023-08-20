fx_version 'cerulean'
game 'gta5'

author 'Core Version & Ruby'
description 'ruby-robparking'

lua54 "yes"




shared_scripts {
    "config.lua",
    --"@ox_lib/init.lua", -- comment this out for regular qb no ox lib
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}
   

