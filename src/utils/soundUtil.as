Audio::Sample@ g_ak1Sound;
Audio::Sample@ g_ak2Sound;
Audio::Sample@ g_ak3Sound;
Audio::Sample@ g_ak4Sound;
Audio::Sample@ g_ak5Sound;

void loadSounds() {
	@g_ak1Sound = loadSound(g_pianoType, g_AK1Note);
	@g_ak2Sound = loadSound(g_pianoType, g_AK2Note);
	@g_ak3Sound = loadSound(g_pianoType, g_AK3Note);
	@g_ak4Sound = loadSound(g_pianoType, g_AK4Note);
	@g_ak5Sound = loadSound(g_pianoType, g_AK5Note);
}

Audio::Sample@ loadSound(PianoTypes type, int note) {
	auto soundPath = getLocalPath(type, note);
	auto soundSample = Audio::LoadSampleFromAbsolutePath(soundPath);
	return soundSample;
}

string resolveNotePath(int note) {
	switch(note) {
		// Extra lower
		case ExtraMusicNote::C0: return "C0";
		case ExtraMusicNote::D0: return "D0";
		case ExtraMusicNote::E0: return "E0";
		case ExtraMusicNote::F0: return "F0";
		case ExtraMusicNote::G0: return "G0";
		case ExtraMusicNote::A1: return "A1";
		case ExtraMusicNote::B1: return "B1";
		
		// Standard
		case MusicNote::C1: return "C1";
		case MusicNote::Csharp1: return "Csharp1";
	    case MusicNote::D1: return "D1";
	    case MusicNote::Dsharp1: return "Dsharp1";
	    case MusicNote::E1: return "E1";
	    case MusicNote::F1: return "F1";
	    case MusicNote::Fsharp1: return "Fsharp1";
	    case MusicNote::G1: return "G1";
	    case MusicNote::Gsharp1: return "Gsharp1";
	    case MusicNote::A2: return "A2";
	    case MusicNote::Asharp2: return "Asharp2";
	    case MusicNote::B2: return "B2";
	    case MusicNote::C2: return "C2";
	    case MusicNote::Csharp2: return "Csharp2";
	    case MusicNote::D2: return "D2";
	    case MusicNote::Dsharp2: return "Dsharp2";
	    case MusicNote::E2: return "E2";
	    case MusicNote::F2: return "F2";
	    case MusicNote::Fsharp2: return "Fsharp2";
	    case MusicNote::G2: return "G2";
	    case MusicNote::Gsharp2: return "Gsharp2";
	    case MusicNote::A3: return "A3";
	    case MusicNote::Asharp3: return "Asharp3";
	    case MusicNote::B3: return "B3";
	    case MusicNote::C3: return "C3";
	    case MusicNote::Csharp3: return "Csharp3";
	    case MusicNote::D3: return "D3";
	    case MusicNote::Dsharp3: return "Dsharp3";
	    case MusicNote::E3: return "E3";
	    case MusicNote::F3: return "F3";
	    case MusicNote::Fsharp3: return "Fsharp3";
	    case MusicNote::G3: return "G3";
	    case MusicNote::Gsharp3: return "Gsharp3";
	    case MusicNote::A4: return "A4";
	    case MusicNote::Asharp4: return "Asharp4";
	    case MusicNote::B4: return "B4";
	    case MusicNote::C4: return "C4";
	    case MusicNote::Csharp4: return "Csharp4";
	}
	return "Unknown";
}