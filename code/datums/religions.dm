/proc/DecidePrayerGod(var/mob/H)
	if(!H || !H.mind)
		return "a voice"
	if(H.mind.GetRole(CULTIST))
		return "Nar-Sie"
	else if(H.mind.faith) // The user has a faith
		var/datum/religion/R = H.mind.faith
		return R.deity_name
	else if(H.mind.assigned_role == "Celebrity")
		return "Yourself cause you are the best"
	else if(H.mind.assigned_role == "Trader")
		return "Shoalmother"
	else if(!ishuman(H))
		return "Animal Jesus"
	else
		return "Faithless"

//Proc for selecting a religion
/proc/ChooseReligion(var/mob/living/carbon/human/H, var/ChaosSelection)
	var/obj/item/weapon/storage/bible/B
	var/datum/religion/chaplain_religion
	var/new_religion
	
	if(ChaosSelection)
		new_religion = input(H, "You a servant of Chaos. What god do you follow and teach? (Please put your ID in your ID slot to prevent errors)", "Select One") in list("Nurgle","Khorne","Slaanesh","Tzeentch","Chaos Undivided")
	else
		new_religion = "The Imperial Creed" // If nothing was typed

	var/choice = FALSE

	for (var/R in typesof(/datum/religion))
		var/datum/religion/rel = new R
		for (var/key in rel.keys)
			if (lowertext(new_religion) == lowertext(key))
				rel.equip_chaplain(H) // We do the misc things related to the religion
				chaplain_religion = rel
				B = new rel.bible_type(H)
				B.my_rel = rel
				B.name = rel.bible_name
				H.put_in_hands(B)
				chaplain_religion.holy_book = B
				H.equip_or_collect(new rel.preferred_incense(H.back), slot_in_backpack)
				rel.religiousLeader = H.mind
				for(var/object in H.get_body_slots())
					if(istype(object, /obj/item/weapon/card/id))
						var/obj/item/weapon/card/id/ID = object
						ID.assignment =  (H.gender == FEMALE ? rel.female_adept : rel.male_adept)
						ID.name = "[H]'s ID Card ([ID.assignment])"
				rel.convert(H, null, can_renounce = FALSE)
				rel.OnPostActivation()
				to_chat(H, "A great, intense revelation goes through your spirit. You are now the religious leader of [rel.name]. Convert people by [rel.convert_method]")
				choice = TRUE
				break // We got our religion ! Abort, abort.
		if (choice)
			break

/*	if (!choice) // Nothing was found
		chaplain_religion = new
		chaplain_religion.name = "[new_religion]"
		chaplain_religion.deity_name = "[new_religion]"
		chaplain_religion.bible_name = "The Holy Book of [new_religion]"
		chaplain_religion.equip_chaplain(H) // We do the misc things related to the religion
		B = new /obj/item/weapon/storage/bible
		chaplain_religion.holy_book = B
		B.name = "The Holy Book of [new_religion]"
		B.my_rel = chaplain_religion
		H.put_in_hands(B)
		chaplain_religion.religiousLeader = H.mind
		to_chat(H, "A great, intense revelation goes through your spirit. You are now the religious leader of [chaplain_religion.name]. Convert people by [chaplain_religion.convert_method]")
		chaplain_religion.convert(H, null, can_renounce = FALSE)

	switch(input(H, "Would you like the traditional [chaplain_religion.bookstyle] design and to worship [chaplain_religion.deity_names.len ? "one of [english_list(chaplain_religion.deity_names)]" : chaplain_religion.deity_name]?") in list("Yes", "No"))
		if("No")
			chaplain_religion.deity_name = ChooseDeity(H,chaplain_religion,FALSE)
			chooseBible(chaplain_religion,H,FALSE)
		if("Yes")
			chaplain_religion.deity_name = ChooseDeity(H,chaplain_religion,TRUE)
			chooseBible(chaplain_religion,H,TRUE)*/

	B.icon_state = chaplain_religion.holy_book.icon_state
	B.item_state = chaplain_religion.holy_book.item_state

	if(ticker)
		ticker.religions += chaplain_religion
	feedback_set_details("religion_deity","[chaplain_religion.deity_name]")
	feedback_set_details("religion_book","[B.icon_state]")

/proc/ChooseDeity(mob/chooser, datum/religion/R, var/default = FALSE)
	if(default)
		if(!R.deity_names.len)
			return R.deity_name
		else
			return input(chooser, "Your religion is polytheistic. Who is your patron?") as anything in R.deity_names
	else
		var/new_deity = copytext(sanitize(input(chooser, "Who do you worship?", "Name of Deity", R.deity_name)), 1, MAX_NAME_LEN)
		if(length(new_deity))
			return new_deity
		else
			return R.deity_name


// This file lists all religions, as well as the prototype for a religion
/datum/religion
	// Following tradition, the default is Space Jesus (this is here to avoid people getting an empty relgion)
	var/name = "Christianity"
	var/deity_name = "Space Jesus"
	var/bible_name = "The Holy Bible"
	var/male_adept = "Preacher"
	var/female_adept = "Preacher"
	var/convert_method = "splashing them with holy water, holding a bible in hand."

	var/bible_type = /obj/item/weapon/storage/bible
	var/obj/item/weapon/storage/bible/holy_book

	var/datum/mind/religiousLeader
	var/list/datum/mind/adepts = list()

	var/list/bible_names = list()
	var/list/deity_names = list()

	var/datum/action/renounce/action_renounce
	var/list/keys = list("abstractbasetype") // What you need to type to get this particular relgion.
	var/converts_everyone = FALSE
	var/preferred_incense = /obj/item/weapon/storage/fancy/incensebox/harebells
	var/symbolstyle = 10
	var/bookstyle = "Holy Light"

/datum/religion/New() // For religions with several bibles/deities
	if (bible_names.len)
		bible_name = pick(bible_names)
	/*if (deity_names.len)
		deity_name = pick(deity_names)*/
	action_renounce = new /datum/action/renounce(src)

/datum/religion/proc/leadsThisReligion(var/mob/living/user)
	return (user.mind && user.mind == religiousLeader)

/proc/isReligiousLeader(var/mob/living/user)
	for (var/datum/religion/rel in ticker.religions)
		if (rel.leadsThisReligion(user))
			return TRUE
	return FALSE

// Give the chaplain the basic gear, as well as a few misc effects.
/datum/religion/proc/equip_chaplain(var/mob/living/carbon/human/H)
	return TRUE // Nothing to see here, but redefined in some other religions !

/* ---- RELIGIOUS CONVERSION ----
 * convertAct() -> convertCeremony() -> convertCheck() -> convert()
 * Redefine 'convertCeremony' to play out your snowflake ceremony/interactions in your religion datum.
 * In a saner language, convertCeremony() and convertCheck() would be private methods. Those are UNSAFE procs. Call convertAct() instead.
 */

/* ConvertAct() : here we check if eveything is in place for the conversion, and provide feedback if needed. Sanity for the preacher or the target belongs to the verb in the bible.
 * - preacher : the guy doing the converting
 * - subject : the guy being converted
 * - B : the bible using for the conversion
 */
/datum/religion/proc/convertAct(var/mob/living/preacher, var/mob/living/subject, var/obj/item/weapon/storage/bible/B)
	if (B.my_rel != src) // BLASPHEMY
		to_chat(preacher, "<span class='warning'>You are a heathen to this God. You feel [B.my_rel.deity_name]'s wrath strike you for this blasphemy.</span>")
		preacher.fire_stacks += 5
		preacher.IgniteMob()
		preacher.audible_scream()
		return FALSE
	if (preacher != religiousLeader.current)
		to_chat(preacher, "<span class='warning'>You fail to muster enough mental strength to begin the conversion. Only the Spiritual Guide of [name] can perfom this.</span>")
		return FALSE
	if (subject.mind.faith == src)
		to_chat(preacher, "<span class='warning'>You and your target follow the same faith.</span>")
		return FALSE
	if (istype(subject.mind.faith) && subject.mind.faith.leadsThisReligion(subject))
		to_chat(preacher, "<span class='warning'>Your target is already the leader of another religion.</span>")
		return FALSE
	else
		return convertCeremony(preacher, subject)

/* ConvertCeremony() : the RP ceremony to convert the newfound person.
 Here we check if we have the tools to convert and play out the little interactions. */

 // This is the default ceremony, for Christianity/Space Jesus
/datum/religion/proc/convertCeremony(var/mob/living/preacher, var/mob/living/subject)
	var/held_beaker = preacher.find_held_item_by_type(/obj/item/weapon/reagent_containers)
	if (!held_beaker)
		to_chat(preacher, "<span class='warning'>You need to hold Holy Water to begin the conversion.</span>")
		return FALSE
	var/obj/item/weapon/reagent_containers/B = preacher.held_items[held_beaker]
	if (B.reagents.get_master_reagent_name() != "Holy Water")
		to_chat(preacher, "<span class='warning'>You need to hold Holy Water to begin the conversion.</span>")
		return FALSE
	subject.visible_message("<span class='notice'>\The [preacher] attempts to convert \the [subject] to [name].</span>")
	if(!convertCheck(subject))
		subject.visible_message("<span class='warning'>\The [subject] refuses conversion.</span>")
		return FALSE

	// Everything is ok : begin the conversion
	splash_sub(B.reagents, subject, 5, preacher)
	subject.visible_message("<span class='notice'>\The [subject] is blessed by \the [preacher] and embraces [name]. Praise [deity_name]!</span>")
	convert(subject, preacher)
	return TRUE

// Here we check if the subject is willing
/datum/religion/proc/convertCheck(var/mob/living/subject)
	var/choice = input(subject, "Do you wish to become a follower of [name]?","Religious converting") in list("Yes", "No")
	return choice == "Yes"

// Here is the proc to welcome a new soul in our religion.
/datum/religion/proc/convert(var/mob/living/subject, var/mob/living/preacher, var/can_renounce = TRUE, var/default = FALSE)
	// If he already had one
	if (subject.mind.faith)
		subject.mind.faith.renounce(subject) // We remove him from that one

	subject.mind.faith = src
	adepts += subject.mind
	if(can_renounce)
		action_renounce.Grant(subject)
	if(!default)
		to_chat(subject, "<span class='good'>You feel your mind become clear and focused as you discover your newfound faith. You are now a follower of [name].</span>")
		if (!preacher)
			var/msg = "\The [key_name(subject)] has been converted to [name] without a preacher."
			message_admins(msg)
		else
			var/msg = "[key_name(subject)] has been converted to [name] by \The [key_name(preacher)]."
			message_admins(msg)
	else
		to_chat(subject, "<span class='good'>You are reminded you were christened into [name] long ago.</span>")

// Activivating a religion with admin interventions.
/datum/religion/proc/activate(var/mob/living/preacher)
	equip_chaplain(preacher) // We do the misc things related to the religion
	to_chat(preacher, "A great, intense revelation goes through your spirit. You are now the religious leader of [name]. Convert people by [convert_method]")
	if (holy_book)
		preacher.put_in_hands(holy_book)
	else
		holy_book = new bible_type
		holy_book.my_rel = src
		chooseBible(src, preacher)
		holy_book.name = bible_name
		preacher.put_in_hands(holy_book)
	religiousLeader = preacher.mind
	convert(preacher, null)
	OnPostActivation()

/datum/religion/proc/OnPostActivation()
	if(converts_everyone)
		message_admins("[key_name(religiousLeader)] has selected [name] and converted the entire crew.")
		for(var/mob/living/carbon/human/H in player_list)
			if(isReligiousLeader(H))
				continue
			convert(H,null,TRUE,TRUE)

/datum/religion/proc/renounce(var/mob/living/subject)
	to_chat(subject, "<span class='notice'>You renounce [name].</span>")
	adepts -= subject.mind
	subject.mind.faith = null

// Action : renounce your faith. For players.
/datum/action/renounce
	name = "Renounce faith"
	desc = "Leave the religion you are currently in."
	icon_icon = 'icons/obj/clothing/hats.dmi'
	button_icon_state = "fedora" // :^) Needs a better icon

/datum/action/renounce/Trigger()
	var/datum/religion/R = target
	var/mob/living/M = owner

	if (!R) // No religion, may as well be a good time to remove the icon if it's there
		Remove(M)
		return FALSE
	if (R.leadsThisReligion(M))
		to_chat(M, "<span class='warning'>You are the leader of this flock and cannot forsake them. If you have to, pray to the Gods for release.</span>")
		return FALSE
	if (alert("Do you wish to renounce [R.name]?","Renouncing a religion","Yes","No") != "Yes")
		return FALSE

	R.renounce(owner)
	Remove(owner)

// interceptPrayer: Called when anyone (not necessarily one of our adepts!) whispers a prayer.
// Return 1 to CANCEL THAT GUY'S PRAYER (!!!), or return null and just do something fun.
/datum/religion/proc/interceptPrayer(var/mob/living/L, var/deity, var/prayer_message)
	return

/proc/chooseBible(var/datum/religion/R, var/mob/user, var/noinput = FALSE) //Noinput if they just wanted the defaults

	if (!istype(R) || !user)
		return FALSE

	if (!R.holy_book)
		return FALSE

	var/book_style = R.bookstyle
	if(!noinput)
		book_style = input(user, "Which bible style would you like?") as null|anything in list("Bible", "Koran", "Scrapbook", "Creeper", "White Bible", "Holy Light", "Athiest", "Slab", "Tome", "The King in Yellow", "Ithaqua", "Scientology", \
																		   "The Bible melts", "Unaussprechlichen Kulten", "Necronomicon", "Book of Shadows", "Torah", "Burning", "Honk", "Ianism", "The Guide", "The Dokument")
	switch(book_style)
		if("Koran")
			R.holy_book.icon_state = "koran"
			R.holy_book.item_state = "koran"
		if("Scrapbook")
			R.holy_book.icon_state = "scrapbook"
			R.holy_book.item_state = "scrapbook"
		if("Creeper")
			R.holy_book.icon_state = "creeper"
			R.holy_book.item_state = "creeper"
		if("White Bible")
			R.holy_book.icon_state = "white"
			R.holy_book.item_state = "white"
		if("Holy Light")
			R.holy_book.icon_state = "holylight"
			R.holy_book.item_state = "holylight"
		if("Athiest")
			R.holy_book.icon_state = "athiest"
			R.holy_book.item_state = "athiest"
		if("Tome")
			R.holy_book.icon_state = "bible-tome"
			R.holy_book.item_state = "bible-tome"
			R.holy_book.desc = "A Nanotrasen-approved heavily revised interpretation of Nar-Sie's teachings. Apply to head repeatedly."
		if("The King in Yellow")
			R.holy_book.icon_state = "kingyellow"
			R.holy_book.item_state = "kingyellow"
		if("Ithaqua")
			R.holy_book.icon_state = "ithaqua"
			R.holy_book.item_state = "ithaqua"
		if("Scientology")
			R.holy_book.icon_state = "scientology"
			R.holy_book.item_state = "scientology"
		if("The Bible melts")
			R.holy_book.icon_state = "melted"
			R.holy_book.item_state = "melted"
		if("Unaussprechlichen Kulten")
			R.holy_book.icon_state = "kulten"
			R.holy_book.item_state = "kulten"
		if("Necronomicon")
			R.holy_book.icon_state = "necronomicon"
			R.holy_book.item_state = "necronomicon"
		if("Book of Shadows")
			R.holy_book.icon_state = "shadows"
			R.holy_book.item_state = "shadows"
		if("Torah")
			R.holy_book.icon_state = "torah"
			R.holy_book.item_state = "torah"
		if("Burning")
			R.holy_book.icon_state = "burning"
			R.holy_book.item_state = "burning"
			R.holy_book.damtype = BURN
		if("Honk")
			R.holy_book.icon_state = "honkbook"
			R.holy_book.item_state = "honkbook"
		if("Ianism")
			R.holy_book.icon_state = "ianism"
			R.holy_book.item_state = "ianism"
		if("The Guide")
			R.holy_book.icon_state = "guide"
			R.holy_book.item_state = "guide"
		if("Slab")
			R.holy_book.icon_state = "slab"
			R.holy_book.item_state = "slab"
			R.holy_book.desc = "A bizarre, ticking device... That looks broken."
		if ("The Dokument")
			R.holy_book.icon_state = "gunbible"
			R.holy_book.item_state = "gunbible"
		else
			//If christian bible, revert to default
			R.holy_book.icon_state = "bible"
			R.holy_book.item_state = "bible"
			R.holy_book.desc = "Apply to head repeatedly."
			R.holy_book.damtype = BRUTE

// The list of all religions spacemen have designed, so far.
/datum/religion/default
	keys = list("christianity")
	converts_everyone = TRUE
	symbolstyle = 2
	bookstyle = "Bible"

/datum/religion/chaos
	name = "Chaos"
	deity_names = list("Khorne", "Nurgle", "Tzeentch", "Slaanesh")
	bible_names = list("Idiots Guide to Chaos")
	male_adept = "Apostate Preacher"
	female_adept = "Apostate Preacher"
	keys = list("Chaos Undivided")
	bookstyle = "Burning"

/datum/religion/khorne
	name = "Khorne"
	bible_names = list("How to Shed Blood")
	deity_names = list("Khorne")
	male_adept = "Apostate Preacher"
	female_adept = "Apostate Preacher"
	keys = list("Khorne")

/datum/religion/nurgle
	name = "Nurgle"
	bible_names = list("Bugchasing 101")
	deity_names = list("Nurgle")
	male_adept = "Apostate Preacher"
	female_adept = "Apostate Preacher"
	keys = list("Nurgle")

/datum/religion/tzeentch
	name = "Tzeentch"
	bible_names = list("Mathematics in the 41st Century")
	deity_names = list("Tzeentch")
	male_adept = "Apostate Preacher"
	female_adept = "Apostate Preacher"
	keys = list("Tzeentch")

/datum/religion/slaanesh
	name = "Slaanesh"
	bible_names = list("Hell IF I know")
	deity_names = list("Slaanesh")
	male_adept = "Apostate Preacher"
	female_adept = "Apostate Preacher"
	keys = list("Slaanesh")

/datum/religion/imperium
	name = "The Imperial Creed"
	deity_name = "God-Emperor of Mankind"
	bible_names = list("An Uplifting Primer", "Codex Astartes", "Codex Hereticus")
	male_adept = "Confessor"
	female_adept = "Prioress"
	keys = list("The Imperial Creed")

/datum/religion/retard/convertCeremony(var/mob/living/preacher, var/mob/living/subject)
	var/obj/structure/table/T = locate(/obj/structure/table/, oview(1, preacher)) // is there a table near us !
	if (!T)
		to_chat(preacher, "<span class='warning'>You need to stand next to a table!</span>")
		return FALSE
	if (!(T in oview(1, subject)))
		to_chat(preacher, "<span class='warning'>Your subject need to stand next to the same table as you.</span>")
		return FALSE

	T.MouseDropTo(O = preacher, user = preacher)
	var/message = pick(
		"\The [preacher] performs an ancient ritual to channel the essence of Brian Damag.",
		"\The [preacher] swiftly bangs their head against the table.",
		"\The [preacher] seems to be practising the art of table climbing. He looks very skilled at it.",
	)
	preacher.visible_message("<span class='notice'>[message]</span>")

	sleep(0.3 SECONDS) // Pause for laughter

	if (!convertCheck(subject))
		if (get_dist(subject, preacher) <= 2) // Let's not display that if the subject is too far away.
			subject.visible_message("<span class='notice'>Apparently unimpressed, \the [subject] refuses conversion.</span>")
		return FALSE

	// Conversion successful
	if (T in oview(1, subject))
		subject.visible_message("<span class='notice'>\The [subject] heartily follows \the [preacher]. [deity_name] gains a new adept today.</span>")
		T.MouseDropTo(O = subject, user = subject)
	else
		to_chat(subject, "<span class='warning'>You really wish to climb on that table, but you can't seem to remember where it was.</span>")
		to_chat(preacher, "<span class='warning'>The subject accepted, but he moved away from the table!</span>")
		return FALSE

	convert(subject, preacher)
	return TRUE

/datum/religion/retard/convert(var/mob/living/preacher, var/mob/living/subject, var/can_renounce = TRUE)
	. = ..()
	if (subject)
		subject.adjustBrainLoss(100) // Welcome to the club

/datum/religion/security
	name = "Security"
	deity_name = "Nanotrasen"
	bible_name = "Space Law"
	male_adept = "Nanotrasen Officer"
	female_adept = "Nanotrasen Officer"
	keys = list("security", "space law", "law", "nanotrasen", "centcomm")
	convert_method = "performing a ritual with a flashbang and a screwdriver. You need to hold the flashbang, with its timer set to 5 seconds, your convert needs to hold the screwdriver and have a free empty hand."
	preferred_incense = /obj/item/weapon/storage/fancy/incensebox/dense

/datum/religion/security/equip_chaplain(var/mob/living/carbon/human/H)
	H.equip_or_collect(new /obj/item/clothing/head/centhat(H), slot_head)

/datum/religion/security/convertCeremony(var/mob/living/preacher, var/mob/living/subject)
	var/held_banger = preacher.find_held_item_by_type(/obj/item/weapon/grenade/flashbang)
	if (!held_banger)
		to_chat(preacher, "<span class='warning'>You need to hold a flashbang to begin the conversion.</span>")
		return FALSE
	var/held_screwdriver = null
	for(var/obj/item/I in preacher.held_items)
		if(I.is_screwdriver(preacher))
			held_screwdriver = I
			break
	if (!held_screwdriver)
		to_chat(preacher, "<span class='warning'>The subject needs to hold a screwdriver to begin the conversion.</span>")
		return FALSE

	var/obj/item/weapon/grenade/flashbang/F = preacher.held_items[held_banger]
	var/obj/item/weapon/screwdriver/S = subject.held_items[held_screwdriver]

	if (F.det_time != 50) // The timer isn't properly set
		to_chat(preacher, "<span class='warning'>The timer in the flashbang isn't properly set up. Set it to 5 seconds.</span>")
		return FALSE

	subject.visible_message("<span class='notice'>\The [preacher] attemps to convert \the [subject] to [name].</span>")

	if(!convertCheck(subject))
		subject.visible_message("<span class='warning'>\The [subject] refuses conversion.</span>")
		return FALSE

	preacher.u_equip(F)

	// Everything is ok : begin the conversion
	if (!subject.put_in_hands(F))
		subject.visible_message("<span class='warning'>\The [subject] accepted conversion, but didn't manage to pick up the flashbang. How embarassing.</span>")
		return FALSE

	// BANGERBOIS WW@
	sleep(0.1 SECONDS)
	F.attackby(S, subject)
	sleep(0.1 SECONDS)
	F.attackby(S, subject)

	subject.visible_message("<span class='notice'>\The [subject] masterfully completed the delicate ritual. He's now a full-fledged follower of [deity_name].</span>")

	convert(subject, preacher)
	return TRUE

/datum/religion/cult
	name = "The Cult of Nar-Sie"
	deity_name = "Nar-Sie"
	bible_name = "The Arcane Tome"
	male_adept = "Cultist"
	female_adept = "Cultist"
	keys = list("cult", "narsie", "nar'sie", "narnar", "nar-sie", "papa narnar", "geometer", "geometer of blood")
	convert_method = "performing a ritual with a paper. The subject will need to stand a crayon-drawn rune."
	preferred_incense = /obj/item/weapon/storage/fancy/incensebox/moonflowers
	bookstyle = "Tome"

/datum/religion/cult/convertCeremony(var/mob/living/preacher, var/mob/living/subject)
	var/obj/effect/decal/cleanable/crayon/rune = locate(/obj/effect/decal/cleanable/crayon/, subject.loc)
	if (!rune)
		to_chat(preacher, "<span class='warning'>The subject needs to stand on a crayon-drawn rune.</span>")
		return FALSE
	var/held_paper = preacher.find_held_item_by_type(/obj/item/weapon/paper)
	if (!held_paper)
		to_chat(preacher, "<span class='warning'>You need to hold a sheet of paper to begin to convert.</span>")
		return FALSE

	subject.visible_message("<span class='notice'>\The [preacher] attemps to convert \the [subject] to [name].</span>")

	if(!convertCheck(subject))
		subject.visible_message("<span class='warning'>\The [subject] refuses conversion.</span>")
		return FALSE

	if (prob(10))
		preacher.say("DREAM SIGN: EVIL SEALING TALISMAN!")
		subject.Knockdown(1)

	sleep(0.2 SECONDS)

	subject.visible_message("<span class='notice'>\The [subject] accepted the ritual and is now a follower of [deity_name].</span>")
	convert(subject, preacher)

/datum/religion/guns
	name = "Murdercube"
	deity_name = "Gun Jesus"
	bible_name = "The Dokument"
	male_adept = "Kommando"
	female_adept = "Kommando"
	keys = list("murdercube","murderkube", "murder/k/ube","forgotten weapons", "gun", "guns", "ammo", "trigger discipline", "ave nex alea", "dakka")
	convert_method = "performing a ritual with a gun. The convert needs to be in good health and unafraid of being shot."
	preferred_incense = /obj/item/weapon/storage/fancy/incensebox/dense
	bookstyle = "The Dokument"

/datum/religion/guns/equip_chaplain(var/mob/living/carbon/human/H)
	H.equip_or_collect(new /obj/item/weapon/gun/energy/laser/practice)
	H.equip_or_collect(new /obj/item/clothing/under/syndicate, slot_w_uniform)
	H.equip_or_collect(new /obj/item/clothing/shoes/jackboots, slot_shoes)

/datum/religion/guns/convertCeremony(var/mob/living/preacher, var/mob/living/subject)
	var/held_gun = preacher.find_held_item_by_type(/obj/item/weapon/gun)

	if (!held_gun)
		to_chat(preacher, "<span class='warning'>You need to hold a gun to begin the conversion.</span>")
		return FALSE

	if(!convertCheck(subject))
		subject.visible_message("<span class='warning'>\The [subject] refuses conversion.</span>")
		return FALSE

	var/obj/item/weapon/gun/G = preacher.held_items[held_gun]

	sleep(0.1 SECONDS)
	if(G.canbe_fired())
		G.Fire(subject,preacher,0,0,1)
	else
		G.click_empty(preacher)
		return FALSE

	preacher.say("AVE NEX ALEA!")

	subject.visible_message("<span class='notice'>\The [subject] masterfully completed the delicate ritual. He's now a full-fledged follower of the [deity_name].</span>")

	convert(subject, preacher)
	return TRUE

