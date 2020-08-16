/mob/living/eventmob					//for ease of coding. Just in case we want to use this type in the future
	name = "A familiar voice"
	icon = 'icons/mob/mob.dmi'
	icon_state = "blank"

/mob/living/eventmob/darkeldarone

/mob/living/eventmob/darkeldarone/New()
	src.say("I've been watching you my entire life. I hate the air you breathe, your foolish decrees, your words so contrived and I hate the way our kin gathered outside. The Farseer told you to beware the iceworld and I'd be lying if I said I wasn't wishing for your untimely death or demise or am I just wishing I could be like you? That the Archon would see me as a poet and not just the muse.")
	qdel(src)

/mob/living/eventmob/darkeldartwo

/mob/living/eventmob/darkeldartwo/New()
	src.say("Oh it's not true, I don't wish harm upon you. From birth we've been like family, of different mothers. Frater meus. You're beautifully made and to you I'm forever grateful. I'll never forget that you showed me to make art and I know the love you showed me came from a pure and noble heart. I love you and if you want I'll call you kind. BUT WHY do I lie awake each night thinking instead of you, it should be me?")
	qdel(src)

/mob/living/eventmob/darkeldarthree

/mob/living/eventmob/darkeldarthree/New()
	src.say("Something wicked this way comes and as I set to face it I'm unsure. Should I embrace it? Should I run? What motivates me - hatred or is it love? What's more wrong, that I too wish to be great or my dark mother wished SHE'D HAD A SON?! Maybe my name could also be known... that I helped return good to our people and restored greatness to the Kabal!!")
	qdel(src)

/mob/living/eventmob/darkeldarfour

/mob/living/eventmob/darkeldarfour/New()		//This reminds me a lot of the character Szeth-son-son-Vallano
	src.say("My name is Merithera and my name means heavy so with a heavy heart I'll guide this dagger into the heart of my enemy MY WHOLE LIFE YOU WERE A TEACHER and friend to me PLEASE KNOW my actions are not motivated only by envy. I TOO HAVE A DESTINEY!!! THIS DEATH WILL BE ART!!! THIS EVENT WILL BE HISTORY!! AND I'LL BE GREAT TOO!!!")
	qdel(src)


/mob/living/simple_animal/hostile/faithless/harlequin //A spooky shade that takes your appearance after it attacks you the first time.
	name = "shade"
	desc = "Some kind of creature from the warp..."
	maxHealth = 130
	health = 130
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attacktext = "bites"
	var/transformed = 0

/mob/living/simple_animal/hostile/faithless/harlequin/AttackingTarget()
	..()
	if(!transformed && ishuman(target))
		var/mob/living/carbon/human/H = target
		src.visible_message("<span class='warning'> The [src]'s form flickers!</span>")
		transformed = 1
		src.icon = H.icon
		src.icon_state = H.icon_state
		src.overlays = H.overlays
		src.name = H.name
		attacktext = "stabs"
	else if(transformed && prob(25))
		src.visible_message("<span class='warning'> [src] darts away!</span>")
		var/list/posturfs = circlerangeturfs(get_turf(src),3)
		var/turf/destturf = safepick(posturfs)
		src.loc = destturf
		var/area/destarea = get_area(destturf)
		destarea.Entered(src)

/mob/living/simple_animal/hostile/faithless/harlequin/Life()
	..()
	if(stat == 2)
		src.visible_message("<span class='warning'> [src] disintegrates in a plume of smoke!</span>")
		new /obj/item/weapon/ectoplasm(loc)
		qdel(src)
		return
	else
		if(transformed && prob(5))
			src.visible_message("<span class='warning'> [src] darts away!</span>")
			var/list/posturfs = circlerangeturfs(get_turf(src),3)
			var/turf/destturf = safepick(posturfs)
			src.loc = destturf
			var/area/destarea = get_area(destturf)
			destarea.Entered(src)