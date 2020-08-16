//Here ends the end of the active path. We can do more with this but from this point on the danger going mad should be EXETREME.
/spell/slaanesh
	panel = "Slaanesh"
	abbreviation = "SLNSH"
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	invocation_type = SpI_NONE
	charge_type = Sp_RECHARGE
	spell_flags = null
	school = "evocation"
	range = 0
	//overlay_icon_state = "spell"
	hud_state = "slaanesh" //name of the icon used in generating the spell hud object ontop of the base
