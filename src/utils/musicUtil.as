Song@ g_currentSong;
uint g_currentSongChord = 0;

array<Audio::Voice@>@ g_currentlyPlayingSounds;
bool hasStartedFadeOut = false;

void playNote(ActionKey actionKey) {
	uint temp = g_currentSongChord;
	// Set note counter
	if (!g_enablePlaySong || g_currentSong is null || g_currentSongChord >= g_currentSong.notes.Length) {
		// Set current song note back to zero
		g_currentSongChord = 0;
	}
	
	// Stop currently playing sound by fading out
	FadeOutAllSounds();
	
	// Play action key note
	if (!g_enablePlaySong) {
		PlayActionKeyNote(actionKey);
	} else {
		// Play song note
		PlaySongNote();
	}

}

void PlayActionKeyNote(ActionKey actionKey) {
	switch (actionKey) {
		case ActionKey::AK1:
			@g_currentlyPlayingSounds = { Audio::Play(g_ak1Sound, g_pianoSoundGain) };
			break;
		case ActionKey::AK2:
			@g_currentlyPlayingSounds = { Audio::Play(g_ak2Sound, g_pianoSoundGain) };
			break;
		case ActionKey::AK3:
			@g_currentlyPlayingSounds = { Audio::Play(g_ak3Sound, g_pianoSoundGain) };
			break;
		case ActionKey::AK4:
			@g_currentlyPlayingSounds = { Audio::Play(g_ak4Sound, g_pianoSoundGain) };
			break;
		case ActionKey::AK5:
			@g_currentlyPlayingSounds = { Audio::Play(g_ak5Sound, g_pianoSoundGain) };
			break;
	}
	return;
}

void PlaySongNote() {
	array<int> currentChord = g_currentSong.notes[g_currentSongChord];
	if (currentChord.Length == 0) return;
	
	// Select instrument type
	PianoTypes type = g_pianoType;
	if (g_currentSong.onlyPianoAsInstrument) type = PianoTypes::Piano;
	
	// Play chords using instrument
	for (int i = 0; i < currentChord.Length; i++) {
		Audio::Sample@ soundSample = loadSound(type, currentChord[i]);
		@g_currentlyPlayingSounds = { Audio::Play(soundSample, g_pianoSoundGain) };
	}
	
	g_currentSongChord += 1;
}

void FadeOutAllSounds() {
	// If no sounds are playing, don't fade
	if (g_currentlyPlayingSounds is null) return;
	
	// Copy sounds
	array<Audio::Voice@>@ oldSounds = g_currentlyPlayingSounds;
	
	// Loop over sounds
	for(uint i = 0; i < oldSounds.Length; i++) {
		if (oldSounds[i] is null) continue;
		if (oldSounds[i].GetPosition() < oldSounds[i].GetLength()) {
			//startnew(FadeOutCurrentCoro);
			array<Audio::Voice@>@ args = { oldSounds[i] };
			startnew(FadeOutCoro, args);
		}
		@g_currentlyPlayingSounds = null;
	}	
}

void FadeOutCoro(ref@ refs) {
	auto args = cast<array<Audio::Voice@>@>(refs);
	auto oldSound = args[0];
	FadeOut(oldSound, 500);
}

void FadeOut(Audio::Voice@ sound, float duration) {
    int64 startTime = Time::get_Now();
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
