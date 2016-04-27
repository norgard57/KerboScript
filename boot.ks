//
// boot kerboscript regarding all rockets on the launchpad.
function main {
	bootset().
	gearset().
	termset().
	linit().
	set tstamp to time:seconds.
	sysset().
	ckstatus().
}
// Supporting functions follow
//

function bootset {
	set bstamp to time:seconds.
	// set rm to "booting".
}

function gearset {
	breaks off.
	panels off.
	lights off.
	gear off.
	rcs off.
	sas off.
}

function termset {
	set terminal:width to 53.
	set terminal:height to 55.
	clearscreen.
}

function linit {
	switch to 1.
	copy fs.fun from 0.
	run once fs.fun.
	delete fs.fun.
	getrun ("pr.fun").
	fget ("boot.ks",0,1).
}

function shutd {
	cleanup("set.ks").
	hudtext("I have been running for " + round(time:seconds-bstamp,1) + " seconds.", 10, 2, 12, red, true).
	return.
}

function pr {
	parameter quo, amt, col, row.
	print quo + amt at (col,row).
}

main().