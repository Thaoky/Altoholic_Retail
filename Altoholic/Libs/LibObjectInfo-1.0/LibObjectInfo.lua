--[[	*** LibObjectInfo ***
Written by : Thaoky, EU-Marécages de Zangar
August 22nd, 2021

This library contains various information about objects, like mining or herbalism nodes.

--]]

local LIB_VERSION_MAJOR, LIB_VERSION_MINOR = "LibObjectInfo-1.0", 1
local lib = LibStub:NewLibrary(LIB_VERSION_MAJOR, LIB_VERSION_MINOR)

if not lib then return end -- No upgrade needed

local L = DataStore:GetLocale("LibObjectInfo")

-- ["Object Name"] = item ID
local nodes = {
	-- *** Mining nodes ***
	-- ** Classic **
	[L["Copper Vein"]]                     	=  2770, -- Copper Ore
	[L["Dark Iron Deposit"]]               	= 11370, -- Dark Iron Ore
	[L["Gold Vein"]]                       	=  2776, -- Gold Ore
	[L["Hakkari Thorium Vein"]]            	= 10620, -- Thorium Ore
	[L["Iron Deposit"]]                    	=  2772, -- Iron Ore
	[L["Mithril Deposit"]]                 	=  3858, -- Mithril Ore
	[L["Ooze Covered Gold Vein"]]          	=  2776, -- Gold Ore
	[L["Ooze Covered Mithril Deposit"]]    	=  3858, -- Mithril Ore
	[L["Ooze Covered Rich Thorium Vein"]]  	= 10620, -- Thorium Ore
	[L["Ooze Covered Silver Vein"]]        	=  2775, -- Silver Ore
	[L["Ooze Covered Thorium Vein"]]       	= 10620, -- Thorium Ore
	[L["Ooze Covered Truesilver Deposit"]] 	=  7911, -- Truesilver Ore
	[L["Rich Thorium Vein"]]               	= 10620, -- Thorium Ore
	[L["Silver Vein"]]                     	=  2775, -- Silver Ore
	[L["Small Thorium Vein"]]              	= 10620, -- Thorium Ore
	[L["Tin Vein"]]                        	=  2771, -- Tin Ore
	[L["Truesilver Deposit"]]              	=  7911, -- Truesilver Ore

	[L["Lesser Bloodstone Deposit"]]       	=  4278, -- Lesser Bloodstone Ore
	[L["Incendicite Mineral Vein"]]        	=  3340, -- Incendicite Ore
	[L["Indurium Mineral Vein"]]           	=  5833, -- Indurium Ore
	[L["Large Obsidian Chunk"]]            	= 22203, -- Large Obsidian Shard. Both drop on both nodes.
	[L["Small Obsidian Chunk"]]            	= 22202, -- Small Obsidian Shard. Both drop on both nodes.
	
	-- ** Burning Crusade **
	[L["Adamantite Deposit"]]              	= 23425, -- Adamantite Ore
	[L["Fel Iron Deposit"]]                	= 23424, -- Fel Iron Ore
	[L["Khorium Vein"]]                    	= 23426, -- Khorium Ore
	[L["Nethercite Deposit"]]              	= 32464, -- Nethercite Ore
	[L["Rich Adamantite Deposit"]]         	= 23425, -- Adamantite Ore
	
	-- ** WotLK **
	[L["Cobalt Deposit"]]                     = 36909, -- Cobalt Ore
	[L["Rich Cobalt Deposit"]]                = 36909, -- Cobalt Ore
	[L["Saronite Deposit"]]                   = 36912, -- Saronite Ore
	[L["Rich Saronite Deposit"]]              = 36912, -- Saronite Ore
	[L["Titanium Vein"]]                      = 36910, -- Titanium Ore

	-- ** Cataclysm **
	[L["Obsidium Deposit"]]                   = 53038, -- Obsidium Ore
	[L["Rich Obsidium Deposit"]]              = 53038, -- Obsidium Ore
	[L["Elementium Vein"]]                    = 52185, -- Elementium Ore
	[L["Rich Elementium Vein"]]               = 52185, -- Elementium Ore
	[L["Pyrite Deposit"]]                     = 52183, -- Pyrite Ore
	[L["Rich Pyrite Deposit"]]                = 52183, -- Pyrite Ore

	-- ** Mists of Pandaria **
	[L["Ghost Iron Deposit"]]                 = 72092, -- Ghost Iron Ore
	[L["Rich Ghost Iron Deposit"]]            = 72092, -- Ghost Iron Ore
	[L["Kyparite Deposit"]]                   = 72093, -- Kyparite Ore
	[L["Rich Kyparite Deposit"]]              = 72093, -- Kyparite Ore
	[L["Trillium Vein"]]                      = 72095, -- Trillium Bar, because this node produces two ores
	[L["Rich Trillium Vein"]]                 = 72095, -- Trillium Bar, because this node produces two ores

	-- ** Warlords of Draenor **
	[L["Blackrock Deposit"]]                  = 109118, -- Blackrock Ore
	[L["Rich Blackrock Deposit"]]             = 109118, -- Blackrock Ore
	[L["True Iron Deposit"]]                  = 109119, -- True Iron Ore 
	[L["Rich True Iron Deposit"]]             = 109119, -- True Iron Ore
	[L["Smoldering True Iron Deposit"]]       = 109119, -- True Iron Ore

	-- ** Legion **
	[L["Leystone Deposit"]]                   = 123918, -- Leystone Ore
	[L["Leystone Seam"]]                      = 123918, -- Leystone Ore
	[L["Rich Leystone Deposit"]]              = 123918, -- Leystone Ore
	[L["Felslate Deposit"]]                   = 123919, -- Felslate
	[L["Felslate Seam"]]                      = 123919, -- Felslate
	[L["Rich Felslate Deposit"]]              = 123919, -- Felslate
	[L["Empyrium Deposit"]]                   = 151564, -- Empyrium
	[L["Empyrium Seam"]]                      = 151564, -- Empyrium
	[L["Rich Empyrium Deposit"]]              = 151564, -- Empyrium
	
	-- ** Battle for Azeroth **
	[L["Monelite Deposit"]]				   		= 152512, -- Monelite Ore
	[L["Rich Monelite Deposit"]]			   	= 152512, -- Monelite Ore
	[L["Monelite Seam"]]					   		= 152512, -- Monelite Ore
	[L["Storm Silver Deposit"]]			   	= 152579, -- Storm Silver Ore
	[L["Rich Storm Silver Deposit"]]		   	= 152579, -- Storm Silver Ore
	[L["Storm Silver Seam"]]				   	= 152579, -- Storm Silver Ore
	[L["Platinum Deposit"]]				   		= 152513, -- Platinum Ore
	[L["Rich Platinum Deposit"]]			   	= 152513, -- Platinum Ore
	[L["Osmenite Deposit"]]			   			= 168185, -- Osmenite Ore
	[L["Rich Osmenite Deposit"]]			   	= 168185, -- Osmenite Ore
	[L["Osmenite Seam"]]			   				= 168185, -- Osmenite Ore

	-- ** Shadowlands **
	[L["Laestrite Deposit"]] 						= 171828, -- Laestrite Ore
	[L["Rich Laestrite Deposit"]] 				= 171828, -- Laestrite Ore
	[L["Solenium Deposit"]] 						= 171829, -- Solenium Ore
	[L["Rich Solenium Deposit"]] 					= 171829, -- Solenium Ore
	[L["Oxxein Deposit"]] 							= 171830, -- Oxxein Ore
	[L["Rich Oxxein Deposit"]] 					= 171830, -- Oxxein Ore
	[L["Phaedrum Deposit"]] 						= 171831, -- Phaedrum Ore
	[L["Rich Phaedrum Deposit"]] 					= 171831, -- Phaedrum Ore
	[L["Sinvyr Deposit"]] 							= 171832, -- Sinvyr Ore
	[L["Rich Sinvyr Deposit"]] 					= 171832, -- Sinvyr Ore
	[L["Elethium Deposit"]] 						= 171833, -- Elethium Ore
	[L["Rich Elethium Deposit"]] 					= 171833, -- Elethium Ore
	[L["Ligneous Phaedrum Deposit"]] 			= 181718, -- Ligneous Phaedrum Ore
	[L["Monolithic Oxxein Deposit"]] 			= 181719, -- Monolithic Oxxein Ore
	[L["Menacing Sinvyr Deposit"]] 				= 181720, -- Menacing Sinvyr Ore
	[L["Luminous Solenium Deposit"]] 			= 181450, -- Luminous Solenium Ore
	
	
	-- *** Herbalism nodes ***
	-- ** Classic **
	[L["Arthas' Tears"]]        	=  8836,
	[L["Black Lotus"]]          	= 13468,
	[L["Blindweed"]]            	=  8839,
	[L["Bloodthistle"]]         	= 22710,
	[L["Briarthorn"]]           	=  2450,
	[L["Bruiseweed"]]           	=  2453,
	[L["Dreamfoil"]]            	= 13463,
	[L["Earthroot"]]            	=  2449,
	[L["Fadeleaf"]]             	=  3818,
	[L["Firebloom"]]            	=  4625,
	[L["Ghost Mushroom"]]       	=  8845,
	[L["Golden Sansam"]]        	= 13464,
	[L["Goldthorn"]]            	=  3821,
	[L["Grave Moss"]]           	=  3369,
	[L["Gromsblood"]]           	=  8846,
	[L["Icecap"]]               	= 13467,
	[L["Khadgar's Whisker"]]    	=  3358,
	[L["Kingsblood"]]           	=  3356,
	[L["Liferoot"]]             	=  3357,
	[L["Mageroyal"]]            	=   785,
	[L["Mountain Silversage"]]  	= 13465,
	[L["Peacebloom"]]           	=  2447,
	[L["Plaguebloom"]]          	= 13466,
	[L["Purple Lotus"]]         	=  8831,
	[L["Silverleaf"]]           	=   765,
	[L["Stranglekelp"]]         	=  3820,
	[L["Sungrass"]]             	=  8838,
	[L["Wild Steelbloom"]]      	=  3355,
	[L["Wintersbite"]]          	=  3819,

	-- ** Burning Crusade **
	[L["Ancient Lichen"]]       	= 22790,
	[L["Dreaming Glory"]]       	= 22786,
	[L["Felweed"]]              	= 22785,
	[L["Flame Cap"]]            	= 22788,
	[L["Glowcap"]]              	= 24245,
	[L["Mana Thistle"]]         	= 22793,
	[L["Netherbloom"]]          	= 22791,
	[L["Netherdust Bush"]]      	= 32468, -- Netherdust Pollen
	[L["Nightmare Vine"]]       	= 22792,
	[L["Ragveil"]]              	= 22787,
	[L["Sanguine Hibiscus"]]    	= 24246,
	[L["Terocone"]]             	= 22789,

	-- ** WotLK **
	[L["Goldclover"]]     			= 36901,
	[L["Adder's Tongue"]] 			= 36903,
	[L["Tiger Lily"]]     			= 36904,
	[L["Lichbloom"]]      			= 36905,
	[L["Icethorn"]]       			= 36906,
	[L["Talandra's Rose"]]			= 36907,
	[L["Frost Lotus"]]    			= 36908,
	[L["Firethorn"]]      			= 39970,

	-- ** Cataclysm **
	[L["Cinderbloom"]]      		= 52983,
	[L["Stormvine"]]        		= 52984,
	[L["Azshara's Veil"]]   		= 52985,
	[L["Heartblossom"]]     		= 52986,
	[L["Twilight Jasmine"]] 		= 52987,
	[L["Whiptail"]]         		= 52988,

	-- ** Mists of Pandaria **
	[L["Green Tea Leaf"]]         = 72234,
	[L["Silkweed"]]               = 72235,
	[L["Rain Poppy"]]             = 72237,
	[L["Snow Lily"]]              = 79010,
	[L["Fool's Cap"]]             = 79011,

	-- ** Warlords of Draenor **
	[L["Frostweed"]]              = 109124,
	[L["Fireweed"]]               = 109125,
	[L["Gorgrond Flytrap"]]       = 109126,
	[L["Starflower"]]             = 109127,
	[L["Nagrand Arrowbloom"]]     = 109128,
	[L["Talador Orchid"]]         = 109129,

	-- ** Legion **
	[L["Aethril"]]       			= 124101,
	[L["Astral Glory"]] 				= 151565,
	[L["Dreamleaf"]]     			= 124102,
	[L["Felwort"]]       			= 124106,
	[L["Foxflower"]]     			= 124103,
	[L["Fjarnskaggl"]]   			= 124104,
	[L["Starlight Rose"]]			= 124105,
	
	-- ** Battle for Azeroth **
	[L["Akunda's Bite"]]				= 152507,
	[L["Anchor Weed"]]  				= 152510,
	[L["Riverbud"]]     				= 152505,
	[L["Sea Stalks"]]   				= 152511,
	[L["Siren's Sting"]]				= 152509,
	[L["Star Moss"]]    				= 152506,
	[L["Winter's Kiss"]]				= 152508,
	[L["Zin'anthid"]]   				= 168487,
	
	-- ** Shadowlands **
	[L["Death Blossom"]]   			= 169701,
	[L["Marrowroot"]]   				= 168589,
	[L["Nightshade"]]   				= 171315,
	[L["Rising Glory"]]   			= 168586,
	[L["Vigil's Torch"]]   			= 170554,
	[L["Widowbloom"]]   				= 168583,
}

--	*** API ***

function lib:IsGatheringNode(name)
	-- returns the itemID if "name" is a known type of gathering node (mines & herbs), nil otherwise
	return nodes[name]
end
