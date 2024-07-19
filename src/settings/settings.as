[Setting category="Sound" name="Enable Action Key Piano"]
bool g_enableAKPianoSound = true;
[Setting category="Sound" min=0 max=1 name="Piano volume"]
float g_pianoSoundGain = 0.6f;

[Setting category="Piano" min=0 max=1 name="Piano type"]
PianoTypes g_pianoType = PianoTypes::Piano;
[Setting category="Piano" name="Action key 1 Note"]
MusicNote g_AK1Note = MusicNote::C2;
[Setting category="Piano" name="Action key 2 Note"]
MusicNote g_AK2Note = MusicNote::G2;
[Setting category="Piano" name="Action key 3 Note"]
MusicNote g_AK3Note = MusicNote::B3;
[Setting category="Piano" name="Action key 4 Note"]
MusicNote g_AK4Note = MusicNote::E3;
[Setting category="Piano" name="Action key 5 Note"]
MusicNote g_AK5Note = MusicNote::G3;
