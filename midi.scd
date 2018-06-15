(
s.quit;
s.options.numOutputBusChannels = 16;
s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 * 16;
// s.options.sampleRate = 48000;

// s.options.device = "JackRouter"; // Mixing in Live only!
s.options.device = "Fireface UCX (23733485)";

// ~dirt.free; // free old instancex
s.waitForBoot {
	// ~dirt = SuperDirt(2, s);
	// ~dirt.loadSoundFiles;
	s.sync; // wait until all soundfiles are really loaded
	// ~dirt.start(57120, (0, 2 .. 15)); // play two orbits
}
)


MIDIClient.init

MIDIIn.connectAll


// MIDIdef
(
MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	[vel, nn].postln;
	{
		var sig, env;
		sig = SinOsc.ar(nn.midicps)!2;
		env = EnvGen.kr(Env.perc, doneAction: 2);
		sig = sig * env * vel.linexp(1, 127, 0.01, 0.3);
	}.play;
});
)

s.boot;

s.quit;

MIDIdef.freeAll

MIDIIn.disconnectAll
MIDIOut.disconnect

MIDIClient.

Server.local.plotTree

s.plotTree;

~dirt.free

~dirt.stop

Server.killAll

Server.postln

s.postln;

Server.default.postln;


Server.allRunningServers;

(
var num = 100;
var synTest = synTestArray.detectIndex { |item| item == 0 };

~envtimes

~envcurves

Synth(\fmTex,
	[
		\lev1,~envlevs[i][0],
		\lev2,~envlevs[i][1],
		\lev3,~envlevs[i][2],
		\lev4,~envlevs[i][3],
		\lev5,~envlevs[i][4],
		\t1,(~envtimes[i][1]-~envtimes[i][0])*~times[i],
		\t2,(~envtimes[i][2]-~envtimes[i][1])*~times[i],
		\t3,(~envtimes[i][3]-~envtimes[i][2])*~times[i],
		\t4,(~envtimes[i][3]-~envtimes[i][2])*~times[i],
		\cur1,~envcurves[i][0],
		\cur2,~envcurves[i][1],
		\cur3,~envcurves[i][2],
		\cur4,~envcurves[i][3],
		\freq,num.midicps*~fratio[i],
		\inbus,(16+i)+(synTest*16),
		\lfoPitDepth,~lfoPitDepth[i],
		\lfoAmpDepth,~lfoAmpDepth[i],
		\lfoFade,~lfoFadeTime[i],
		\lfrate,~lfoRate[i],
		\envPitDepth,~envPitDepth[i],
		\s1,8+(synTest*16),
		\m1,(num.midicps/10)*~modlevs[i][0],
		\m2,(num.midicps/10)*~modlevs[i][1],
		\m3,(num.midicps/10)*~modlevs[i][2],
		\m4,(num.midicps/10)*~modlevs[i][3],
		\m5,(num.midicps/10)*~modlevs[i][4],
		\m6,(num.midicps/10)*~modlevs[i][5],
		\m7,(num.midicps/10)*~modlevs[i][6],
		\m8,(num.midicps/10)*~modlevs[i][7],
		\amp,~amplevs[i]/8,
	],target:~synth
);
)