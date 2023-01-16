fx_version 'adamant'

game 'gta5'

dependencies {
    "PolyZone"
}

ui_page 'html/index.html'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/main.lua',
	'client/events.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
}

files {
	'html/index.html',
	'html/css/style.css',
	'html/js/script.js',
	'html/img/eye.png'
}


lua54 'yes'