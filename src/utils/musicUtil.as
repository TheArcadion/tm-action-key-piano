array<MusicNote> g_currentSong;
uint g_currentSongNote = 0;

Audio::Voice@ g_currentlyPlayingSound;
bool hasStartedFadeOut = false;

void playNote(ActionKey actionKey) {
	// Set note counter
	if (!g_enablePlaySong || g_currentSongNote >= g_currentSong.Length) {
		// Set current song note back to zero
		g_currentSongNote = 0;
	}
	
	// Stop currently playing sound by fading out
	if (g_currentlyPlayingSound !is null && g_currentlyPlayingSound.GetPosition() < g_currentlyPlayingSound.GetLength()) {
		startnew(FadeOutCurrentCoro);
		// Wait for audio copy before reassigning
		while(!hasStartedFadeOut) yield();
		
		// Reassign audio
		hasStartedFadeOut = false;
		@g_currentlyPlayingSound = null;
	}
	
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

void FadeOutCurrentCoro() {
	// Copy currently playing audio
	Audio::Voice@ g_oldSound = g_currentlyPlayingSound;
	hasStartedFadeOut = true;
	FadeOut(g_oldSound, 500);
}

void FadeOut(Audio::Voice@ sound, float duration) {
    uint64 startTime = Time::get_Now();
    float initialGain = sound.GetGain();

    while (Time::get_Now() - startTime < duration) {
        uint64 elapsed = Time::get_Now() - startTime;
        float progress = elapsed / duration;
        float newGain = initialGain * (1.0 - (elapsed / duration)); // Linear decay
        sound.SetGain(newGain);
        yield();
    }

    sound.SetGain(0); // Ensure the gain is set to 0 at the end
}
