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

void loadSound(PianoTypes type, MusicNote note, ActionKey actionKey) {
	auto soundPath = "sounds/" + type + "/" + resolveNotePath(note) + ".flac";
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

string resolveNotePath(MusicNote note) {
	switch(note) {
		case MusicNote::C1: return "C1";
	    case MusicNote::D1: return "D1";
	    case MusicNote::E1: return "E1";
	    case MusicNote::F1: return "F1";
	    case MusicNote::G1: return "G1";
	    case MusicNote::A2: return "A2";
	    case MusicNote::B2: return "B2";
	    case MusicNote::C2: return "C2";
	    case MusicNote::D2: return "D2";
	    case MusicNote::E2: return "E2";
	    case MusicNote::F2: return "F2";
	    case MusicNote::G2: return "G2";
	    case MusicNote::A3: return "A3";
	    case MusicNote::B3: return "B3";
	    case MusicNote::C3: return "C3";
	    case MusicNote::D3: return "D3";
	    case MusicNote::E3: return "E3";
	    case MusicNote::F3: return "F3";
	    case MusicNote::G3: return "G3";
	    case MusicNote::A4: return "A4";
	    case MusicNote::B4: return "B4";
	    case MusicNote::C4: return "C4";
	}
	return "Unknown";
}