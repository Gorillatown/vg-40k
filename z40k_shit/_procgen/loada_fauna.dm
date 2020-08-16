//Some Fauna I guess.
//Yet another worldscan
/datum/loada_gen/proc/loada_fauna()
	for(var/turf/T in world)
		if(prob(1))
			if(istype(T, /turf/unsimulated/outside/sand)) //If we are outside.
				if(prob(10))
					if(prob(10))
						if(prob(50))
							new /obj/abstract/map/spawner/mobs/wolf(T)
							continue
						else
							new /obj/abstract/map/spawner/mobs/deer(T)
							continue
					else
						continue
				else
					continue
			if(istype(T,/turf/unsimulated/outside/smoothingcoastline))
				if(prob(80))
					new /obj/abstract/map/spawner/mobs/spider(T)
					continue
				else
					new /obj/abstract/map/spawner/mobs/humanoid/wiz(T)
					continue
			if(istype(T,/turf/unsimulated/outside/water))
				if(prob(25))
					new /obj/abstract/map/spawner/mobs/lizard(T)