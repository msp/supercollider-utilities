(
OSCdef.new(
	\foo2,
	{
		arg msg, time, addr, port;
		[msg, time, addr, port].postln;
	}
	, '/2/multitoggle1/1/1'
)
)

(
OSCdef.new(
	\foo3,
	{
		arg msg, time, addr, port;
		[msg, time, addr, port].postln;
	}
	, '/2/Group outs/1'
)
)


(
OSCdef.new(
	\tidal_max,
	{
		arg msg, time, addr, port;
		[msg].postln;
	}
	, '/fromTidal/3'
)
)

(
OSCdef.new(
	\tidal_debug,
	{
		arg msg, time, addr, port;
		// [msg[9],msg[10]].postln;
		[msg].postln;
	}
	, '/play2'
)
)


(
OSCdef.freeAll
)

// SC Lang
NetAddr.langPort  // 57121
NetAddr.localAddr




OSCFunc.trace(true, hideStatusMsg: true); // Turn posting on

OSCFunc.trace(false); // Turn posting off

