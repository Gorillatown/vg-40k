
/obj/machinery/computer/security/maintunnel
	name = "City Gate Camera Console"
	network = list(CAMERANET_MAINGATE)

/obj/machinery/computer/security/tunnelgate
	name = "Tunnel Gate Camera Console"
	network = list(CAMERANET_TUNNELGATE)


/obj/machinery/camera/citymaingate
	name = "City Main Gate"
	network = list(CAMERANET_MAINGATE)
	failure_chance = 0

/obj/machinery/camera/maintunnelgate
	name = "Main Tunnel Gate"
	network = list(CAMERANET_TUNNELGATE)
	failure_chance = 0
