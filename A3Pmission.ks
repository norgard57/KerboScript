set prelaunchmass to ship:mass.
lock percentleft to ( (prelaunchmass - ship:mass) / 100 ).

set countdown to 10.
set fthrot to 1.
set nothrot to 0.
lock throttle to nothrot.

until 0 {
	hudtext("T- " + countdown + "seconds.", 1, 2, 12, yellow, true).
	wait 1.
	set countdown to countdown - 1.
	if countdown = 2 { lock throttle to fthrot. }
		if countdown = 1 { rset(sas,"on"). }
			if countdown = 0 { stage. hudtext("LAUNCH", 5, 2, 12, red, true). return. }
}

wait 5.
ckstatus().