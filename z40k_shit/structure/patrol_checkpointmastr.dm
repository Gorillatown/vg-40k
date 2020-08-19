/*
Notes:
Unlike most other things, I decided I was going to play around with NanoUI
Theres still room for improvement here, like adding signal strength based on get_dist value so people know the distance.
Along with like showing the last person to actually use the checkpoint.
*/
/obj/structure/patrol_checkpoint_master
	name = "Checkpoint Console"
	icon = 'z40k_shit/icons/obj/64xstructures.dmi'
	icon_state = "ob1"
	desc = "Unlike the other consoles which it looks identical to, this one just shows you which checkpoints haven't been visited."
	density = 1
	anchored = 1

/obj/structure/patrol_checkpoint_master/ex_act(severity)
	return

/obj/structure/patrol_checkpoint_master/New()
	..()
	set_light(3, 3, "#0afd01")

/obj/structure/patrol_checkpoint_master/initialize()
	..()

/obj/structure/patrol_checkpoint_master/Destroy()
	..()

/obj/structure/patrol_checkpoint_master/attack_hand(mob/user)
	ui_interact(user)

/obj/structure/patrol_checkpoint_master/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = NANOUI_FOCUS)
	var/data[0]

	var/checkpoints_data[0]
	for(var/obj/structure/patrol_checkpoint/PC in patrol_checkpoints)
		checkpoints_data.Add(list(list("name" = PC.location, "time" = PC.time_left)))
	data["checkpoints"] = checkpoints_data

	// update the ui if it exists, returns null if no ui is passed/found
	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "patrol_checkmaster.tmpl", "Checkpoint Monitor", 400, 500)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()
		// auto update every Master Controller tick
		ui.set_auto_update(1)

/obj/structure/patrol_checkpoint_master/attackby(obj/item/weapon/W, mob/user)
	..()


