-- Ariel Camilo - Agosto 2023
local NPC           =   00000
local SCRIPT_ON     =   true

local i = { --> Los 10 primeros son el ícono y los nombres de clase para los GossipMenuAddItem.
{"|TInterface\\Icons\\inv_sword_27:33:33:-23|t",                "Guerrero"},
{"|TInterface\\Icons\\inv_hammer_01:33:33:-23|t",               "Paladín"},
{"|TInterface\\Icons\\inv_weapon_bow_07:33:33:-23|t",           "Cazador"},
{"|TInterface\\Icons\\inv_throwingknife_04:33:33:-23|t",        "Pícaro"},
{"|TInterface\\Icons\\inv_staff_30:33:33:-23|t",                "Sacerdote"}, 
{"|TInterface\\Icons\\spell_deathknight_classicon:33:33:-23|t", "Caballero de la Muerte"},
{"|TInterface\\Icons\\spell_nature_bloodlust:33:33:-23|t",      "Chamán"},
{"|TInterface\\Icons\\inv_staff_13:33:33:-23|t",                "Mago"},
{"|TInterface\\Icons\\spell_nature_faeriefire:33:33:-23|t",     "Brujo"},
{"|TInterface\\Icons\\inv_misc_monsterclaw_04:33:33:-23|t",     "Druida"},
--> De acá para abajo son solo íconos de los glifos sublimes y menores de cada clase.
{"inv_glyph_majorwarrior", "inv_glyph_minorwarrior"},           -- 11
{"inv_glyph_majorpaladin", "inv_glyph_minorpaladin"},           -- 12
{"inv_glyph_majorhunter", "inv_glyph_minorhunter"},             -- 13
{"inv_glyph_majorrogue", "inv_glyph_minorrogue"},               -- 14
{"inv_glyph_majorpriest", "inv_glyph_minorpriest"},             -- 15
{"inv_glyph_majordeathknight", "inv_glyph_minordeathknight"},   -- 16
{"inv_glyph_majorshaman", "inv_glyph_minorshaman"},             -- 17
{"inv_glyph_majormage", "inv_glyph_minormage"},                 -- 18
{"inv_glyph_majorwarlock", "inv_glyph_minorwarlock"},           -- 19
{"inv_glyph_majordruid", "inv_glyph_minordruid"}}               -- 20

local major = {--> ID de los glifos sublimes de todas las clases.
{43419,43415,45790,45792,45793,45794,45795,45797,43412,43421,43425,43432,43428,43416,43414,43426,43420,43431,43424,43422,43427,43429,43417,43430,43413,43423,43418},
{41101,41107,45741,41104,41099,41098,45745,45743,41108,41103,41105,41095,45742,41097,41106,45746,41092,41100,45747,43867,41094,41110,43868,43869,41109,45744,41096,41102},
{42897,42898,42899,42900,42901,42902,45625,42903,42904,45731,45733,42905,42906,42907,42908,42909,45732,42910,42911,45735,45734,42912,42913,42914,42915,42916,42917},
{42954,42955,42956,42957,45769,42958,42959,42960,42961,42962,45766,42963,42964,42965,42966,42967,45761,45762,45768,42968,42969,42970,45764,42972,42973,42974,45767,42971},
{42396,42397,45753,42398,42399,42400,45755,42401,45758,42402,42403,42404,42405,42406,45757,45760,45756,42408,42409,42410,42411,42412,42407,42414,42415,42416,42417},
{43533,43826,43536,43537,45799,43538,45804,43542,43541,43827,45805,43543,43534,45806,45800,43545,43546,43547,43548,43550,43825,43551,43552,43549,43553,45803,43554},
{41517,41518,45775,41526,41527,41552,45771,41529,41530,41531,41532,41547,41533,41534,45777,41524,41540,41535,41536,41537,41538,45772,45778,41539,45770,45776,41541,41542},
{45738,44955,42734,42735,42736,42737,45736,50045,42738,42740,42739,42741,42742,44684,42743,45740,42744,42745,42746,42747,42748,45737,42749,42750,45739,42751,42752,42753,42754},
{45781,42454,42455,42456,42457,45782,42458,42459,42460,45779,42461,42462,42463,42464,42465,42453,45785,45780,50077,42466,42467,42468,45783,42469,45789,42470,42471,42472,42473},
{45623,45601,48720,40924,44928,40896,40899,40914,40920,40908,40919,40915,40900,40897,45622,40923,45603,40903,50125,40909,40912,40913,40902,45604,40901,40921,40916,46372,40906,40922,45602}}

local minor = {--> ID de los glifos menores de todas las clases.
{43395,43396,43397,49084,43400,43398,43399},{43369,43365,43368,43366,43367,43340},{43351,43350,43354,43338,43356,43355},
{43379,43376,43377,43343,43378,43380},{43342,43371,43370,43373,43372,43374},{43535,43671,43539,43544,43672,43673},{43381,43725,43385,44923,43344,43386,43388},
{43339,44920,43357,43359,43360,43364,43361},{43392,43390,43393,43391,43394,43389},{43316,43334,43674,43335,43332,44922,43331}}

local soundID = {--> Sonidos de "Inventario lleno" por raza y género.
[1]={1875,1999}, [2]={2284,2341}, [4]={1581,1654}, [8]={2118,2229}, [16]={2054,2173},
[32]={2396,2397}, [64]={1708,1709}, [128]={1820,1930}, [512]={9549,9550}, [1024]={9465,9466}}

local function OnGossipHello(e, P, U) ---------------------------------------
    if SCRIPT_ON then
        P:GossipClearMenu()
        for icon = 1, 10 do
            P:GossipMenuAddItem(0, i[icon][1]..i[icon][2], icon, 100)
        end
        P:GossipSendMenu(1, U)
    end
end -------------------------------------------------------------------------

local function OnGossipClick(e, P, U, SEL, I)

    if I==10 then -- Sublimes
        P:GossipClearMenu()
        P:GossipMenuAddItem(0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:33:33:-23|tAtrás", SEL, 100)
        for j, itemID in ipairs(major[SEL]) do
            local sql = WorldDBQuery("SELECT `Name` FROM `item_template_locale` WHERE locale = 'esMX' AND `ID` = " .. itemID)
            local removedGlyphOf = (sql and sql:GetString(0)) or "" --> Operador ternario. Si el query devuelve, se captura el nombre.
            local outputString = removedGlyphOf:gsub("^Glifo de ", ""):gsub("^%l", string.upper) --> Eliminamos "Glifo de ", y hacemos mayúscula la primra letra.
            local txt = string.format("|TInterface\\Icons\\%s:33:33:-23|t%d: %s", i[SEL + 10][1], j, outputString)
            local str = string.format("|cffffffff%d: %s", j, GetItemLink(itemID, 7))
            P:GossipMenuAddItem(0, txt, SEL, itemID)
            P:SendBroadcastMessage(str)      
        end
        P:GossipSendMenu(1, U)
    end

    if I==11 then -- Menores  
        P:GossipClearMenu()
        P:GossipMenuAddItem(0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:33:33:-23|tAtrás", SEL, 100)
        for j, itemID in ipairs(minor[SEL]) do
            local sql = WorldDBQuery("SELECT `Name` FROM `item_template_locale` WHERE locale = 'esMX' AND `ID` = " .. itemID)
            local removedGlyphOf = (sql and sql:GetString(0)) or "" --> Operador ternario de nuevo.
            local outputString = removedGlyphOf:gsub("^Glifo de ", ""):gsub("^%l", string.upper) --> Eliminamos "Glifo de ", y hacemos mayúscula la primra letra.
            local txt = string.format("|TInterface\\Icons\\%s:33:33:-23|t%d: %s", i[SEL + 10][2], j, outputString)
            local str = string.format("|cffffffff%d: %s", j, GetItemLink(itemID, 7))
            P:GossipMenuAddItem(0, txt, SEL, itemID)
            P:SendBroadcastMessage(str)      
        end
        P:GossipSendMenu(1, U) 
    end

    if I>1000 then
        local majorGlyphFound, minorGlyphFound = false, false
	--> Definimos esto para retornar true si el glifo seleccionado fue encontrado. ¿Esto para qué? Abajo te digo.
        for glyph = 1, #major[SEL] do if I==major[SEL][glyph] then majorGlyphFound = true break end end
        for glyph = 1, #minor[SEL] do if I==minor[SEL][glyph] then minorGlyphFound = true break end end

	--> Para poder activar la posiblidad de clikear seguidamente y que no saque del menú en que se está.
        if P:AddItem(I) then
            if majorGlyphFound then OnGossipClick(e, P, U, SEL, 10) end
            if minorGlyphFound then OnGossipClick(e, P, U, SEL, 11) end
        else
            if majorGlyphFound then OnGossipClick(e, P, U, SEL, 10) end
            if minorGlyphFound then OnGossipClick(e, P, U, SEL, 11) end
            P:SendAreaTriggerMessage("¡Tienes el inventario lleno!")
            local gen = P:GetGender()==0 and 1 or 2 --> Otro operador ternario
            P:PlayDistanceSound(soundID[P:GetRaceMask()][gen], P) --> Sonido
        end
    end

    if I==100 then
        P:GossipClearMenu()     
        P:GossipMenuAddItem(0, "|TInterface\\Icons\\"..i[SEL+10][1]..":33:33:-23|tGlifos Sublimes", SEL, 10)
        P:GossipMenuAddItem(0, "|TInterface\\Icons\\"..i[SEL+10][2]..":33:33:-23|tGlifos Menores", SEL, 11)
        P:GossipMenuAddItem(0, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:33:33:-23|tAtrás", 0, 101)     
        P:GossipSendMenu(1, U)
    end

    if I==101 then OnGossipHello(e, P, U) end

end

RegisterCreatureGossipEvent(NPC, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC, 2, OnGossipClick)
