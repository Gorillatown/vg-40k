//Menu
#define book_background_color "#F1F1D4"
#define book_window_size "550x600"

//See spellbook.dm for our parent.
/obj/item/weapon/psychic_spellbook
	name = "psyker book"
	desc = "A book of uhh... psyker stuff for psykers."
	icon = 'z40k_shit/icons/obj/ig/IGequipment.dmi'
	icon_state = "psykerbook"
	slot_flags = SLOT_BELT
	inhand_states = list("left_hand" = 'z40k_shit/icons/inhands/LEFTIES/IGequipment_left.dmi', "right_hand" = 'z40k_shit/icons/inhands/RIGHTIES/IGequipment_right.dmi')
	item_state = "psykerbook"
	throw_speed = 1
	throw_range = 5
	w_class = W_CLASS_TINY

	var/list/biomancy_spells = list()
	var/list/pyromancy_spells = list()
	var/list/telekinesis_spells = list()
	var/list/telepathy_spells = list()

	var/current_spellpoints = 5

/obj/item/weapon/psychic_spellbook/New()
	..()

/obj/item/weapon/psychic_spellbook/proc/use_psykpoints(amount, mob/living/user)
	if(!user)
		return 0

	get_spellpoints(user)
	
	if(user.psyker_points >= amount)
		user.psyker_points -= amount
		current_spellpoints = user.psyker_points
	
		return 1
 
/obj/item/weapon/psychic_spellbook/pickup(mob/user)
	..()
	get_spellpoints(user)

/obj/item/weapon/psychic_spellbook/proc/get_spellpoints(mob/living/user)
	current_spellpoints = user.psyker_points

/obj/item/weapon/psychic_spellbook/proc/setup_spellbook(mob/living/user)
	biomancy_spells.Cut()
	pyromancy_spells.Cut()
	telekinesis_spells.Cut()
	telepathy_spells.Cut()

	for(var/psyker_spell in getAllPrimarisPsykerSpells())
		if(locate(psyker_spell) in user.spell_list)
			continue
		else
			var/spell/S = new psyker_spell
			switch(S.specialization)
				if(SSBIOMANCY)
					biomancy_spells += psyker_spell
				if(SSPYROMANCY)
					pyromancy_spells += psyker_spell
				if(SSTELEKINESIS)
					telekinesis_spells += psyker_spell
				if(SSTELEPATHY)
					telepathy_spells += psyker_spell

/obj/item/weapon/psychic_spellbook/attack_self(var/mob/living/user)
	if(!user)
		return

	if(10 > user.attribute_willpower)
		to_chat(user,"<span class='info'>You open \the [src] and realize you don't understand anything!</span>")
		return

	setup_spellbook(user)

	get_spellpoints(user)

	if(user.is_blind())
		to_chat(user, "<span class='info'>You open \the [src] and run your fingers across the parchment. Suddenly, the pages coalesce in your mind!</span>")

	user.set_machine(src)

	var/dat
	dat += "<head><title>Psyker Book ([current_spellpoints] REMAINING)</title></head><body style=\"background-color:[book_background_color]\">"
	dat += "<h1>A Psykers Catalogue Of Spells</h1><br>"
	dat += "<h2>[current_spellpoints] point\s remaining </h2><br>"
	dat += "<em>This book contains a list of many useful things that you'll need in your journey.</em><br>"
	dat += "<span style=\"color:blue\"><strong>KNOWN SPELLS:</strong></span><br><br>"


	for(var/spell/spell in user.spell_list)
		var/spell/abstract_spell = spell
		var/spell_name = initial(abstract_spell.name)
		var/spell_cooldown = get_spell_cooldown_string(initial(abstract_spell.charge_max), initial(abstract_spell.charge_type))
		var/spell_warpcharge_cost = abstract_spell.warpcharge_cost
		dat += "<div style=\"border: 2px solid black\">"
		dat += "<strong>[spell_name]</strong>[spell_cooldown] <br>"
		dat += "<em>[initial(abstract_spell.desc)]</em><br><br>"
		dat += "<span style=\"color:#ae00ff\">Warpcharge Cost per Cast</span>: <span style =\"color:#04c94c\">[spell_warpcharge_cost]</span>"
		dat += "</div>"
//FORMATTING
//<b>Fireball</b> - 10 seconds (buy for 1 spell point)
//<i>(Description)</i>
//Requires robes to cast

	var/biomancy = user.spelltree_unlocked_list[BIOMANCY]
	var/pyromancy = user.spelltree_unlocked_list[PYROMANCY]
	var/telepathy = user.spelltree_unlocked_list[TELEPATHY]
	var/telekinesis = user.spelltree_unlocked_list[TELEKINESIS]
	
	switch(biomancy)
		if(1)
			dat += "<br><span style=\"color:green\"><strong>UNLOCK BIOMANCY</strong></span><br>"
			dat += "<span style=\"color:green\"><a href='?src=\ref[src];unlock=1;unlock_tree=biomancy'>Unlock Tree</a></span><br>"
		if(2)
			dat += "<span style=\"color:green\"><strong>BIOMANCY SPELLS:</strong></span><br><br>"
			if(biomancy_spells.len)
				dat += "<span style=\"color:green\"><a href='?src=\ref[src];rollbuy=1;rollbuy_spell=biomancy'>Learn Psychic Spell</a></span><br><br>"
			else
				dat += "<span style=\"color:green\"><a href='?src=\ref[src];unlock_primaris_spell=1;primaris_spell=biomancy'>Unlock Primaris Spell</a></span><br><br>"
	
	switch(pyromancy)
		if(1)
			dat += "<br><span style=\"color:red\"><strong>UNLOCK PYROMANCY:</strong></span><br>"
			dat += "<span style=\"color:red\"><a href='?src=\ref[src];unlock=1;unlock_tree=pyromancy'>Unlock Tree</a></span><br>"
		if(2)
			dat += "<span style=\"color:red\"><strong>PYROMANCY SPELLS:</strong></span><br><br>"
			if(pyromancy_spells.len)
				dat += "<span style=\"color:red\"><a href='?src=\ref[src];rollbuy=1;rollbuy_spell=pyromancy'>Learn Psychic Spell</a></span><br><br>"
			else
				dat += "<span style=\"color:red\"><a href='?src=\ref[src];unlock_primaris_spell=1;primaris_spell=pyromancy'>Unlock Primaris Spell</a></span><br><br>"

	switch(telekinesis)
		if(1)
			dat += "<br><span style=\"color:blue\"><strong>UNLOCK TELEKINESIS:</strong></span><br>"
			dat += "<span style=\"color:blue\"><a href='?src=\ref[src];unlock=1;unlock_tree=telekinesis'>Unlock Tree</a></span><br>"
		if(2)
			dat += "<span style=\"color:blue\"><strong>TELEKINESIS SPELLS:</strong></span><br><br>"
			if(telekinesis_spells.len)
				dat += "<span style=\"color:blue\"><a href='?src=\ref[src];rollbuy=1;rollbuy_spell=telekinesis'>Learn Psychic Spell</a></span><br><br>"
			else
				dat += "<span style=\"color:blue\"><a href='?src=\ref[src];unlock_primaris_spell=1;primaris_spell=telekinesis'>Unlock Primaris Spell</a></span><br><br>"

	switch(telepathy)
		if(1)
			dat += "<br><span style=\"color:purple\"><strong>UNLOCK TELEPATHY</strong></span><br>"
			dat += "<span style=\"color:purple\"><a href='?src=\ref[src];unlock=1;unlock_tree=telepathy'>Unlock Tree</a></span><br>"
		if(2)
			dat += "<span style=\"color:purple\"><strong>TELEPATHY SPELLS:</strong></span><br><br>"
			if(telepathy_spells.len)
				dat += "<span style=\"color:purple\"><a href='?src=\ref[src];rollbuy=1;rollbuy_spell=telepathy'>Learn Psychic Spell</a></span><br><br>"
			else
				dat += "<span style=\"color:purple\"><a href='?src=\ref[src];unlock_primaris_spell=1;primaris_spell=telepathy'>Unlock Primaris Spell</a></span><br><br>"

	dat += "</body>"

	user << browse(dat, "window=spellbook;size=[book_window_size]")
	onclose(user, "spellbook")

/obj/item/weapon/psychic_spellbook/proc/get_spell_cooldown_string(charges, charge_type)
	if(charges == 0)
		return

	switch(charge_type)
		if(Sp_CHARGES)
			return " - [charges] charge\s"
		if(Sp_RECHARGE)
			return " - cooldown: [(charges/10)]s"

/obj/item/weapon/psychic_spellbook/Topic(href, href_list)
	if(..())
		return

	var/mob/living/L = usr
	if(!istype(L))
		return

	get_spellpoints(L)

	if(href_list["unlock"])
		if(use_psykpoints(1,L))
			switch(href_list["unlock_tree"])
				if(BIOMANCY)
					L.spelltree_unlocked_list[BIOMANCY] += 1
				if(PYROMANCY)
					L.spelltree_unlocked_list[PYROMANCY] += 1
				if(TELEKINESIS)
					L.spelltree_unlocked_list[TELEKINESIS] += 1
				if(TELEPATHY)
					L.spelltree_unlocked_list[TELEPATHY] += 1
			attack_self(usr)

	if(href_list["unlock_primaris_spell"])
		switch(href_list["primaris_spell"])
			if(BIOMANCY)
				L.spelltree_unlocked_list[BIOMANCY] += 1
				//add_spell(/spell/smite,L)
				L.add_spell(new /spell/smite, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/biomancy)
			if(PYROMANCY)
				L.spelltree_unlocked_list[PYROMANCY] += 1
				L.add_spell(new /spell/targeted/projectile/dumbfire/fireball/inferno, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/pyromancy)
				//add_spell(/spell/targeted/projectile/dumbfire/fireball/inferno,L)
			if(TELEKINESIS)
				L.spelltree_unlocked_list[TELEKINESIS] += 1
				//add_spell(/spell/aoe_turf/assail,L)
				L.add_spell(new /spell/aoe_turf/assail, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/telekinesis)
			if(TELEPATHY)
				L.spelltree_unlocked_list[TELEPATHY] += 1
				//add_spell(/spell/aoe_turf/psychic_shriek,L)
				L.add_spell(new /spell/aoe_turf/psychic_shriek, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/telepathy)
		attack_self(usr)

	if(href_list["rollbuy"])
		switch(href_list["rollbuy_spell"])
			if(BIOMANCY)
				if(biomancy_spells.len)
					if(use_psykpoints(1,L))
						var/spell/suckit = pick(biomancy_spells)
						biomancy_spells.Remove(suckit)
						//add_spell(suckit,L)
						L.add_spell(suckit, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/biomancy)
					else
						to_chat(L, "You currently have no points.")
				else
					to_chat(L,"You either own all the spells or the system broke.")
			if(PYROMANCY)
				if(pyromancy_spells.len)
					if(use_psykpoints(1,L))
						var/spell/suckit = pick(pyromancy_spells)
						pyromancy_spells.Remove(suckit)
						//add_spell(suckit,L)
						L.add_spell(suckit, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/pyromancy)
					else
						to_chat(L, "You currently have no points.")
				else
					to_chat(L,"You either own all the spells or the system broke.")
			if(TELEKINESIS)
				if(telekinesis_spells.len)
					if(use_psykpoints(1,L))
						var/spell/suckit = pick(telekinesis_spells)
						telekinesis_spells.Remove(suckit)
						//add_spell(suckit,L)
						L.add_spell(suckit, "ork_spell_ready", /obj/abstract/screen/movable/spell_master/telekinesis)
					else
						to_chat(L, "You currently have no points.")
				else
					to_chat(L,"You either own all the spells or the system broke.")
			if(TELEPATHY)
				if(telepathy_spells.len)
					if(use_psykpoints(1,L))
						var/spell/suckit = pick(telepathy_spells)
						telepathy_spells.Remove(suckit)
						//add_spell(suckit,L)
						L.add_spell(suckit, "cult_spell_ready", /obj/abstract/screen/movable/spell_master/telepathy)
					else
						to_chat(L, "You currently have no points.")
				else
					to_chat(L,"You either own all the spells or the system broke.")

		attack_self(usr)

#undef book_background_color
#undef book_window_size
