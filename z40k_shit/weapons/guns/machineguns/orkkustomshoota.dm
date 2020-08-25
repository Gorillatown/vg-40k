
/obj/item/weapon/taperoll
	name = "Tape" //Perhaps one day.
	desc = "This is some incredible Ork technology right here."
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "tape"
	item_state = "tape"
	w_class = W_CLASS_SMALL

/obj/item/weapon/gun/projectile/kustomshoota
	name = "\improper Kustom Shoota"
	desc = "A long but well defined shoota, ready for modifications."
	icon = 'z40k_shit/icons/obj/orks/kustomgun.dmi'
	icon_state = "kustom_shoota-nsg-nlsg"
	item_state = "kustom_shoota-nsg-nlsg"
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/64x64kustom_shoota_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/64x64kustom_shoota_right.dmi')
	origin_tech = Tc_COMBAT + "=5;" + Tc_MATERIALS + "=2"
	w_class = W_CLASS_MEDIUM
	max_shells = 25
	caliber = list(ORKSCRAPBULLET = 1)
	ammo_type = "/obj/item/ammo_casing/orkbullet"
	mag_type = "/obj/item/ammo_storage/magazine/kustom_shoota_belt"
	fire_sound = 'z40k_shit/sounds/Shoota1.ogg'
	recoil = 16
	load_method = 2
	force = 15
	gun_flags = AUTOMAGDROP | EMPTYCASINGS
	flags = TWOHANDABLE
	var/projectiles = 45
	var/totalguncount = 1 //We are the gun anon.
	var/projectile_type
	var/cooldown = 0
	var/basicbullets = 3 //Basic bullet types counting ourselves.
	var/laserbeams = 0 //Laser bullet types
	var/shotgunpellets = 0 //Shotgun bullet types
	var/taped = 1
	fire_delay = 0
	actions_types = list(/datum/action/item_action/warhams/basic_swap_stance)

/obj/item/weapon/gun/projectile/kustomshoota/New()
	..()
	update_icon()

/obj/item/weapon/gun/projectile/kustomshoota/verb/rename_gun() //I could add possession here later for funs.
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun."

	var/mob/M = usr
	if(!M.mind)
		return 0

	var/input = stripped_input(usr,"What do you want to name the gun?","", MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(src,M))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1

/obj/item/weapon/gun/projectile/kustomshoota/isHandgun()
	return FALSE //No Kustom Shoota Akimbo for us.

/obj/item/weapon/gun/projectile/kustomshoota/update_wield(mob/user)
	..()
	force = wielded ? 30 : 15
	update_icon()

/obj/item/weapon/gun/projectile/kustomshoota/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		RemoveMag(user)
	else
		..()

/obj/item/weapon/gun/projectile/kustomshoota/attack_self(mob/user) //Unloading (Need special handler for unattaching.)
	if(user.get_active_hand() == src)
		if(!wielded)
			wield(user)
			src.update_wield(user)
		else
			unwield(user)
			src.update_wield(user)
 
/obj/item/weapon/gun/projectile/kustomshoota/examine(mob/user)
	..()
	if(basicbullets)
		to_chat(user, "<span class='info'> There are currently [basicbullets] ballistics attached.</span>")
	if(laserbeams)
		to_chat(user, "<span class='info'> There are currently [laserbeams] laser guns attached.</span>")
	if(shotgunpellets)
		to_chat(user, "<span class='info'> There are currently [shotgunpellets] shotguns attached.</span>")

/obj/item/weapon/gun/projectile/kustomshoota/attackby(obj/item/I, mob/user)
	var/good2go = FALSE //Basically I don't really feel like doing ALL the guns atm
	if(!isork(user))
		to_chat(user,"<span class='warning'> What on earth are you trying to do?</span>")
		return
	if(istype(I, /obj/item/weapon/taperoll))
		taped = 1
		to_chat(user,"<span class='warning'> You tape the gun together.</span>")
		playsound(loc, 'z40k_shit/sounds/tape.ogg', 50, 0)
		return
	if(istype(I, /obj/item/weapon/gun)) //I think I can nab any gun that can appear on the map.		
		if(totalguncount > 29)
			to_chat(user,"<span class='warning'> Looks like there is no more room for that. Any more and only a cybork could lift it.</span>")
			return
		if(istype(I, /obj/item/weapon/gun/projectile/automatic))
			basicbullets++
			totalguncount++
			good2go = TRUE
		if(istype(I, /obj/item/weapon/gun/energy))
			laserbeams++
			totalguncount++
			good2go = TRUE
		if(istype(I, /obj/item/weapon/gun/projectile/shotgun))
			shotgunpellets++
			totalguncount++
			good2go = TRUE
		if(good2go)
			qdel(I) //Basically this block will be executed no matter what is attached... ha ha mayb
			taped = 0 //A gun not accounted for in here is a bug anyways.
			to_chat(user, "<span class='notice'> Dat [I] fits on to the [src] nicely it does. NOW you just needs some tape!</span>")
			update_icon()
			playsound(src, 'sound/machines/click.ogg', 25, 1)
		else
			to_chat(user, "<span class='notice'> Dat [I] doesn't fit onto the [src] </span>")

	..()

/obj/item/weapon/gun/projectile/kustomshoota/update_icon()
	..()
	item_state = "kustom_shoota[wielded ? "-wielded" : "-unwielded"][shotgunpellets ? "-sg" : "-nsg"][laserbeams ? "-lsg" : "-nlsg"]"
	icon_state = "kustom_shoota[shotgunpellets ? "-sg" : "-nsg"][laserbeams ? "-lsg" : "-nlsg"][stored_magazine ? "" : "-e"]"
	var/mob/living/carbon/human/H = loc
	if(istype(loc,/mob/living/carbon/human))
		H.update_inv_hands()
	return

/obj/item/weapon/gun/projectile/kustomshoota/Fire(atom/target, mob/living/user, params, reflex = 0, struggle = 0)
	..()
	if(!cooldown)
		makethepainstop(target, user, params, struggle)
		return

/obj/item/weapon/gun/projectile/kustomshoota/proc/makethepainstop(atom/target, mob/living/user, params, struggle = 0) //Burst fires don't work well except by calling Fire() multiple times
	var/fucked_fire = FALSE //We set this if someone has fucked up firing.
	if(!isork(user))
		if(user.attribute_strength <= 12)
			fucked_fire = TRUE
	if(!taped)
		user.visible_message("<span class='warning'> This needs to be taped up before it can be used!</span>")
		return
	if(!cooldown) //If we are not on cooldown
		if(getAmmo()) //If we have ammo
			var/atom/originaltarget = target //Our original target
			var/turf/targloc
			target = get_inaccuracy(originaltarget, 1+recoil)
			if(!wielded) //Even more inaccurate when not wielded
				var/atom/newtarget = get_inaccuracy(target, 1+recoil)
				targloc = get_turf(newtarget)
			else
				targloc = get_turf(target)
			cooldown = 1
			fire_volume = clamp((3 * totalguncount), 20, 100) //Ouch my ears... well up to 90% vol anyways.
			if(fucked_fire)
				user.visible_message("[user] loses control of [src].", "[src] starts firing wildly out of control due to your puny muscles.")
			if(basicbullets >= 0)
				projectile_type = /obj/item/projectile/bullet/orkscrapbullet
				for(var/i=1 to basicbullets)
					if(fucked_fire)
						targloc = get_step(user,turn(user.dir,rand(0,360)))
					in_chamber = new projectile_type(loc)
					fire_sound = 'z40k_shit/sounds/Shoota1.ogg'
					Fire(targloc, user, params, struggle)
			if(laserbeams >= 0) //Laserbeam shit
				in_chamber = null
				projectile_type = /obj/item/projectile/beam/medpower
				for(var/i=1 to laserbeams)
					if(fucked_fire)
						targloc = get_step(user,turn(user.dir,rand(0,360)))
					in_chamber = new projectile_type(loc)
					fire_sound = 'z40k_shit/sounds/Lasgun0.ogg'
					Fire(targloc, user, params, struggle)
					sleep(1)
			if(shotgunpellets >= 0)
				in_chamber = null
				projectile_type = /obj/item/projectile/bullet/buckshot
				for(var/i=1 to shotgunpellets)
					if(fucked_fire)
						targloc = get_step(user,turn(user.dir,rand(0,360)))
					in_chamber = new projectile_type(loc)
					fire_sound = 'z40k_shit/sounds/shotta.ogg'
					Fire(targloc, user, params, struggle)
					sleep(1)
		sleep(8)
	cooldown = 0
		
