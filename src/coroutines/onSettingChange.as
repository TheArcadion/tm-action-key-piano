PianoTypes old_pianoType;
MusicNotes old_AK1Note = g_AK1Note;
MusicNotes old_AK2Note = g_AK2Note;
MusicNotes old_AK3Note = g_AK3Note;
MusicNotes old_AK4Note = g_AK4Note;
MusicNotes old_AK5Note = g_AK5Note;

void CheckChangedSettingCoro()
{	
    while (true) {
        yield();
		// If pianoType changed, update all sounds
		if (old_pianoType != g_pianoType) {
			loadSounds();
			old_pianoType = g_pianoType;
			continue;
		}
		
		// Check for note changes
		if (old_AK1Note != g_AK1Note) {
			loadSound(g_pianoType, g_AK1Note, ActionKey::AK1);
			old_AK1Note = g_AK1Note;
		}
		if (old_AK2Note != g_AK2Note) {
			loadSound(g_pianoType, g_AK2Note, ActionKey::AK2);
			old_AK2Note = g_AK2Note;
		}
		if (old_AK3Note != g_AK3Note) {
			loadSound(g_pianoType, g_AK3Note, ActionKey::AK3);
			old_AK3Note = g_AK3Note;
		}
		if (old_AK4Note != g_AK4Note) {
			loadSound(g_pianoType, g_AK4Note, ActionKey::AK4);
			old_AK4Note = g_AK4Note;
		}
		if (old_AK5Note != g_AK5Note) {
			loadSound(g_pianoType, g_AK5Note, ActionKey::AK5);
			old_AK5Note = g_AK5Note;
		}
	}
}