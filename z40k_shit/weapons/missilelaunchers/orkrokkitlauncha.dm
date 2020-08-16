/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha
	name = "rokkit launcha"
	desc = "Ranged explosions, science marches on."
	fire_sound = 'z40k_shit/sounds/RokkitLauncha1.ogg'
	icon = 'z40k_shit/icons/obj/orks/orkequipment.dmi'
	icon_state = "rokkit_launcha"
	item_state = "rokkit_launcha"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64rokkit_launcha_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64rokkit_launcha_right.dmi')
	max_shells = 1
	w_class = W_CLASS_LARGE
	starting_materials = list(MAT_IRON = 5000)
	w_type = RECYK_METAL
	force = 20
	recoil = 1 //The backblast isn't just decorative you know
	throw_speed = 4
	throw_range = 3
	fire_delay = 5
	species_fit = list("Ork")
	flags = TWOHANDABLE
	siemens_coefficient = 1
	slot_flags = SLOT_BACK
	caliber = list(ORKROKKIT = 1)
	origin_tech = Tc_COMBAT + "=4;" + Tc_MATERIALS + "=2;" + Tc_SYNDICATE + "=2"
	ammo_type = "/obj/item/ammo_casing/rocket_rpg/rokkit"
	attack_verb = list("strikes", "hits", "bashes")
	gun_flags = 0
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance)
	var/ork_held = FALSE //Are we being held by a ork or a puny human.

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/isHandgun()
	return FALSE

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/prepickup(mob/user)
	if(isork(user))
		ork_held = TRUE
		if(flags & MUSTTWOHAND)
			flags &= ~MUSTTWOHAND
		if(!slot_flags & SLOT_BACK)
			slot_flags |= SLOT_BACK
		update_icon()
	else //bitch ass puny humans grabbin our rokkitlauncha
		ork_held = FALSE
		to_chat(user, "<span class='warning'> This feels a bit heavy. </span>")
		flags |= MUSTTWOHAND
		if(slot_flags & SLOT_BACK)
			slot_flags &= ~SLOT_BACK
		update_icon()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/attackby(var/obj/item/A, mob/user)
	update_icon()
	..()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		if(loaded.len || stored_magazine)
			var/obj/item/ammo_casing/AC = loaded[1]
			loaded -= AC
			to_chat(user, "<span class='notice'>You unload \the [AC] from \the [src]!</span>")
			update_icon()
			if(user.put_in_any_hand_if_possible(AC))
				return
			else
				AC.forceMove(get_turf(src)) //Eject casing onto ground.
			update_icon()
			
	else
		..()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/attack_self(mob/user) //Unloading (Need special handler for unattaching.)
	if(user.get_active_hand() == src)
		if(!wielded)
			wield(user)
			src.update_wield(user)
		else
			unwield(user)
			src.update_wield(user)

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/update_wield()
	update_icon()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	var/atom/newtarget = target
	if(!wielded)
		newtarget = get_inaccuracy(target,1+recoil) //Inaccurate when not wielded
	if(!ork_held)
		if(user.attribute_strength <= 12)
			if(prob(80))
				var/turf/lol = get_step(user,turn(user.dir,rand(0,360)))
				newtarget = lol
				user.visible_message("[user] loses control of the [src]", "You spin around and fire the rocket in a uncontrolled direction")
				for(var/i=1, i<=8, i++)
					user.dir = turn(user.dir, 45)
					sleep(1)
	..(newtarget,user,params,reflex,struggle)

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/update_icon()
	if(!getAmmo())
		icon_state = "rokkit_launcha-e"
		item_state = "rokkit_launcha[wielded ? "-wielded" : "-unwielded"][ork_held ? "-strpass" : "-strfail"]-e"
	else
		icon_state = "rokkit_launcha"
		item_state = "rokkit_launcha[wielded ? "-wielded" : "-unwielded"][ork_held ? "-strpass" : "-strfail"]"
	var/mob/living/carbon/human/H = loc
	if(istype(loc,/mob/living/carbon/human))
		H.update_inv_hands()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/attack(mob/living/M, mob/living/user, def_zone)
	if(M == user && user.zone_sel.selecting == "mouth") //Are we trying to suicide by shooting our head off ?
		user.visible_message("<span class='warning'>[user] tries to fit \the [src] into \his mouth but quickly reconsiders it</span>", \
		"<span class='warning'>You try to fit \the [src] into your mouth. You feel silly and pull it out</span>")
		return // Nope
	..()

/obj/item/weapon/gun/projectile/rocketlauncher/rokkitlauncha/suicide_act(var/mob/user)
	if(!src.process_chambered()) //No rocket in the rocket launcher
		user.visible_message("<span class='danger'>[user] jams down \the [src]'s trigger before noticing it isn't loaded and starts bashing \his head in with it! It looks like \he's trying to commit suicide.</span>")
		return(SUICIDE_ACT_BRUTELOSS)
	else //Needed to get that shitty default suicide_act out of the way
		user.visible_message("<span class='danger'>[user] fiddles with \the [src]'s safeties and suddenly aims it at \his feet! It looks like \he's trying to commit suicide.</span>")
		spawn(10) //RUN YOU IDIOT, RUN
			explosion(src.loc, -1, 1, 4, 8)
			if(src) //Is the rocket launcher somehow still here ?
				qdel(src) //This never happened
			return(SUICIDE_ACT_BRUTELOSS)
	return

/obj/item/ammo_casing/rocket_rpg/rokkit
	name = "rokkit"
	desc = "Its a rocket missing the c, idiot."
	icon = 'z40k_shit/icons/obj/orks/orkbulletpilesandmags.dmi'
	icon_state = "rokkit"
	caliber = ORKROKKIT
	projectile_type = "/obj/item/projectile/rocket/rokkit"
	starting_materials = list(MAT_IRON = 15000)
	w_type = RECYK_METAL
	w_class = W_CLASS_MEDIUM // Rockets don't exactly fit in pockets and cardboard boxes last I heard, try your backpack
	shrapnel_amount = 4
	
/obj/item/ammo_casing/rocket_rpg/rokkit/update_icon()
	return

/obj/item/projectile/rocket/rokkit
	name = "rokkit"
	icon = 'z40k_shit/icons/obj/projectiles.dmi'
	icon_state = "rokkit"
	damage = 120
	stun = 10
	weaken = 10
	exdev 	= 1
	exheavy = 3
	exlight = 5
	exflash = 8
