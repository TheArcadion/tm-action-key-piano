[Setting category="General" name="Enable Action Key Piano"]
bool g_enableAKPianoSound = true;
[Setting category="General" min=0 max=1 name="Piano volume"]
float g_pianoSoundGain = 0.6f;

[Setting category="Piano" min=0 max=1 name="Instrument"]
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


// OR

// Song choice
[Setting category="Piano" name="Play a song note by note" description="Each time an action key is toggled, the next note in the song gets played"]
bool g_enablePlaySong = false;
[Setting category="Piano" name="Song to play"]
SongIndexes g_songIndex = SongIndexes::Song1;