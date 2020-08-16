/spell/aoe_turf/mekbuild //Raaagh
	name = "Mek Build"
	abbreviation = "WG"
	desc = "Lets ya build shit on da go."
	panel = "Racial Abilities"
	spell_flags = INCLUDEUSER
	charge_type = Sp_RECHARGE
	charge_max = 10
	invocation_type = SpI_NONE
	still_recharging_msg = "<span class='notice'>You ain't ready yet idiot..</span>"
	
	override_base = "basic_button"
	override_icon = 'z40k_shit/icons/buttons/generic_action_buttons.dmi'
	hud_state = "mek_build"


	var/datum/button_crafting/MB
	var/list/crafting_recipes = list(
				new/datum/crafting_recipes/choppa,
				new/datum/crafting_recipes/slugga,
				new/datum/crafting_recipes/shield,
				new/datum/crafting_recipes/shotta,
				new/datum/crafting_recipes/shoota,
				new/datum/crafting_recipes/kustom_shoota,
				new/datum/crafting_recipes/scrapbullets,
				new/datum/crafting_recipes/buckshot,
				new/datum/crafting_recipes/ork_jumppack,
				new/datum/crafting_recipes/burnapack,
				new/datum/crafting_recipes/mekanical_shouta,
				new/datum/crafting_recipes/trophy_banner,
				new/datum/crafting_recipes/kustom_shoota_belt
				)
/* 
	Old List
	var/list/crafting_recipes = list(
				new/datum/crafting_recipes/choppa,
				new/datum/crafting_recipes/slugga,
				new/datum/crafting_recipes/shield,
				new/datum/crafting_recipes/shotta,
				new/datum/crafting_recipes/shoota,
				new/datum/crafting_recipes/kustom_shoota,
				new/datum/crafting_recipes/stikkbombs,
				new/datum/crafting_recipes/scrapbullets,
				new/datum/crafting_recipes/buckshot,
				new/datum/crafting_recipes/rokkits,
				new/datum/crafting_recipes/rokkitlauncha,
				new/datum/crafting_recipes/ork_jumppack,
				new/datum/crafting_recipes/burnapack,
				new/datum/crafting_recipes/mekanical_shouta
				)
*/

/spell/aoe_turf/mekbuild/New()
	..()
	MB = new /datum/button_crafting(recipes = crafting_recipes)

/spell/aoe_turf/mekbuild/Destroy()
	qdel(MB)
	MB = null
	..()

/spell/aoe_turf/mekbuild/cast(var/list/targets, mob/user)
	MB.use(user)

