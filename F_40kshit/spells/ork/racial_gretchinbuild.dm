/spell/aoe_turf/mekbuild/gretchin_build //Raaagh
	name = "Build"
	abbreviation = "WG"
	desc = "Lets ya build shit on da go."
	panel = "Racial Abilities"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	
	override_base = "basic_button"
	override_icon = 'F_40kshit/icons/buttons/generic_action_buttons.dmi'
	hud_state = "mek_build"

	crafting_recipes = list(
				new/datum/crafting_recipes/choppa,
				new/datum/crafting_recipes/slugga,
				new/datum/crafting_recipes/shotta,
				new/datum/crafting_recipes/shoota,
				new/datum/crafting_recipes/ork_slugga_mag,
				new/datum/crafting_recipes/ork_shotta_mag,
				new/datum/crafting_recipes/mekanical_shouta,
				new/datum/crafting_recipes/scrapbullets,
				new/datum/crafting_recipes/buckshot,
				new/datum/crafting_recipes/shield,
				new/datum/crafting_recipes/trophy_banner,
				new/datum/crafting_recipes/ork_slugga_mag,
				new/datum/crafting_recipes/stikkbombs,
				new/datum/crafting_recipes/flashlight,
				new/datum/crafting_recipes/ork_clothes
				)
