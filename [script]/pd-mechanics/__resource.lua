resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

author 'Pural#0001 & Dimitar#2102'

description 'PD Mechanics'

version '1.0.2'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pl.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua'
}
lua54 'yes'