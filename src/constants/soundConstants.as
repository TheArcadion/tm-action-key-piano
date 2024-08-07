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
	MusicNote::Csharp1,
	MusicNote::D1,
	MusicNote::Dsharp1,
	MusicNote::E1,
	MusicNote::F1,
	MusicNote::Fsharp1,
	MusicNote::G1,
	MusicNote::Gsharp1,
	MusicNote::A2,
	MusicNote::Asharp2,
	MusicNote::B2,
	MusicNote::C2,
	MusicNote::Csharp2,
	MusicNote::D2,
	MusicNote::Dsharp2,
	MusicNote::E2,
	MusicNote::F2,
	MusicNote::Fsharp2,
	MusicNote::G2,
	MusicNote::Gsharp2,
	MusicNote::A3,
	MusicNote::Asharp3,
	MusicNote::B3,
	MusicNote::B3,
	MusicNote::C3,
	MusicNote::Csharp3,
	MusicNote::D3,
	MusicNote::Dsharp3,
	MusicNote::E3,
	MusicNote::F3,
	MusicNote::Fsharp3,
	MusicNote::G3,
	MusicNote::Gsharp3,
	MusicNote::A4,
	MusicNote::Asharp4,
	MusicNote::B4,	
	MusicNote::C4,
	MusicNote::Csharp4
};
const array<ExtraMusicNote> c_ActiveExtraPianoNotes = {
	ExtraMusicNote::C0,
	//ExtraMusicNote::D0,
	//ExtraMusicNote::E0,
	//ExtraMusicNote::F0,
	ExtraMusicNote::G0,
	//ExtraMusicNote::A1,
	//ExtraMusicNote::B1
};

const array<Song@>@ c_Songs = {
	// Classical songs. Piano only. 
	// Clair de Lune - Debussy.  https://musescore.com/user/31902283/scores/5933450
	Song(
		{ 
			// piano
			{MusicNote::E2, MusicNote::G2}, {MusicNote::E3, MusicNote::G3}, {MusicNote::C3, MusicNote::E3}, 
			{MusicNote::F2, MusicNote::Gsharp2}, {MusicNote::B3, MusicNote::D3}, {MusicNote::C3, MusicNote::E3}, {MusicNote::B3, MusicNote::D3},
			{MusicNote::E2, MusicNote::G2}, {MusicNote::A3, MusicNote::C3}, {MusicNote::B3, MusicNote::D3}, {MusicNote::A3, MusicNote::C3}, {MusicNote::E3}, {MusicNote::C3},
			{MusicNote::D2, MusicNote::F2}, {MusicNote::G2, MusicNote::B3}, {MusicNote::A3, MusicNote::C3}, {MusicNote::G2, MusicNote::B3},
			{MusicNote::C2, MusicNote::D2, MusicNote::F2}, {MusicNote::A3}, {MusicNote::B3}, {MusicNote::A3}, {MusicNote::D3}, {MusicNote::A3},
			{MusicNote::B2, MusicNote::D2, MusicNote::F2, MusicNote::G2}, {MusicNote::A3}, {MusicNote::G2},
			{MusicNote::A2, MusicNote::C2, MusicNote::D2}, {MusicNote::F2}, {MusicNote::G2}, {MusicNote::F2},
			{MusicNote::Gsharp1, MusicNote::B2, MusicNote::D2, MusicNote::E2},
			// Crescendo piano <
			{MusicNote::G1, MusicNote::A2}, {MusicNote::E2}, {MusicNote::F2}, {MusicNote::E2}, {MusicNote::A3}, {MusicNote::E2},
			{MusicNote::F1, MusicNote::A2, MusicNote::D2}, {MusicNote::E2}, {MusicNote::D2},
			{MusicNote::E1, MusicNote::G1, MusicNote::A2}, {MusicNote::C2}, {MusicNote::D2}, {MusicNote::C2},
			// mezzo piano
			{ExtraMusicNote::G0, MusicNote::F1, MusicNote::B2},
			{MusicNote::C1}, {MusicNote::E1}, {MusicNote::G1, MusicNote::G2}, {MusicNote::E3, MusicNote::G3}, {MusicNote::C3, MusicNote::E3},
			{MusicNote::F1, MusicNote::A2}, {MusicNote::A3, MusicNote::D3}, {MusicNote::E3}, {MusicNote::D3},
			{MusicNote::E1, MusicNote::G1}, {MusicNote::C3}, {MusicNote::D3}, {MusicNote::C3, MusicNote::G3}, {MusicNote::C3, MusicNote::E3},
			{MusicNote::F1, MusicNote::A2}, {MusicNote::A3, MusicNote::D3}, {MusicNote::E3}, {MusicNote::D3}, {MusicNote::C3},
			{MusicNote::E1, MusicNote::G1}, {MusicNote::C2}, {MusicNote::D2}, {MusicNote::C2, MusicNote::E2, MusicNote::A3}, {MusicNote::C2, MusicNote::E2},
			{MusicNote::D1, MusicNote::F1}, {MusicNote::F2}, {MusicNote::G2}, {MusicNote::F2, MusicNote::A3, MusicNote::C3}, {MusicNote::F2, MusicNote::A3},
			{ExtraMusicNote::G0, MusicNote::D1, MusicNote::F1}, {MusicNote::A3}, {MusicNote::B3}, {MusicNote::G2, MusicNote::B3, MusicNote::E3}, {ExtraMusicNote::G0, MusicNote::F2, MusicNote::G2},
			// Decrescendo piano > pianossimo
			{ExtraMusicNote::C0, MusicNote::E3, MusicNote::G3}, {ExtraMusicNote::G0}, {MusicNote::C1}, {MusicNote::G1}, {MusicNote::C2, MusicNote::E3, MusicNote::G3}
		},
		true,
		true
	),
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	null, // Placeholder for future music pieces
	
	// Meme songs. All instruments
	Song(
		{ 
			// Darude sandstorm
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, 
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, 
			{MusicNote::E3}, {MusicNote::E3}, {MusicNote::E3}, {MusicNote::E3}, {MusicNote::E3}, {MusicNote::E3}, {MusicNote::E3}, 
			{MusicNote::D3}, {MusicNote::D3}, {MusicNote::D3}, {MusicNote::D3}, {MusicNote::D3}, {MusicNote::D3}, {MusicNote::D3}, {MusicNote::A3}, 
			
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3},{MusicNote::B3}, {MusicNote::B3},
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3},{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::E3},
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3},{MusicNote::B3}, {MusicNote::B3},
			{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3},{MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::B3}, {MusicNote::E3}
		},
		false,
		false
	),
	Song(
		{ 
			// Never Gonna Give You Up
			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::E3}, {MusicNote::E3}, {MusicNote::D3},

			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::D3}, {MusicNote::D3}, {MusicNote::C3}, {MusicNote::B3}, {MusicNote::A3},

			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::C3}, {MusicNote::D3}, {MusicNote::B3}, {MusicNote::A3}, {MusicNote::G2},
			{MusicNote::G2}, {MusicNote::D3}, {MusicNote::C3},

			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::E3}, {MusicNote::E3}, {MusicNote::D3},


			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::G3}, {MusicNote::B3}, {MusicNote::C3}, {MusicNote::B3}, {MusicNote::A3},

			{MusicNote::G2}, {MusicNote::A3}, {MusicNote::C3}, {MusicNote::A3},
			{MusicNote::C3}, {MusicNote::D3}, {MusicNote::B3}, {MusicNote::A3}, {MusicNote::G2},
			{MusicNote::G2}, {MusicNote::D3}, {MusicNote::C3}
		},
		false,
		false
	)
};