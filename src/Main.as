void Main() {
	// Download sounds
	refreshLocalSounds();

	// Load sounds and 
    startnew(OnSoundsDownloadedCoro).WithRunContext(Meta::RunContext::BeforeScripts);
}

void RenderEarly() {
	updateDownloads();
}