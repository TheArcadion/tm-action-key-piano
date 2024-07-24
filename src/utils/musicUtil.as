array<MusicNote> g_currentSong;
uint g_currentSongNote = 0;

Audio::Voice@ g_currentlyPlayingSound;

void playNote(ActionKey actionKey) {
	// Set note counter
	if (!g_enablePlaySong || g_currentSongNote >= g_currentSong.Length) {
		// Set current song note back to zero
		g_currentSongNote = 0;
	}
	
	// Stop currently playing sound
	if (g_currentlyPlayingSound !is null) g_currentlyPlayingSound.SetGain(0);
	
	// Play action key note
	if (!g_enablePlaySong) {
		switch (actionKey) {
			case ActionKey::AK1:
				@g_currentlyPlayingSound = Audio::Play(g_ak1Sound, g_pianoSoundGain);
				break;
			case ActionKey::AK2:
				@g_currentlyPlayingSound = Audio::Play(g_ak2Sound, g_pianoSoundGain);
				break;
			case ActionKey::AK3:
				@g_currentlyPlayingSound = Audio::Play(g_ak3Sound, g_pianoSoundGain);
				break;
			case ActionKey::AK4:
				@g_currentlyPlayingSound = Audio::Play(g_ak4Sound, g_pianoSoundGain);
				break;
			case ActionKey::AK5:
				@g_currentlyPlayingSound = Audio::Play(g_ak5Sound, g_pianoSoundGain);
				break;
		}
		return;
	}
	
	// Play song note
	MusicNote currentNote = g_currentSong[g_currentSongNote];
	Audio::Sample@ soundSample = loadSound(g_pianoType, currentNote);
	@g_currentlyPlayingSound = Audio::Play(soundSample, g_pianoSoundGain);
	g_currentSongNote += 1;
}

		

