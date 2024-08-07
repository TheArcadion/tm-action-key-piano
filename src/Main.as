void Main() {
	// Download sounds
	refreshLocalSounds();

	// Load sounds and 
    startnew(OnSoundsDownloadedCoro).WithRunContext(Meta::RunContext::BeforeScripts);
}

void RenderEarly() {
	updateDownloads();
}


// TODO: 
// Make play sound work with array array array int
// Make reverb piano list or add song, reverb and pianoOnly bool to class in dictionary, key = song id
// Add super mario 1-1 theme