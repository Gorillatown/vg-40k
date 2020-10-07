var/global/current_date_string
var/global/num_financial_terminals = 1
var/global/num_financial_database = 1
var/global/num_vending_machines = 1
var/global/num_pda_terminals = 1
var/global/num_merch_computers = 1
var/global/datum/money_account/station_account
var/global/list/datum/money_account/department_accounts = list()
var/global/next_account_number = 0
var/global/obj/machinery/account_database/centcomm_account_db
var/global/datum/money_account/vendor_account
var/global/list/all_money_accounts = list()
var/global/datum/money_account/trader_account
var/global/allowable_payroll_amount = DEPARTMENT_START_WAGE*8 //Station, command, engineering, medical, security, science, cargo, and civilian

/proc/create_station_account()
	if(!station_account)
		next_account_number = rand(11111, 99999)
		station_account = new()
		station_account.owner_name = "[station_name()] Detroid-Mannheim Account"
		station_account.account_number = rand(11111, 99999)
		station_account.remote_access_pin = rand(1111, 9999)
		station_account.money = DEPARTMENT_START_FUNDS
		station_account.wage_gain = DEPARTMENT_START_WAGE

		//create an entry in the account transaction log for when it was created
		var/datum/transaction/T = new()
		T.target_name = station_account.owner_name
		T.purpose = "Account creation"
		T.amount = 0
		T.date = "2nd April, [game_year]"
		T.time = "11:24"
		T.source_terminal = "Biesel GalaxyNet Terminal #277"

		//add the account
		station_account.transaction_log.Add(T)
		all_money_accounts.Add(station_account)

/proc/create_department_account(department, var/recieves_wage = 0)
	next_account_number = rand(111111, 999999)

	var/datum/money_account/department_account = new()
	department_account.owner_name = "[department] Account"
	department_account.account_number = rand(11111, 99999)
	department_account.remote_access_pin = rand(1111, 9999)
	department_account.money = DEPARTMENT_START_FUNDS
//	if(recieves_wage == 1)
//		department_account.wage_gain = DEPARTMENT_START_WAGE

	//create an entry in the account transaction log for when it was created
	var/datum/transaction/T = new()
	T.target_name = department_account.owner_name
	T.purpose = "Account creation"
	T.amount = department_account.money
	T.date = "2nd April, [game_year]"
	T.time = "11:24"
	T.source_terminal = "Detroid Terminal #277"

	//add the account
	department_account.transaction_log.Add(T)
	all_money_accounts.Add(department_account)

	department_accounts[department] = department_account

//the current ingame time (hh:mm) can be obtained by calling:
//worldtime2text()

/proc/create_account(var/new_owner_name = "Default user", var/starting_funds = 0, var/obj/machinery/account_database/source_db, var/wage_payout = 0, var/security_pref = 1, var/makehidden = FALSE)

	//create a new account
	var/datum/money_account/M = new()
	M.owner_name = new_owner_name
	M.remote_access_pin = rand(1111, 9999)
	M.money = starting_funds
	M.wage_gain = wage_payout
	M.security_level = security_pref
	M.hidden = makehidden

	//create an entry in the account transaction log for when it was created
	var/datum/transaction/T = new()
	T.target_name = new_owner_name
	T.purpose = "Account creation"
	T.amount = starting_funds
	if(!source_db)
		//set a random date, time and location some time over the past few decades
		var/DD = text2num(time2text(world.timeofday, "DD"))											//For muh lore we'll pretend that Nanotrasen changed its account policy
		T.date = "[(DD == 1) ? "31" : "[DD-1]"] [time2text(world.timeofday, "Month")], [game_year]"	//shortly before the events of the round,
		T.time = "[rand(0,24)]:[rand(11,59)]"														//prompting everyone to get a new account one day prior.
		T.source_terminal = "NTGalaxyNet Terminal #[multinum_display(rand(111,1111),4)]"								//The point being to partly to justify the transaction history being empty at the beginning of the round.

		M.account_number = rand(11111, 99999)
	else
		T.date = current_date_string
		T.time = worldtime2text()
		T.source_terminal = source_db.machine_id

		M.account_number = next_account_number
		next_account_number += rand(1,25)

		//create a sealed package containing the account details
		var/obj/item/delivery/P = new /obj/item/delivery(source_db.loc)

		var/obj/item/weapon/paper/R = new /obj/item/weapon/paper(P)
		R.name = "Account information: [M.owner_name]"

		R.info = {"<b>Account details (confidential)</b><br><hr><br>
			<i>Account holder:</i> [M.owner_name]<br>
			<i>Account number:</i> [M.account_number]<br>
			<i>Account pin:</i> [M.remote_access_pin]<br>
			<i>Starting balance:</i> $[M.money]<br>
			<i>Date and time:</i> [worldtime2text()], [current_date_string]<br><br>
			<i>Creation terminal ID:</i> [source_db.machine_id]<br>
			<i>Authorised NT officer overseeing creation:</i> [source_db.held_card.registered_name]<br>"}
		//stamp the paper
		var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
		stampoverlay.icon_state = "paper_stamp-cent"
		if(!R.stamped)
			R.stamped = new
		R.stamped += /obj/item/weapon/stamp
		R.overlays += stampoverlay
		R.stamps += "<HR><i>This paper has been stamped by the Accounts Database.</i>"

	//add the account
	M.transaction_log.Add(T)
	all_money_accounts.Add(M)

	return M
