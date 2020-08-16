var/list/item_artifact_paths = list(/datum/item_artifact/undroppable,
									/datum/item_artifact/ignite,
									/datum/item_artifact/blind,
									/datum/item_artifact/heal,
									/datum/item_artifact/harm,
									/datum/item_artifact/stone,
									/datum/item_artifact/tele,
									/datum/item_artifact/eating,
									/datum/item_artifact/ominous,
									/datum/item_artifact/fake,
									/datum/item_artifact/hulk,
									/datum/item_artifact/tk,
									/datum/item_artifact/radiate,
									/datum/item_artifact/raise)

/obj/item/xenoitem
	name = "Generic item (ERROR)"
	desc = "A small device that carries out the critically important task of never existing. Report this bug/heresy to Drake Marshall, Norc, or on the forums."
	icon = 'icons/obj/items.dmi'
	icon_state = "dev110"
	var/base_icon = "dev11"
	var/on = 0
	var/trigger

/obj/item/xenoitem/proc/update_icons()
	icon_state = "[base_icon][on]"

/obj/item/xenoitem/New()
	..()
	var/art_effect = pick(item_artifact_paths)
	var/datum/item_artifact/E = new art_effect
	E.item_init(src)
	var/item_trigger = pick(IE_ATK_SELF,IE_ATK_SELF,IE_EQP,IE_EQP,IE_FOUND,IE_ATK,IE_ATK_OTHER,IE_ATK_OTHER)
	src.trigger = item_trigger
	E.trigger = item_trigger
	force = pick(0,0,0,0,5,5,5,5,10,10,15,20)

/obj/item/xenoitem/attack_hand(mob/user)
	if(trigger == IE_ATK_HAND)
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/attack_self(mob/user)
	if(trigger == IE_ATK_SELF)
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/equipped(mob/user)
	if(trigger == IE_EQP)
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/on_found(mob/user)
	if(trigger == IE_FOUND)
		on = 1
		update_icons()
	..()

/obj/item/xenoitem/attack(mob/living/M, mob/user)
	if(trigger == IE_ATK | trigger == IE_ATK_OTHER)
		on = 1
		update_icons()
	..()

/proc/generate_item(template,spawnloc)
	var/obj/item/A
	switch(template)
		if("generic") //A regular item imbued with an item effect. Basically just technological curiousities or the castoff of ancient psykers.
			var/item_path = pick(/obj/item/weapon/crowbar,/obj/item/weapon/weldingtool,/obj/item/weapon/wrench,/obj/item/weapon/screwdriver,/obj/item/weapon/wirecutters,/obj/item/weapon/weldingtool,/obj/item/device/soulstone,/obj/item/candle,/obj/item/xenos_claw)
			A = new item_path(spawnloc)
			var/effect_path = pick(item_path)
			var/datum/item_artifact/E = new effect_path
			E.trigger = pick(IE_ATK_SELF,IE_ATK_SELF,IE_EQP,IE_EQP,IE_FOUND,IE_ATK,IE_ATK_OTHER,IE_ATK_OTHER)
			E.item_init(A)
			return A
		if("daemon")  //An ornate weapon that corrupts the user and grants some varying powers. After the user dies, chooses a new user, so quite dangerous.
			A = new /obj/item/weapon/daemon(spawnloc)
			return A
		if("eldar")   //Eldar enchanted wierd thing.
			var/obj/item/xenoitem/XA = new /obj/item/xenoitem(spawnloc)
			XA.base_icon = pick("dev21","dev22","dev23","dev24")
			XA.update_icons()
			A = XA
			A.name = pick("relic","gizmo","object","item","gadget")
			A.name = "[pick("arcane","strange","runed", "glowing", "eldar", "alien", "bizarre", "ornate", "battered")] [A.name]"
			A.desc = pick("A completely bizarre device. ","Some kind of wierd item. ","A large device that pulsates with arcane energies. ","An object that is obviously not made by humans. ","A device that utilizes xeno technology. ")
			A.desc += pick("It hums with internal energy","It has a faint white glow.","It has an eldar sigil on it.","It has a small red stone pressed into it.","You can see a slight flickering inside the device.","It is covered in tiny cracks.","It looks unsafe.")
			return A
		if("darkage") //Sophisticated tech that is basically like a necron item. However, the naming and sprites are different, and the lore of these is that they are from the dark age of technology. Includes powerful stuff like a very potent white esword, energy pistol, et cetera.
			return A    //I haven't put this in yet.
/*
/proc/daemonize(var/obj/item/O,var/chaosgod = null) //Places the essence of a daemon in an object.
	var/datum/item_artifact/daemon_effect/daemon = new /datum/item_artifact/daemon_effect
	if(chaosgod)
		daemon.chaosgod = chaosgod
	daemon.item_init(O)
*/
/obj/item/weapon/daemon
	name = "daemon weapon (ERROR)"
	desc = "A blade that carries a daemon's essence. Trouble is, it shouldn't really exist (at least not unaltered). Please report this to Drake, Norc, or the forums."
	icon = 'icons/obj/items.dmi'
	icon_state = "daemon1"
	item_state = "cultblade"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	force = 40
	throwforce = 60
	w_class = 3
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "mauled", "impaled", "eviscerated")

/obj/item/weapon/daemon/New()
	..()
	var/chaosgod = pick("khorne","tzeench","nurgle","slaanesh")
//	daemonize(src,chaosgod)
	force = pick(30,35,40,40,40,45,45,50,55,60,65,70)
	switch(chaosgod)
		if("khorne")
			icon_state = pick("daemon1","daemon2","daemon3","daemon7","daemon8")
		if("tzeench")
			icon_state = pick("daemon2","daemon3","daemon5")
		if("nurgle")
			icon_state = pick("daemon2","daemon3","daemon4","daemon9")
		if("slaanesh")
			icon_state = pick("daemon2","daemon3","daemon6")
	name = pick("blade","razor","sword")
	name = "[pick("ornate","runed","ancient","gilded","gem-encrusted","blood-stained","warp","tainted","arcane", "rusted")] [name]"
	desc = pick("An ornate weapon.","An ancient blade.","A strange weapon.","A gem-encrusted blade.")
	desc += " "
	desc += pick("It is covered in unholy runes.","It has a faint red glow.","You feel like it is watching you.","It has strange markings on it.","It has a strange aura.","You feel an inexplicable urge to touch it...","You feel oddly attached to it...")

/obj/item/weapon/daemon/IsShield()
	return prob(50)

/obj/item/weapon/daemon/attack(mob/living/M, mob/user)
	..()
	new /obj/effect/gibspawner/blood(M.loc)
