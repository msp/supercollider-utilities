// Create symbols
~seq = "TX_Step Sequencer_358".asSymbol
~fm = "TX_FM Synth_365".asSymbol
~noise = "TX_Noise White-Pink_273".asSymbol
~wave = "TX_Wave Synth+_120".asSymbol

SynthDescLib.global[~seq].dump
SynthDescLib.global[~fm].dump
SynthDescLib.global[~noise].dump
SynthDescLib.global[~wave].dump



// Hmm, why no src-y ?!
SynthDescLib.global[~wave].def.func.def.sourceCode.postcs;
SynthDescLib.global[~fm].makeGui;

SynthDescLib.global[~fm].def.func.def.sourceCode;

SynthDescLib.all.postln;

IdentityDictionary


// Inspect control
SynthDescLib.global[~seq]
SynthDescLib.global[~seq].controlNames.do({ arg item, i; [i, item].postln; });

// GUI synthdef browser!
(
SynthDescLib.global.read;
SynthDescLib.global.browse;
)

// Try play the SynthDef

x = Synth(~fm)
// x = Synth.newPaused("default");
x.free;

y = Synth(~noise)
// x = Synth.newPaused("default");
y.free;

z = Synth(~fm, [], 1178, \addToHead); // seems to add it in the right place but not play. Needs params?
z.free

Group.new(1008);

// Test that shows how to get a client side handle that mirrors a server instance

// simple test
(
SynthDef(\msp, { | out, freq = 440|
    Out.ar(out, SinOsc.ar(freq, 0, 0.1));
}).add;
)

x = Synth(\msp);
x.nodeID
x.set(\freq, 220);

z = Synth.basicNew(\msp, s, x.nodeID)
z.get(\freq, { arg value; ("freq is now:" + value + "Hz").postln; });
// z freq is 220, same as x on server

x.set(\freq, 660);
z.get(\freq, { arg value; ("freq is now:" + value + "Hz").postln; });
// z freq is 660, same as x on server


// TX test
(
z = Synth.basicNew(~fm, s, 1099)
z.get(\op1Amp, { arg value; ("level is now:" + value).postln; });
// ok!

// END example



TXModuleBase

a = TXFMDrone.new("msp-fm")
a.loadAndMakeSynth
a.openHelp

a.init
b = a.synthDefFunc

b.source_


a.free;
b.free;



// UTIL


// Dump availble classes
Filter.dumpClassSubtree;

a = RootNode(s);

a

(
RootNode.dependants.do {
	arg i;
	i.postln;
}
)

(
	SynthDef(\controlList, { |out = 0, freq = 440, amp = 0.1, detune = #[0.999, 1.001], gate = 1|
		var    sig = Mix(Saw.ar(freq * (detune ++ [1]), amp)),
		env = EnvGen.kr(Env.adsr, gate, doneAction: Done.freeSelf);
		Out.ar(out, (sig * env) ! 2);
	}).add;

	SynthDescLib.global[\controlList]
)