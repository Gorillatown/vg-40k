/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher
	name = "Detroid Pattern Missile Tube"
	desc = "It doesn't take much science to make a metal tube, which is why you have this in front of you."
	fire_sound = 'F_40kshit/sounds/pdf_rocketlauncher.ogg'
	icon = 'F_40kshit/icons/obj/guns.dmi'
	icon_state = "rocketlauncher"
	item_state = "rocketlauncher"
	inhand_states = list("left_hand" = 'F_40kshit/icons/inhands/LEFTIES/64x64Special_guns_left.dmi', "right_hand" = 'F_40kshit/icons/inhands/RIGHTIES/64x64Special_guns_right.dmi')
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
	caliber = list(DETROID_ROCKET = 1)
	origin_tech = Tc_COMBAT + "=4;" + Tc_MATERIALS + "=2;" + Tc_SYNDICATE + "=2"
	ammo_type = "/obj/item/ammo_casing/rocket_rpg/d_rocket"
	attack_verb = list("strikes", "hits", "bashes")
	gun_flags = 0
	actions_types = list(/datum/action/item_action/warhams/heavydef_swap_stance)
	var/ork_held = FALSE //Are we being held by a ork or a puny human.

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/isHandgun()
	return FALSE

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/prepickup(mob/user)
	update_icon()

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/attackby(var/obj/item/A, mob/user)
	update_icon()
	..()

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/attack_hand(mob/user)
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

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/attack_self(mob/user) //Unloading (Need special handler for unattaching.)
	if(user.get_active_hand() == src)
		if(!wielded)
			wield(user)
			src.update_wield(user)
		else
			unwield(user)
			src.update_wield(user)

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/update_wield()
	update_icon()

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	var/atom/newtarget = target
	if(!wielded)
		newtarget = get_inaccuracy(target,1+recoil) //Inaccurate when not wielded
	var/turf/T = get_step(user,turn(user.dir,180))
	for(var/mob/living/M in T)
		M.adjustFireLoss(10)
		to_chat(M,"<span class='danger'> You are scorched by the backblast </span>")
	..(newtarget,user,params,reflex,struggle)

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/update_icon()
	if(!getAmmo())
		icon_state = "rocketlauncher-e"
		item_state = "rocketlauncher[wielded ? "-wielded" : "-unwielded"]-e"
	else
		icon_state = "rocketlauncher"
		item_state = "rocketlauncher[wielded ? "-wielded" : "-unwielded"]"
	var/mob/living/carbon/human/H = loc
	if(istype(loc,/mob/living/carbon/human))
		H.update_inv_hands()

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/attack(mob/living/M, mob/living/user, def_zone)
	if(M == user && user.zone_sel.selecting == "mouth") //Are we trying to suicide by shooting our head off ?
		user.visible_message("<span class='warning'>[user] tries to fit \the [src] into \his mouth but quickly reconsiders it</span>", \
		"<span class='warning'>You try to fit \the [src] into your mouth. You feel silly and pull it out</span>")
		return // Nope
	..()

/obj/item/weapon/gun/projectile/rocketlauncher/pdf_launcher/suicide_act(var/mob/user)
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