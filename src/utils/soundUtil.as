Audio::Sample@ g_ak1Sound;
Audio::Sample@ g_ak2Sound;
Audio::Sample@ g_ak3Sound;
Audio::Sample@ g_ak4Sound;
Audio::Sample@ g_ak5Sound;
void loadSounds() {
	loadSound(g_pianoType, g_AK1Note, ActionKey::AK1);
	loadSound(g_pianoType, g_AK2Note, ActionKey::AK2);
	loadSound(g_pianoType, g_AK3Note, ActionKey::AK3);
	loadSound(g_pianoType, g_AK4Note, ActionKey::AK4);
	loadSound(g_pianoType, g_AK5Note, ActionKey::AK5);
}

void loadSound(PianoTypes type, MusicNotes note, ActionKey actionKey) {
	string notePath = resolveNotePath(note);
	auto soundPath = "sounds/" + type + "/" + notePath + ".flac";
	auto soundSample = Audio::LoadSample(soundPath);
	switch(actionKey) {
		case ActionKey::AK1:
			@g_ak1Sound = soundSample;
			break;
		case ActionKey::AK2:
			@g_ak2Sound = soundSample;
			break;
		case ActionKey::AK3:
			@g_ak3Sound = soundSample;
			break;
		case ActionKey::AK4:
			@g_ak4Sound = soundSample;
			break;
		case ActionKey::AK5:
			@g_ak5Sound = soundSample;
			break;
	}
}

string resolveNotePath(MusicNotes note) {
	switch(note) {
		case MusicNotes::C1: return "C1";
	    case MusicNotes::D1: return "D1";
	    case MusicNotes::E1: return "E1";
	    case MusicNotes::F1: return "F1";
	    case MusicNotes::G1: return "G1";
	    case MusicNotes::A1: return "A1";
	    case MusicNotes::B1: return "B1";
	    case MusicNotes::C2: return "C2";
	    case MusicNotes::D2: return "D2";
	    case MusicNotes::E2: return "E2";
	    case MusicNotes::F2: return "F2";
	    case MusicNotes::G2: return "G2";
	    case MusicNotes::A2: return "A2";
	    case MusicNotes::B2: return "B2";
	    case MusicNotes::C3: return "C3";
	    case MusicNotes::D3: return "D3";
	    case MusicNotes::E3: return "E3";
	    case MusicNotes::F3: return "F3";
	    case MusicNotes::G3: return "G3";
	    case MusicNotes::A3: return "A3";
	    case MusicNotes::B3: return "B3";
	    case MusicNotes::C4: return "C4";
	}
	return "Unknown";
}