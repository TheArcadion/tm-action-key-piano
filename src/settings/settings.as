[Setting category="Sound" name="Enable Action Key Piano"]
bool g_enableAKPianoSound = true;
[Setting category="Sound" min=0 max=1 name="Piano volume"]
float g_pianoSoundGain = 0.6f;

[Setting category="Piano" min=0 max=1 name="Piano type"]
PianoTypes g_pianoType = PianoTypes::Piano;
[Setting category="Piano" name="Action key 1 Note"]
MusicNotes g_AK1Note = MusicNotes::C2;
[Setting category="Piano" name="Action key 2 Note"]
MusicNotes g_AK2Note = MusicNotes::G2;
[Setting category="Piano" name="Action key 3 Note"]
MusicNotes g_AK3Note = MusicNotes::B2;
[Setting category="Piano" name="Action key 4 Note"]
MusicNotes g_AK4Note = MusicNotes::E3;
[Setting category="Piano" name="Action key 5 Note"]
MusicNotes g_AK5Note = MusicNotes::G3;
