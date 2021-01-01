/obj/item/weapon/circuitboard/autominer
	name = "Circuit Board (Drilling Machine)"
	desc = "A circuit board used to build a machine that drills for ore."
	build_path = /obj/machinery/machine_miner
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/capacitor = 2,
							/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/circuitboard/signal_light
	name = "Circuit Board (Signal Light)"
	desc = "A circuit board used to run a small device that signals frequencies under a ID tag."
	build_path = /obj/machinery/signal_lights
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 1,
							/obj/item/weapon/stock_parts/capacitor = 1)

/obj/item/weapon/circuitboard/splitter
	name = "Circuit Board (Splitter)"
	desc = "A circuit board used to run a container that splits objects."
	build_path = /obj/machinery/splitter
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/circuitboard/stamp_molder
	name = "Circuit Board (Stamp Molder)"
	desc = "A circuit board used to build a machine that assembles objects/stamps metal."
	build_path = /obj/machinery/stamp_molder
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 1,
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/circuitboard/furnace
	name = "Circuit Board (Furnace)"
	desc = "A circuit board used to build a machine that processes ore into metal sheets."
	build_path = /obj/machinery/furnace
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/matter_bin = 1)

/obj/item/weapon/circuitboard/bumper_control_point
	name = "Circuit Board (Bumper Control Point)"
	desc = "A circuit board used to build a machine that controls moving a single object."
	build_path = /obj/machinery/bumper_control_point
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/capacitor = 1)

/obj/item/weapon/circuitboard/bumper_redirector
	name = "Circuit Board (Bumper Redirector)"
	desc = "A circuit board used to build a machine that redirects a moving object."
	build_path = /obj/machinery/bumper_redirector
	board_type = MACHINE
	origin_tech = Tc_MATERIALS + "=2;" + Tc_ENGINEERING + "=2;" + Tc_POWERSTORAGE + "=3"
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/capacitor = 1)


