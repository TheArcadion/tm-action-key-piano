PianoTypes old_pianoType;
MusicNote old_AK1Note = g_AK1Note;
MusicNote old_AK2Note = g_AK2Note;
MusicNote old_AK3Note = g_AK3Note;
MusicNote old_AK4Note = g_AK4Note;
MusicNote old_AK5Note = g_AK5Note;

bool old_enablePlaySong = false;
SongIndexes old_songIndex = SongIndexes::Song1;

void CheckChangedSettingCoro()
{	
	// Set default song
	g_currentSong = c_SongMusicNotes[g_songIndex];
	g_currentSongNote = 0;
	
	// Start setting change loop
    while (true) {
        yield();
		
		// If song stting changed, reset current note
		if (old_enablePlaySong != g_enablePlaySong) {
			g_currentSongNote = 0;
			old_enablePlaySong = g_enablePlaySong;
		}
		
		// If song index changed, set new song and reset index
		if (old_songIndex != g_songIndex) {
			g_currentSong = c_SongMusicNotes[g_songIndex];
			g_currentSongNote = 0;
			old_songIndex = g_songIndex;
		}
		
		// If pianoType changed, update all sounds and reset current note
		if (old_pianoType != g_pianoType) {
			loadSounds();
			old_pianoType = g_pianoType;
			
			g_currentSongNote = 0;
			continue;
		}
		
		// Check for note changes
		if (old_AK1Note != g_AK1Note) {
			@g_ak1Sound = loadSound(g_pianoType, g_AK1Note);
			old_AK1Note = g_AK1Note;
		}
		if (old_AK2Note != g_AK2Note) {
			@g_ak2Sound = loadSound(g_pianoType, g_AK2Note);
			old_AK2Note = g_AK2Note;
		}
		if (old_AK3Note != g_AK3Note) {
			@g_ak3Sound = loadSound(g_pianoType, g_AK3Note);
			old_AK3Note = g_AK3Note;
		}
		if (old_AK4Note != g_AK4Note) {
			@g_ak4Sound = loadSound(g_pianoType, g_AK4Note);
			old_AK4Note = g_AK4Note;
		}
		if (old_AK5Note != g_AK5Note) {
			@g_ak5Sound = loadSound(g_pianoType, g_AK5Note);
			old_AK5Note = g_AK5Note;
		}
	}
}