hudtext(percentleft,1,2,12,yellow,true).
set thisthrot to 1.
lock throttle to thisthrot.

function climb {
	parameter targetalt, tangle, hspeed, lspeed.
	until altitude = targetalt {
		hrto().
		lock steering to (90,tangle).
		if airspeed > hspeed { set thisthrot to thisthrot - 0.5. wait 2.}
			if airspeed < lowspeed { set thisthrot to thisthrot + 0.5. wait 2.}
		wait 0.5.
	}
}

climb (1000,90,300,75).
climb (2000,88,300,200).
climb (5000,85,300,250).
climb (10000,80,500,275).
climb (18000,75,700,400).
climb (28000,55,1200,700).
climb (50000,45,2500,1000).
climb (70000,0,3400,1200).
set thisthrot to 0.
wait 10.
ckstatus().