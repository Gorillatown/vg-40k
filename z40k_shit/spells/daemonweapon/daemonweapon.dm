/spell/daemonweapon
	panel = "Cult"
	override_base = "cult"
	user_type = USER_TYPE_CULT
	var/blood_cost = 0
	var/soul_requirement = 0

/spell/daemonweapon/cast_check(skipcharge = 0,mob/user = usr)
	var/obj/item/weapon/daemonweapon/blissrazor/SB = user.loc
	if (SB.blood < blood_cost)
		to_chat(user, "<span class='danger'>You don't have enough blood left for this move.</span>")
		return 0
	if(SB.soul_count < soul_requirement)
		to_chat(user, "<span class='danger'>You don't have enough captured souls to do this.</span>")
		return 0
	return ..()

/spell/daemonweapon/after_cast(list/targets)
	..()
	var/obj/item/weapon/daemonweapon/blissrazor/SB = holder.loc
	SB.blood = max(0,SB.blood-blood_cost)
	var/mob/shade = holder
	var/matrix/M = matrix()
	M.Scale(1,SB.blood/SB.maxblood)
	var/total_offset = (60 + (100*(SB.blood/SB.maxblood))) * PIXEL_MULTIPLIER
	shade.hud_used.mymob.gui_icons.soulblade_bloodbar.transform = M
	shade.hud_used.mymob.gui_icons.soulblade_bloodbar.screen_loc = "WEST,CENTER-[8-round(total_offset/WORLD_ICON_SIZE)]:[total_offset%WORLD_ICON_SIZE]"
	shade.hud_used.mymob.gui_icons.soulblade_coverLEFT.maptext = "[SB.blood]"