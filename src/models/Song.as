class Song {
    array<array<int>> notes;
    bool onlyPianoAsInstrument;
    bool dontCutOffNoteSounds;

    Song(array<array<int>> notes, bool onlyPianoAsInstrument, bool dontCutOffNoteSounds) {
        this.notes = notes;
        this.onlyPianoAsInstrument = onlyPianoAsInstrument;
        this.dontCutOffNoteSounds = dontCutOffNoteSounds;
    }
}
