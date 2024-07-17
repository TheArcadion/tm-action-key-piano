RaceState@ currentState;

bool g_initialized;
void Main() {
    @currentState = RaceState();

    loadSounds();
    startnew(CheckChangedSettingCoro).WithRunContext(Meta::RunContext::BeforeScripts);
    startnew(CheckAKCoro).WithRunContext(Meta::RunContext::BeforeScripts);
    
    yield();
    g_initialized = true;
}