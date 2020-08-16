
/obj/effect/landmark/start
	name = "start"
	icon = 'z40k_shit/icons/40klandmarks.dmi'
	icon_state = "x"
	anchored = 1.0
	landmark_override = TRUE
	invisibility = 101

/obj/effect/landmark/start/New()
	..()

//Observer Start
/obj/effect/landmark/observer
	name = "Observer-Start"

/obj/effect/landmark/latejoin
	name = "JoinLate"
	//Place where latejoins end up

/obj/effect/landmark/latejoin/New()
	..()
	latejoin += loc
	qdel(src)

/obj/effect/landmark/newplayerstart //Basically spawnbox, mobs load in here and move to other locs
	name = "start"					//Also handles the lobby screen area

/obj/effect/landmark/newplayerstart/New()
	..()
	newplayer_start += loc
	qdel(src)

//RNG Animals
/obj/effect/landmark/start/rng_animals
	name = "(RNG) Animals"
	icon_state = "rng_animals"

//PDF
/obj/effect/landmark/start/lord
	name = "Lord"
	icon_state = "pdf_lord"

/obj/effect/landmark/start/knight_officer
	name = "Knight Officer"
	icon_state = "pdf_knight"

/obj/effect/landmark/start/patrolman
	name = "Patrolman"
	icon_state = "pdf_patrolman"

//Imperial Guard
/obj/effect/landmark/start/general
	name = "General"
	icon_state = "general"

/obj/effect/landmark/start/commissar
	name = "Commissar"
	icon_state = "commissar"

/obj/effect/landmark/start/sister_hospitaller
	name = "Sister Hospitaller"
	icon_state = "hospitaller"

/obj/effect/landmark/start/inquisitor
	name = "Inquisitor"
	icon_state = "inquisitor"

/obj/effect/landmark/start/preacher
	name = "Preacher"
	icon_state = "preacher"

/obj/effect/landmark/start/IG_Cadian_Sergeant
	name = "Sergeant"
	icon_state = "cadian_trooper_sgt"

/obj/effect/landmark/start/IG_Cadian_Weapon_Specialist
	name = "Weapon Specialist"
	icon_state = "cadian_specialist"

/obj/effect/landmark/start/IG_Cadian_Trooper
	name = "Trooper"
	icon_state = "cadian_trooper"

/obj/effect/landmark/start/primaris_psyker
	name = "Primaris Psyker"
	icon_state = "primaris_psyker"

//Orks
/obj/effect/landmark/start/basicOrk
	name = "(RNG) Various Orks"
	icon_state = "basic_ork"
 
/obj/effect/landmark/start/orknob
	name = "Ork Nob"
	icon_state = "ork_nob"

/obj/effect/landmark/start/orkboss
	name = "Ork Warboss"
	icon_state = "ork_warboss"

/obj/effect/landmark/start/orkmek
	name = "Mek"
	icon_state = "ork_mek"

/obj/effect/landmark/start/orktankbusta
	name = "Ork Tankbusta"
	icon_state = "ork_tankbusta"

/obj/effect/landmark/start/orkgretchin
	name = "Gretchin"
	icon_state = "ork_gretchin"

//Civilians
/obj/effect/landmark/start/assistant
	name = "Peasant"
	icon_state = "civ_assistant"

/obj/effect/landmark/start/bartender
	name = "Bartender"
	icon_state = "civ_bartender"

/obj/effect/landmark/start/clown
	name = "Celebrity"
	icon_state = "civ_clown"

/obj/effect/landmark/start/mime
	name = "Mime"
	icon_state = "civ_mime"

/obj/effect/landmark/start/chef
	name = "Chef"
	icon_state = "civ_chef"

/obj/effect/landmark/start/doctor
	name = "Medical Doctor"
	icon_state = "civ_doctor"

/obj/effect/landmark/start/janitor
	name = "Janitor"
	icon_state = "civ_janitor"

