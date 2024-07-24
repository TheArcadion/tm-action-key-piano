const array<PianoTypes> c_ActivePianoTypes = {
	PianoTypes::Piano,
	PianoTypes::HonkyTonkPiano,
	PianoTypes::ToyPiano,
	PianoTypes::Theremin,
	PianoTypes::Saxophone,
	PianoTypes::ClownHorn
};

const array<MusicNote> c_ActiveMusicNotes = {
	MusicNote::C1,
	MusicNote::D1,
	MusicNote::E1,
	MusicNote::F1,
	MusicNote::G1,
	MusicNote::A2,
	MusicNote::B2,
	MusicNote::C2,
	MusicNote::D2,
	MusicNote::E2,
	MusicNote::F2,
	MusicNote::G2,
	MusicNote::A3,
	MusicNote::B3,
	MusicNote::C3,
	MusicNote::D3,
	MusicNote::E3,
	MusicNote::F3,
	MusicNote::G3,
	MusicNote::A4,
	MusicNote::B4,	
	MusicNote::C4
};

const array<array<MusicNote>> c_SongMusicNotes = {
	{
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, 
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, 
		MusicNote::E3, MusicNote::E3, MusicNote::E3, MusicNote::E3, MusicNote::E3, MusicNote::E3, MusicNote::E3, 
		MusicNote::D3, MusicNote::D3, MusicNote::D3, MusicNote::D3, MusicNote::D3, MusicNote::D3, MusicNote::D3, MusicNote::A3, 
		
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3,
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::E3,
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3,
		MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::B3, MusicNote::E3
	},
	{
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::E3, MusicNote::E3, MusicNote::D3,
		
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::D3, MusicNote::D3, MusicNote::C3, MusicNote::B3, MusicNote::A3,
		
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::C3, MusicNote::D3, MusicNote::B3, MusicNote::A3, MusicNote::G2,
		MusicNote::G2, MusicNote::D3, MusicNote::C3,
		
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::E3, MusicNote::E3, MusicNote::D3,
		
		
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::G3, MusicNote::B3, MusicNote::C3, MusicNote::B3, MusicNote::A3,
		
		MusicNote::G2, MusicNote::A3, MusicNote::C3, MusicNote::A3,
		MusicNote::C3, MusicNote::D3, MusicNote::B3, MusicNote::A3, MusicNote::G2,
		MusicNote::G2, MusicNote::D3, MusicNote::C3
	}
};