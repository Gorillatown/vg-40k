//See: _defines.dm, basically this is the starting screen location for it.
#define ui_generic_master "EAST-0:-4,NORTH-2:-6" //Used as compile time value

//Icons are actually held in icons/mob/screen_spells.dmi
//Edit we are now overriding shit cause why not.
/obj/abstract/screen/movable/spell_master/ork_racial
	name = "Ork Racial Abilities"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "ork_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "genetics_open"
	closed_state = "genetics_closed"

	screen_loc = ui_generic_master

/*
	Chaos Spell_masters
*/
/obj/abstract/screen/movable/spell_master/slaanesh
	name = "Slaanesh"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "cult_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "slaanesh"
	closed_state = "slaanesh"

	screen_loc = ui_generic_master
//z40k_shit/icons/buttons/warpmagic.dmi

/*
	Harlequin Spellmaster
*/
/obj/abstract/screen/movable/spell_master/harlequin
	name = "Harlequin"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "ork_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "harlequin"
	closed_state = "harlequin"

	screen_loc = ui_generic_master

/*
	Basic Spell Masters
*/
/obj/abstract/screen/movable/spell_master/biomancy
	name = "Biomancy"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "ork_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "biomancy"
	closed_state = "biomancy"

	screen_loc = ui_generic_master

/obj/abstract/screen/movable/spell_master/pyromancy
	name = "Pyromancy"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "cult_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "pyromancy"
	closed_state = "pyromancy"

	screen_loc = ui_generic_master

/obj/abstract/screen/movable/spell_master/telekinesis
	name = "Telekinesis"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "ork_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "telekinesis"
	closed_state = "telekinesis"

	screen_loc = ui_generic_master

/obj/abstract/screen/movable/spell_master/telepathy
	name = "Telepathy"
	icon = 'z40k_shit/icons/buttons/spellmaster.dmi'
	icon_state = "cult_spell_ready"
	//override_icon = 'z40k_shit/icons/buttons/spellmaster.dmi'

	open_state = "telepathy"
	closed_state = "telepathy"

	screen_loc = ui_generic_master

