/*




/obj/item/weapon/hellblade //Mostly for debugging, but hey, if you want you can put this in somewhere. After all, it is a lore-accurate hellblade of khorne.
	name = "hellblade"
	desc = "A hellblade of khorne. Contains the essence of a bloodletter daemon."
	icon = 'icons/obj/items.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/hellblade/New()
	..()
	daemonize(src,"khorne") //Makes it into a daemon weapon, supplies the optional argument to make it a khorne daemon.

/obj/item/weapon/hellblade/IsShield()
	return prob(50)

/obj/item/weapon/hellblade/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on the [src.name]! It looks like \he's trying to commit suicide.</span>")
	to_chat(user, "<span class='warning'> You hear the sound of laughter in your mind as darkness overtakes your consciousness.</span>")
	spawn(100)
		user.visible_message("<span class='suicide'>BLOOD FOR THE BLOOD GOD</span>")
		user.gib()
	return (SUICIDE_ACT_BRUTELOSS)

/obj/item/weapon/hellblade/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/night
	name = "nightblood"
	desc = "A massive jet black sword. You feel the need to pick it up..."
	icon = 'icons/obj/items.dmi'
	icon_state = "night"
	item_state = "cultbladeold"
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 50
	throwforce = 40
	w_class = 4
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/night/New()
	..()
	var/datum/item_artifact/daemon_effect/night/spirit = new /datum/item_artifact/daemon_effect/night
	spirit.item_init(src)

/obj/item/weapon/night/IsShield()
	return prob(90)

/obj/item/weapon/night/dropped(mob/user)
	..()
	for(var/datum/item_artifact/daemon_effect/night/spirit in src.item_artifacts) //Unbonds with them when dropped.
		spirit.target = null
	if(iscarbon(user)) //Some backlash when dropped.
		var/mob/living/carbon/M = user
		M.apply_effect(3,WEAKEN)
		M.adjustToxLoss(-5)
		M.reagents.clear_reagents()
		var/turf/T = get_turf(M)
		T.add_vomit_floor(M)
		playsound(M, 'sound/effects/splat.ogg', 50, 1)

/obj/item/weapon/night/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)

/obj/item/weapon/storage/belt/night
	name = "sword sheath"
	desc = "Holds a sword."
	icon_state = "night"
	item_state = "katana"
	can_only_hold = list(/obj/item/weapon/night)
	storage_slots = 2
	max_combined_w_class = 200
	attack_verb = list("beat")
 
/obj/item/weapon/storage/belt/night/New()
	..()
	new /obj/item/weapon/night(src)

/obj/item/clothing/suit/armor/shadowcloak/dropped()
	..()
	usr.alpha = 255

/obj/item/clothing/suit/armor/shadowcloak/equipped()
	..()
	usr.alpha = 255
*/
