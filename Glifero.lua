-- Ariel Camilo - Marzo 2024
local npc_id = 00000 -- ID del NPC que correrá el Script
local icon_size, icon_position = 33, -22 --> Para cambiar el tamaño de los íconos utilizados.

local ic = function(icon)
    local iconString = ""
    if not icon then
        iconString = string.format("|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:%d:%d:%d|t", icon_size, icon_size, icon_position)
    else
        iconString = string.format("|TInterface\\Icons\\%s:%d:%d:%d|t", icon, icon_size, icon_size, icon_position)
    end
    return iconString
end

local icons_table = {
    { "inv_sword_27",                "Guerrero" },
    { "inv_hammer_01",               "Paladín" },
    { "inv_weapon_bow_07",           "Cazador" },
    { "inv_throwingknife_04",        "Pícaro" },
    { "inv_staff_30",                "Sacerdote" },
    { "spell_deathknight_classicon", "Caballero de la Muerte" },
    { "spell_nature_bloodlust",      "Chamán" },
    { "inv_staff_13",                "Mago" },
    { "spell_nature_faeriefire",     "Brujo" },
    { "inv_misc_monsterclaw_04",     "Druida" }
}

local icons_glyph = {
    { "inv_glyph_majorwarrior",     "inv_glyph_minorwarrior" },
    { "inv_glyph_majorpaladin",     "inv_glyph_minorpaladin" },
    { "inv_glyph_majorhunter",      "inv_glyph_minorhunter" },
    { "inv_glyph_majorrogue",       "inv_glyph_minorrogue" },
    { "inv_glyph_majorpriest",      "inv_glyph_minorpriest" },
    { "inv_glyph_majordeathknight", "inv_glyph_minordeathknight" },
    { "inv_glyph_majorshaman",      "inv_glyph_minorshaman" },
    { "inv_glyph_majormage",        "inv_glyph_minormage" },
    { "inv_glyph_majorwarlock",     "inv_glyph_minorwarlock" },
    { "inv_glyph_majordruid",       "inv_glyph_minordruid" }
}

local major = { --> ID de los glifos sublimes de todas las clases.
    { 43419, 43415, 45790, 45792, 45793, 45794, 45795, 45797, 43412, 43421, 43425, 43432, 43428, 43416, 43414, 43426, 43420, 43431, 43424, 43422, 43427, 43429, 43417, 43430, 43413, 43423, 43418 },
    { 41101, 41107, 45741, 41104, 41099, 41098, 45745, 45743, 41108, 41103, 41105, 41095, 45742, 41097, 41106, 45746, 41092, 41100, 45747, 43867, 41094, 41110, 43868, 43869, 41109, 45744, 41096, 41102 },
    { 42897, 42898, 42899, 42900, 42901, 42902, 45625, 42903, 42904, 45731, 45733, 42905, 42906, 42907, 42908, 42909, 45732, 42910, 42911, 45735, 45734, 42912, 42913, 42914, 42915, 42916, 42917 },
    { 42954, 42955, 42956, 42957, 45769, 42958, 42959, 42960, 42961, 42962, 45766, 42963, 42964, 42965, 42966, 42967, 45761, 45762, 45768, 42968, 42969, 42970, 45764, 42972, 42973, 42974, 45767, 42971 },
    { 42396, 42397, 45753, 42398, 42399, 42400, 45755, 42401, 45758, 42402, 42403, 42404, 42405, 42406, 45757, 45760, 45756, 42408, 42409, 42410, 42411, 42412, 42407, 42414, 42415, 42416, 42417 },
    { 43533, 43826, 43536, 43537, 45799, 43538, 45804, 43542, 43541, 43827, 45805, 43543, 43534, 45806, 45800, 43545, 43546, 43547, 43548, 43550, 43825, 43551, 43552, 43549, 43553, 45803, 43554 },
    { 41517, 41518, 45775, 41526, 41527, 41552, 45771, 41529, 41530, 41531, 41532, 41547, 41533, 41534, 45777, 41524, 41540, 41535, 41536, 41537, 41538, 45772, 45778, 41539, 45770, 45776, 41541, 41542 },
    { 45738, 44955, 42734, 42735, 42736, 42737, 45736, 50045, 42738, 42740, 42739, 42741, 42742, 44684, 42743, 45740, 42744, 42745, 42746, 42747, 42748, 45737, 42749, 42750, 45739, 42751, 42752, 42753, 42754 },
    { 45781, 42454, 42455, 42456, 42457, 45782, 42458, 42459, 42460, 45779, 42461, 42462, 42463, 42464, 42465, 42453, 45785, 45780, 50077, 42466, 42467, 42468, 45783, 42469, 45789, 42470, 42471, 42472, 42473 },
    { 45623, 45601, 48720, 40924, 44928, 40896, 40899, 40914, 40920, 40908, 40919, 40915, 40900, 40897, 45622, 40923, 45603, 40903, 50125, 40909, 40912, 40913, 40902, 45604, 40901, 40921, 40916, 46372, 40906, 40922, 45602 } }

local minor = { --> ID de los glifos menores de todas las clases.
    { 43395, 43396, 43397, 49084, 43400, 43398, 43399 },
    { 43369, 43365, 43368, 43366, 43367, 43340 },
    { 43351, 43350, 43354, 43338, 43356, 43355 },
    { 43379, 43376, 43377, 43343, 43378, 43380 },
    { 43342, 43371, 43370, 43373, 43372, 43374 },
    { 43535, 43671, 43539, 43544, 43672, 43673 },
    { 43381, 43725, 43385, 44923, 43344, 43386, 43388 },
    { 43339, 44920, 43357, 43359, 43360, 43364, 43361 },
    { 43392, 43390, 43393, 43391, 43394, 43389 },
    { 43316, 43334, 43674, 43335, 43332, 44922, 43331 }
}

local function OnGossipHello(e, P, U)
    P:GossipClearMenu()
    local spell_icon, class_name = '', ''
    for i = 1, 10 do
        spell_icon = icons_table[i][1]
        class_name = icons_table[i][2]
        P:GossipMenuAddItem(8, ic(spell_icon) .. class_name, i, 100)
    end
    P:GossipSendMenu(1, U)
end

local selection
local One_is_Major --> Para luego poder imprimir el icono cuando damos regresar en el bloque (I >= 1000)

local function OnGossipClick(e, P, U, SEL, I)
    if (I == 10) and (SEL ~= 0) then --> Sublimes
        P:GossipClearMenu()
        for key, glyph_id in ipairs(major[SEL]) do
            local sql = WorldDBQuery("SELECT `Name` FROM `item_template_locale` WHERE locale = 'esMX' AND `ID` = " .. glyph_id)
            local removedGlyphOf = (sql and sql:GetString(0)) or ""
            local outputString = removedGlyphOf:gsub("^Glifo de ", ""):gsub("^%l", string.upper)
            local major_str = icons_glyph[SEL][1]
            local txt = ic(major_str) .. key .. ". " .. outputString
            P:GossipMenuAddItem(8, txt, SEL, glyph_id)
        end
        P:GossipMenuAddItem(8, ic() .. "Atrás", SEL, 100)
        P:GossipSendMenu(1, U)
        One_is_Major = 1
    end

    if (I == 11) and (SEL ~= 0) then --> Menores
        P:GossipClearMenu()
        for key, glyph_id in ipairs(minor[SEL]) do
            local sql = WorldDBQuery("SELECT `Name` FROM `item_template_locale` WHERE locale = 'esMX' AND `ID` = " ..
            glyph_id)
            local removedGlyphOf = (sql and sql:GetString(0)) or ""
            local outputString = removedGlyphOf:gsub("^Glifo de ", ""):gsub("^%l", string.upper)
            local minor_str = icons_glyph[SEL][2]
            local txt = ic(minor_str) .. key .. ". " .. outputString
            P:GossipMenuAddItem(8, txt, SEL, glyph_id)
        end
        P:GossipMenuAddItem(8, ic() .. "Atrás", SEL, 100)
        P:GossipSendMenu(1, U)
        One_is_Major = 0 --> 0 = Es glifo menor
    end

    if (I == 100) then
        local glyph_major = icons_glyph[SEL][1]
        local glyph_minor = icons_glyph[SEL][2]
        P:GossipClearMenu()
        P:GossipMenuAddItem(8, ic(glyph_major) .. "Glifos Sublimes", SEL, 10)
        P:GossipMenuAddItem(8, ic(glyph_minor) .. "Glifos Menores", SEL, 11)
        P:GossipMenuAddItem(8, ic() .. "Atrás", 0, 101)
        P:GossipSendMenu(1, U)
    end

    if (SEL == 0) and (I == 101) then
        OnGossipHello(1, P, U)
    end

    if (I >= 1000) then --> Sublimes
        local item_link = GetItemLink(I, 7)
        local glyph_major = icons_glyph[SEL][1]
        P:GossipClearMenu()

        if (One_is_Major == 1) then
            P:GossipMenuAddItem(8, ic(glyph_major) .. "[|cff0000ffAceptar|r Glifo]", I, 666, false, "¿Aceptas " .. item_link .. "?")
            P:GossipMenuAddItem(8, ic(glyph_major) .. "[|cffff0000Rechazar|r Glifo]", I, 667)
        else
            P:GossipMenuAddItem(8, ic(glyph_minor) .. "[|cff0000ffAceptar|r Glifo]", I, 666, false, "¿Aceptas " .. item_link .. "?")
            P:GossipMenuAddItem(8, ic(glyph_minor) .. "[|cffff0000Rechazar|r Glifo]", I, 668)
        end

        P:SendBroadcastMessage("|cff00c8ffPrevisualiza el Glifo > |r" .. item_link)
        P:GossipSendMenu(1, U)
        selection = SEL
    end

    if (I == 666) then
        if (P:AddItem(SEL, 1)) then
        else
            P:SendBroadcastMessage("|cffff0000¡Inventario lleno!")
        end
        OnGossipClick(2, P, U, selection, 10)
    end

    if (I == 667) then
        OnGossipClick(2, P, U, selection, 10)
    end

    if (I == 668) then
        OnGossipClick(2, P, U, selection, 11)
    end
end
RegisterCreatureGossipEvent(npc_id, 1, OnGossipHello)
RegisterCreatureGossipEvent(npc_id, 2, OnGossipClick)
