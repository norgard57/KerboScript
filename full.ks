// ----+----+----+
// boot kerboscript regarding all rockets on the launchpad.
function main {
	termset().
	bootset().
	bootstamp().
	timestamp().
	ckstatus().
}
// Supporting functions follow
// ----+----+----+


// ----+----+----+
// File Functions following
function fget { parameter file, get, put. switch to get. if exists (file) = true { switch to put. copy file from get. } else pr ("The file " + file + " , is not available on " + get + ".",). }
function frun { parameter file. fclean ("temp.ks"). flog ("run " + file + ".","temp.ks",1). run temp.ks. fclean ("temp.ks"). }
function flog { parameter message, file, location. switch to location. log message to file. }
function fclean { parameter file. if exists(file) = true { delete file. } else return. }
// function fboot { parameter file. fget(file,0,1). frun(file). }

// End File Functions
// ----+----+----+


// ----+----+----+
// Display and Logging Functions
function pr { parameter quo, amt, col, row. print quo + amt at (col,row). }
// End Display and Logging Functions
// ----+----+----+


// ----+----+----+
// Lexicon Functions
function lexadd { parameter lexi, a, b. lexi:add (a,b). }
function lexsave { parameter lexi, file, location. switch to location. fclean (file). log lexi to file. }
// End Lex Functions
// ----+----+----+


// ----+----+----+
// system settings
function bootstamp { set bstamp to time:seconds. lexadd (comcon,"bstamp",bstamp). }
function timestamp { set tstamp to time:seconds. lexadd (comcon,"tstamp",tstamp). }
function termset { set terminal:width to 53. set terminal:height to 55. clearscreen. }
function shutdown { hudtext("I have been running for " + round(time:seconds-bstamp,1) + " seconds.", 10, 2, 12, red, true). return. }
// end system setings
// ----+----+----+


// ----+----+----+
// assists in replacing sysset function
function bootset {
	set comcon to lexicon().
	lexadd (breaks,off).
	lexadd (panels,off).
	lexadd (lights,off).
	lexadd (gear,off).
	lexadd (rcs,off).
	lexadd (sas,off).
}
function bset {
	parameter lexi,a,b,file,location.
	lexadd (lexi,a,b).
	lexsave (lexi,file,location).
}
// ----+----+----+


function ckstatus {
	// Cheack Status
	
	function run_mission {
		parameter title,sufix.
		if status = title {
			set rex to ship:name + sufix.
			fget (rex).
			timestamp().
			frun (rex).
		} 
		if else return.
	}

	run_mission("PRELAUNCH","pre.ks").
	run_mission("FLYING","fly.ks").
	run_mission("SUB_ORBITAL","sub.ks").
	run_mission("ORBITING","orb.ks").
	run_mission("LANDED","lan.ks").
	run_mission("SPLASHED","spl.ks").
	shutdown().
}




// ----+----+----+
// Human Readable Terminal Output (HRTO)
function hrto {
	
	set pl to 1.
	prpotential(pl).
	pratmo(pl).
	prship(pl).
	pralt(pl).
	prpos(pl).
	prapo(pl).
	prperi(pl).
	precc(pl).
	prspd(pl).
	pratmo(pl).
	prbody(pl).
}

function prpos {
	// Position
	parameter pl. // Print Location pl
	pr ("POS:LAT : ",round(latitude,2),2,pl).
	pr ("POS:LONG: ",round(longitude,2),30,pl).
	return (pl+2).
}

function pralt {
	// Altitude
	parameter pl.
	pr ("ALT:SEA : ",round(altitude,2),2,pl).
	pr ("ALT:GRND: ",round(alt:radar,2),30,pl).
	return (pl+2).
}

function prapo {
	// Apoapsis
	parameter pl.
	pr ("ALT:APO : ",round(alt:apoapsis),2,pl).
	pr ("ETA:APO : ",round(eta:apoapsis),30,pl).
	return (pl+2).
}

function prperi {
	// Periapsis
	parameter pl.
	pr ("ALT:PERI: ",round(alt:periapsis),2,pl).
	pr ("ETA:PERI: ",round(eta:periapsis),30,pl).
	return (pl+2).
}

function precc {
	// Eccentricity
	parameter pl.
	pr ("ECC:    : ",round( ( alt:apoapsis-alt:periapsis ) / ( (2*body:radius)+(alt:apoapsis)+(alt:periapsis) ) ,2),2,pl).
	return (pl+2).
}

function prspd {
	//Speed
	parameter pl.
	pr ("SPD:VERT: ",round(verticalspeed),2,pl).
	set pl to pl + 1.
	pr ("SPD:AIR : ",round(airspeed),2,pl).
	set pl to pl + 1.
	pr ("SPD:GRND: ",round(groundspeed),2,pl).
	return (pl+2).
}

function pratmo {
	// Atmosphere
	parameter pl.
	pr ("ATM:EXST: ",body:atm:exists,2,pl).
	pr ("OXY:EXST: ",body:atm:oxygen,30,pl).
	set pl to pl + 1.
	pr ("PRES:SEN: ",round(ship:sensors:pres,6),2,pl).
	pr ("PRES:DYN: ",round(ship:dynamicpressure,6),30,pl).
	set pl to pl + 1.
	pr ("PRES:SEA: ",round(body:atm:sealevelpressure,6),2,pl).
	pr ("ATM:HGHT: ",round(body:atm:height,6),30,pl).
	return (pl+2).

}

function prship {
	// Ship
	parameter pl.
	pr ("SHIP:NAME:",ship:name,2,pl).
	pr ("CREW:CAP: ",round(ship:crewcapacity,6),30,pl).
	set pl to pl + 1.
	pr ("            ","                    ",0,pl).
	pr (body:name,status,2,pl).
	set pl to pl + 1.
	pr ("MAX:THR : ",round(ship:maxthrust,6),2,pl).
	pr ("AVL:THR : ",round(ship:availablethrust,6),30,pl).
	set pl to pl + 1.
	pr ("HEADING : ",round(ship:bearing,6),2,pl).
	pr ("BEARING : ",round(ship:heading,6),30,pl).
	set pl to pl + 1.
	pr ("ACC:MAG : ",round(ship:sensors:acc:mag,6),2,pl).
	pr ("GRAV:MAG: ",round(ship:sensors:grav:mag,6),30,pl).
	return (pl+2).
}

function prbody {
	// Body
	parameter pl.
	pr ("BODY:NAM: ",body:name,2,pl).
	pr ("BODY:ALT: ",round(body:altitude,6),30,pl).
	set pl to pl + 1.
	pr ("ANGL:VEL: ",round(body:angularvel:mag,6),2,pl).
	pr ("ROT:ANGL: ",round(body:rotationangle,6),30,pl).
	set pl to pl + 1.
	pr ("BODY:RAD: ",round(body:radius),2,pl).
	pr ("BODY:ROT: ",round(body:rotationperiod),30,pl).
	set pl to pl + 1.
	pr ("LAT:LNG : ",body:geoposition,2,pl).
	set pl to pl + 1.
	pr ("SOI:RADI: ",round(body:soiradius),2,pl).
	set pl to pl + 1.
	pr ("BODY:MAS: ",round(body:mass,2),2,pl).
	set pl to pl + 1.
	pr ("BODY:MU : ",round(body:mu,6),2,pl).
	set pl to pl + 1.
	pr ("DESCRIPT: ",body:description,2,pl).
}

function prpotential {
	// Resources
	parameter pl.
	// TODO: create resource list from parts
	// include fuel per stage (total,left,percent-spent), power, peroxide, etc
	pr ("MASS:WET: ",round(ship:wetmass,6),2,pl).
	pr ("MASS:DRY: ",round(ship:drymass,6),30,pl).
	set pl to pl + 1.
	pr ("MASS:NOW: ",round(ship:mass,6),2,pl).
	pr ("MASS:SPT: ",round(ship:wetmass-ship:mass,6),30,pl).
	return (pl+2).
}
// End HRTO


main().