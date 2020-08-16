///////////////////////////////////////SOUL BLADE////////////////////////////////////////////////

/obj/item/weapon/melee/soulblade
	name = "soul blade"
	desc = "An obsidian blade fitted with a soul gem, giving it soul catching propertiess."
	inhand_states = list("left_hand" = 'icons/mob/in-hand/left/swords_axes.dmi', "right_hand" = 'icons/mob/in-hand/right/swords_axes.dmi')
	icon = 'icons/obj/cult_64x64.dmi'
	pixel_x = -16 * PIXEL_MULTIPLIER
	pixel_y = -16 * PIXEL_MULTIPLIER
	icon_state = "soulblade"
	item_state = "soulblade"
	w_class = W_CLASS_LARGE
	force = 30//30 brute, plus 5 burn
	throwforce = 20
	sharpness = 1.35
	sharpness_flags = SHARP_TIP | SHARP_BLADE
	attack_verb = list("attacks", "slashes", "stabs", "slices", "tears", "rips", "dices", "cuts")
	hitsound = "sound/weapons/bladeslice.ogg"
	var/mob/living/simple_animal/shade/shade = null
	var/blood = 0
	var/maxregenblood = 8//the maximum amount of blood you can regen by waiting around.
	var/maxblood = 100
	var/movespeed = 2//smaller = faster
	health = 40
	var/maxHealth = 40

/obj/item/weapon/melee/soulblade/Destroy()
	var/turf/T = get_turf(src)
	if (istype(loc, /obj/item/projectile))
		qdel(loc)
	if (shade)
		shade.remove_blade_powers()
		if (T)
			shade.forceMove(T)
			shade.status_flags &= ~GODMODE
			shade.canmove = 1
			shade.cancel_camera()
			var/datum/control/C = shade.control_object[src]
			if(C)
				C.break_control()
				qdel(C)
		else
			qdel(shade)
	if (T) 
		var/obj/item/weapon/melee/cultblade/nocult/B = new (T)
		B.Move(get_step_rand(T))
		new /obj/item/device/soulstone(T)
	shade = null
	..()

/obj/item/weapon/melee/soulblade/examine(var/mob/user)
	..()
	if (iscultist(user))
		to_chat(user, "<span class='info'>blade blood: [blood]%</span>")
		to_chat(user, "<span class='info'>blade health: [round((health/maxHealth)*100)]%</span>")


/obj/item/weapon/melee/soulblade/cultify()
	return


/obj/item/weapon/melee/soulblade/attack_self(var/mob/user)
	var/choices = list(
		list("Give Blood", "radial_giveblood", "Transfer some of your blood to \the [src] to repair it and refuel its blood level, or you could just slash someone."),
		list("Remove Gem", "radial_removegem", "Remove the soul gem from the blade."),
		)

	if (!iscultist(user))
		choices = list(
			list("Remove Gem", "radial_removegem", "Remove the soul gem from \the [src]."),
			)

	var/task = show_radial_menu(user,user,choices,'icons/obj/cult_radial.dmi',"radial-cult")//spawning on loc so we aren't offset by pixel_x/pixel_y, or affected by animate()
	if (user.get_active_hand() != src)
		to_chat(user,"<span class='warning'>You must hold \the [src] in your active hand.</span>")
		return
	switch (task)
		if ("Give Blood")
			var/data = use_available_blood(user, 10)
			if (data[BLOODCOST_RESULT] != BLOODCOST_FAILURE)
				blood = min(maxblood,blood+20)//reminder that the blade cannot give blood back to their wielder, so this should prevent some exploits
				health = min(maxHealth,health+10)
		if ("Remove Gem")
			var/turf/T = get_turf(user)
			playsound(T, 'sound/items/Deconstruct.ogg', 50, 0, -3)
			user.drop_item(src,T)
			var/obj/item/weapon/melee/cultblade/CB = new (T)
			var/obj/item/device/soulstone/gem/SG = new (T)
			user.put_in_active_hand(CB)
			user.put_in_inactive_hand(SG)
			if (shade)
				shade.forceMove(SG)
				shade.remove_blade_powers()
				SG.icon_state = "soulstone2"
				SG.item_state = "shard-soulstone2"
				SG.name = "Soul Stone: [shade.real_name]"
				shade = null
			loc = null//so we won't drop a broken blade and shard
			qdel(src)


/obj/item/weapon/melee/soulblade/attack(var/mob/living/target, var/mob/living/carbon/human/user)
	if(!iscultist(user))
		user.Paralyse(5)
		to_chat(user, "<span class='warning'>An unexplicable force powerfully repels \the [src] from \the [target]!</span>")
		var/datum/organ/external/affecting = user.get_active_hand_organ()
		if(affecting && affecting.take_damage(rand(force/2, force))) //random amount of damage between half of the blade's force and the full force of the blade.
			user.UpdateDamageIcon()
		return
	if (ishuman(target) && target.resting)
		var/obj/structure/cult/altar/altar = locate() in target.loc
		if (altar)
			altar.attackby(src,user)
			return
	..()
	if (!shade && istype(target, /mob/living/carbon))
		transfer_soul("VICTIM", target, user,1)
		update_icon()

/obj/item/weapon/melee/soulblade/afterattack(var/atom/A, var/mob/living/user, var/proximity_flag, var/click_parameters)
	if(proximity_flag)
		return
	if (user.is_pacified(VIOLENCE_SILENT,A,src))
		return

	if (blood >= 5)
		blood = max(0,blood-5)
		var/turf/starting = get_turf(user)
		var/turf/target = get_turf(A)
		var/obj/item/projectile/bloodslash/BS = new (starting)
		BS.firer = user
		BS.original = A
		BS.target = target
		BS.current = starting
		BS.starting = starting
		BS.yo = target.y - starting.y
		BS.xo = target.x - starting.x
		user.delayNextAttack(4)
		if(user.zone_sel)
			BS.def_zone = user.zone_sel.selecting
		else
			BS.def_zone = LIMB_CHEST
		BS.OnFired()
		playsound(starting, 'sound/effects/forge.ogg', 100, 1)
		BS.process()

/obj/item/weapon/melee/soulblade/on_attack(var/atom/attacked, var/mob/user)
	..()
	if (ismob(attacked))
		var/mob/living/M = attacked
		M.take_organ_damage(0,5)
		playsound(loc, 'sound/weapons/welderattack.ogg', 50, 1)
		if (iscarbon(M))
			var/mob/living/carbon/C = M
			if (C.stat != DEAD)
				if (C.take_blood(null,10))
					blood = min(100,blood+10)
					to_chat(user, "<span class='warning'>You steal some of their blood!</span>")
			else
				if (C.take_blood(null,5))//same cost as spin, basically negates the cost, but doesn't let you farm corpses. It lets you make a mess out of them however.
					blood = min(100,blood+5)
					to_chat(user, "<span class='warning'>You steal a bit of their blood, but not much.</span>")

			if (shade && shade.hud_used && shade.gui_icons && shade.gui_icons.soulblade_bloodbar)
				var/matrix/MAT = matrix()
				MAT.Scale(1,blood/maxblood)
				var/total_offset = (60 + (100*(blood/maxblood))) * PIXEL_MULTIPLIER
				shade.hud_used.mymob.gui_icons.soulblade_bloodbar.transform = MAT
				shade.hud_used.mymob.gui_icons.soulblade_bloodbar.screen_loc = "WEST,CENTER-[8-round(total_offset/WORLD_ICON_SIZE)]:[total_offset%WORLD_ICON_SIZE]"
				shade.hud_used.mymob.gui_icons.soulblade_coverLEFT.maptext = "[blood]"


/obj/item/weapon/melee/soulblade/pickup(var/mob/living/user)
	if(!iscultist(user))
		to_chat(user, "<span class='warning'>An overwhelming feeling of dread comes over you as you pick up \the [src]. It would be wise to rid yourself of this, quickly.</span>")
		user.Dizzy(120)

/obj/item/weapon/melee/soulblade/dropped(var/mob/user)
	..()
	update_icon()

/obj/item/weapon/melee/soulblade/update_icon()
	overlays.len = 0
	animate(src, pixel_y = -16 * PIXEL_MULTIPLIER, time = 3, easing = SINE_EASING)
	shade = locate() in src
	if (shade)
		plane = HUD_PLANE//let's keep going and see where this takes us
		layer = ABOVE_HUD_LAYER
		item_state = "soulblade-full"
		icon_state = "soulblade-full"
		animate(src, pixel_y = -8 * PIXEL_MULTIPLIER, time = 7, loop = -1, easing = SINE_EASING)
		animate(pixel_y = -12 * PIXEL_MULTIPLIER, time = 7, loop = -1, easing = SINE_EASING)
	else
		if (!ismob(loc))
			plane = initial(plane)
			layer = initial(layer)
		item_state = "soulblade"
		icon_state = "soulblade"

	if (istype(loc,/mob/living/carbon))
		var/mob/living/carbon/C = loc
		C.update_inv_hands()


/obj/item/weapon/melee/soulblade/throw_at(var/atom/targ, var/range, var/speed, var/override = 1, var/fly_speed = 0)
	var/turf/starting = get_turf(src)
	var/turf/target = get_turf(targ)
	var/turf/second_target = target
	var/obj/item/projectile/soulbullet/SB = new (starting)
	SB.original = target
	SB.target = target
	SB.current = starting
	SB.starting = starting
	SB.secondary_target = second_target
	SB.yo = target.y - starting.y
	SB.xo = target.x - starting.x
	SB.shade = shade
	SB.blade = src
	src.forceMove(SB)
	SB.OnFired()
	SB.process()

/obj/item/weapon/melee/soulblade/ex_act(var/severity)
	switch(severity)
		if (1)
			takeDamage(100)
		if (2)
			takeDamage(40)
		if (3)
			takeDamage(20)

/obj/item/weapon/melee/soulblade/proc/takeDamage(var/damage)
	if (!damage)
		return
	health -= damage
	if (shade && shade.hud_used)
		shade.regular_hud_updates()
	if (health <= 0)
		playsound(loc, 'sound/effects/hit_on_shattered_glass.ogg', 70, 1)
		qdel(src)
	else
		playsound(loc, 'sound/items/trayhit1.ogg', 70, 1)

/obj/item/weapon/melee/soulblade/Cross(var/atom/movable/mover, var/turf/target, var/height=1.5, var/air_group = 0)
	if(istype(mover, /obj/item/projectile))
		if (prob(60))
			return 0
	return ..()

/obj/item/weapon/melee/soulblade/attackby(var/obj/item/I, var/mob/user)
	if(istype(I,/obj/item/weapon/talisman) || istype(I,/obj/item/weapon/paper))
		I.ashify_item(user)
		return 1
	user.delayNextAttack(8)
	if (user.is_pacified(VIOLENCE_DEFAULT,src))
		return
	if(I.force)
		var/damage = I.force
		if (I.damtype == HALLOSS)
			damage = 0
		takeDamage(damage)
		user.visible_message("<span class='danger'>\The [src] has been attacked with \the [I] by \the [user]. </span>")

/obj/item/weapon/melee/soulblade/hitby(var/atom/movable/AM)
	. = ..()
	if(.)
		return

	visible_message("<span class='warning'>\The [src] was hit by \the [AM].</span>", 1)
	if (isobj(AM))
		var/obj/O = AM
		takeDamage(O.throwforce)

/obj/item/weapon/melee/soulblade/bullet_act(var/obj/item/projectile/P)
	..()
	takeDamage(P.damage)