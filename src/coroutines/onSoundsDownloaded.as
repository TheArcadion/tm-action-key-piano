bool g_initialized;
void OnSoundsDownloadedCoro()
{
	// Wait for downloads to finish
    while (!g_allLocalSoundsPresent)
        yield();
	
	// All sounds present, load them and check for AKs to play
	loadSounds();
    startnew(CheckChangedSettingCoro).WithRunContext(Meta::RunContext::BeforeScripts);
    startnew(CheckAKCoro).WithRunContext(Meta::RunContext::BeforeScripts);
    
    yield();
    g_initialized = true;
}