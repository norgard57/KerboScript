function fprep {
	parameter fil, fro, des.
	switch to des.
	cleanup (fil).
	switch to fro.
	if exists(fil) = true { copy fil to des. return. }
	else { hudtext("Bro: The File " + fil + " Does Not Exist at: " + fro, 20, 2, 12, red, true). }
}

function cleanup {
	parameter fil.
	if exists(fil) = true {
		delete fil.
	}
	return.
}

function rset {
	parameter a, b.
	switch to 1.
	run set.ks.
	set a to b.
	setlog().
}

function fget {
	// get the file
	parameter fil,fro,des.
	switch to fro.
	if exists(fil) = true { copy fil to des. switch to des. }
	else hudtext("Friend: The File " + fil + " Does Not Exist.", 20, 2, 12, green, true).
}

function getrun {
	parameter fil.
	fget (fil,0,1).
	switch to 1.
	cleanup ("temp.ks").
	log "run " + fil + "." to temp.ks.
	run temp.ks.
	delete temp.ks.
}

function setlog {
	// log "set shipalias to "+shipalias+"." to set.ks.
	log "set bstamp to "+bstamp+"." to set.ks.
	log "set tstamp to "+tstamp+"." to set.ks.
	log "set lights to "+lights+"." to set.ks.
	log "set gear to "+gear+"." to set.ks.
	log "set breaks to "+breaks+"." to set.ks.
	log "set panels to "+panels+"." to set.ks.
	log "set sas to "+sas+"." to set.ks.
	log "set rcs to "+rcs+"." to set.ks.
}

function sysset {
	switch to 1.
	if exists("set.ks") = true { run set.ks. hudtext("Normilized are settings.", 10, 2, 12, green, true). return. }
	else {
		set shipalias to ship:name.
		setlog().
		hudtext("Setings are nominal.", 10, 2, 12, green, true).
		hudtext("Done Booting.", 10, 2, 12, green, true).
		return.
	}
}

function ckstatus {
	// Cheack Status
	if status = "PRELAUNCH" {
		set ship:name to shipalias + "P".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
	if status = "FLYING" {
		set ship:name to shipalias + "F".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
	if status = "SUB_ORBITAL" {
		set ship:name to shipalias + "S".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
	if status = "ORBITING" {
		set ship:name to shipalias + "O".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
	if status = "LANDED" {
		set ship:name to shipalias + "L".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
	if status = "SPLASHED" {
		set ship:name to shipalias + "D".
		set rex to ship:name + "mission.ks".
		getrun (rex).
	}
}