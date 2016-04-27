function hrto {
	// Human Readable Terminal Output (HRTO)
	
	prpotential(1).
	pratmo(4).
	prship(8).
	pralt(13).
	prpos(20).
	prapo(15).
	prperi(16).
	precc(19).
	prspd(25).
	pratmo(21).
	prbody(30).
}

function prpos {
	// Position
	parameter pl. // Print Location pl
	pr ("POS:LAT : ",round(latitude,2),2,pl).
	pr ("POS:LONG: ",round(longitude,2),30,pl).
}

function pralt {
	// Altitude
	parameter pl.
	pr ("ALT:SEA : ",round(altitude,2),2,pl).
	pr ("ALT:GRND: ",round(alt:radar,2),30,pl).
}

function prapo {
	// Apoapsis
	parameter pl.
	pr ("ALT:APO : ",round(alt:apoapsis),2,pl).
	pr ("ETA:APO : ",round(eta:apoapsis),30,pl).
}

function prperi {
	// Periapsis
	parameter pl.
	pr ("ALT:PERI: ",round(alt:periapsis),2,pl).
	pr ("ETA:PERI: ",round(eta:periapsis),30,pl).
}

function precc {
	// Eccentricity
	parameter pl.
	pr ("ECC:    : ",round( ( alt:apoapsis-alt:periapsis ) / ( (2*body:radius)+(alt:apoapsis)+(alt:periapsis) ) ,2),2,pl).
}

function prspd {
	//Speed
	parameter pl.
	pr ("SPD:VERT: ",round(verticalspeed),2,pl).
	set pl to pl + 1.
	pr ("SPD:AIR : ",round(airspeed),2,pl).
	set pl to pl + 1.
	pr ("SPD:GRND: ",round(groundspeed),2,pl).
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
}