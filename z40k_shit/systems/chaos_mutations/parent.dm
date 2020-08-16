/*
A chaos mutation system.
Mutations will have datums to sort and handle them (I like datums lol)
This will also sort what type of mutation it is (ex general chaos mutation, slaanesh mutation, et cetera)
Most mutations will work either by applying an overlay (a feature built into the mutation datum, I will need to implement this in human code), creating an item (for example, the tentacles item or an arm blade), and/or editing existing variables in the mob.
*/
//The update icon segment of this dumb shit is in like code\modules\mob\living\carbon\human\update_icons.dm : line 406 update_mutations
/datum/mutation
	var/name = "chaos mutation"
	var/desc = "This should probably not exist."
	var/icon_state //Takes a string, its the icon state. The actual icon file is 'z40k_shit/icons/mutations.dmi'
	var/mob/living/carbon/human/holder
	var/overlay = FALSE //IF True its a overlay, if False its a underlay

/datum/mutation/proc/init_mob(var/mob/living/carbon/human/H)
	holder = H
	H.warp_mutations.Add(src)
	return

/datum/mutation/slaanesh
	name = "slaanesh mutation"

/datum/mutation/khorne
	name = "khorne mutation"

/datum/mutation/nurgle
	name = "nurgle mutation"

/datum/mutation/tzeench
	name = "tzeench mutation"

/datum/mutation/malal
	name = "malal mutation"

/datum/mutation/undivided
	name = "chaos undivided mutation"

/datum/mutation/xeno
	name = "xeno mutation"

/datum/mutation/generic
	name = "generic mutation"

/mob/living/carbon/human/proc/mutate(var/mutation_type = null)
	if(!mutation_type)
		var/path = pick(typesof(/datum/mutation/))
		var/datum/mutation/M = new path()
		M.init_mob(src)
		update_mutations()
		return
	switch(mutation_type)
		if("slaanesh")
			var/path = pick(typesof(/datum/mutation/slaanesh) - /datum/mutation/slaanesh)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("khorne")
			var/path = pick(typesof(/datum/mutation/khorne) - /datum/mutation/khorne)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("nurgle")
			var/path = pick(typesof(/datum/mutation/nurgle) - /datum/mutation/nurgle)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("tzeench")
			var/path = pick(typesof(/datum/mutation/tzeench) - /datum/mutation/tzeench)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("undivided")
			var/path = pick(typesof(/datum/mutation/undivided) - /datum/mutation/undivided)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("malal")
			var/path = pick(typesof(/datum/mutation/malal) - /datum/mutation/malal)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("xeno")
			var/path = pick(typesof(/datum/mutation/xeno) - /datum/mutation/xeno)
			var/datum/mutation/M = new path()
			M.init_mob(src)
		if("mark of slaanesh")
			var/datum/mutation/slaanesh/mark/M = new()
			M.init_mob(src)
		if("tentacle mutation")
			var/datum/mutation/slaanesh/tentacles/M = new()
			M.init_mob(src)
		if("red eyes")
			var/datum/mutation/undivided/redeyes/M = new()
			M.init_mob(src)
		if("arcane glow")
			var/datum/mutation/tzeench/glow/M = new()
			M.init_mob(src)
		if("rot")
			var/datum/mutation/nurgle/rot/M = new()
			M.init_mob(src)
		if("flies")
			var/datum/mutation/nurgle/flies/M = new()
			M.init_mob(src)
		if("bloody")
			var/datum/mutation/khorne/bloody/M = new()
			M.init_mob(src)
		if("kflames")
			var/datum/mutation/khorne/flame/M = new()
			M.init_mob(src)
		if("tflames")
			var/datum/mutation/tzeench/flame/M = new()
			M.init_mob(src)
		if("chains")
			var/datum/mutation/undivided/chains/M = new()
			M.init_mob(src)
/*		if("addiction")
			var/datum/mutation/slaanesh/addiction/M = new()
			M.init_mob(src)*/
		if("goldenglow")
			var/datum/mutation/generic/glow/M = new()
			M.init_mob(src)
	update_mutations()

/mob/living/carbon/human/proc/make_chaos_spawn(var/chaosgod = null)
	if(!chaosgod)
		chaosgod = pick("slaanesh, nurgle, tzeench", "khorne")
	var/list/mutations = list()
	switch(chaosgod)
		if("slaanesh")
			mutations = list(/datum/mutation/slaanesh/mark, /datum/mutation/slaanesh/tentacles, /datum/mutation/undivided/redeyes)
		if("nurgle")
			mutations = list(/datum/mutation/nurgle/rot, /datum/mutation/nurgle/flies, /datum/mutation/undivided/redeyes)
		if("tzeench")
			mutations = list(/datum/mutation/tzeench/flame, /datum/mutation/undivided/redeyes, /datum/mutation/undivided/chains)
		if("khorne")
			mutations = list(/datum/mutation/khorne/bloody, /datum/mutation/khorne/flame, /datum/mutation/undivided/redeyes)
	for(var/path in mutations)
		var/datum/mutation/M = locate(path) in src
		if(!M)
			M = new path()
			M.init_mob(src)
	update_mutations()
	src.visible_message("<span class='warning'> [src] is entirely consumed by the powers of chaos!</span>")
	src.ghostize(0)
//	src.berserk = 1
//	src.berserkmaster = chaosgod

