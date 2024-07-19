Audio::Voice@ g_currentlyPlayingSound;

class RaceState {
    ActionKey currentActionKey = ActionKey::AK5;
    ActionKey lastCpActionKey = ActionKey::AK5;
    uint lastKeyPress;

    bool IsActionKeyPress(ActionKey actionKey, uint16 pressed) {
        return actionKey & pressed != actionKey & lastKeyPress;
    }

    void OnPressActionKey(ActionKey actionKey) {
        if (actionKey & lastKeyPress > 0)
            return;
        SetActionKey(actionKey);
    }

    void SetActionKey(ActionKey actionKey) {
        auto shouldPlay = currentActionKey != actionKey || actionKey != ActionKey::AK5;
        currentActionKey = currentActionKey == actionKey ? ActionKey::AK5 : actionKey;
		if (!g_initialized) return;
        if (!shouldPlay) return;
		if (g_currentlyPlayingSound !is null) g_currentlyPlayingSound.SetGain(0);
        switch (currentActionKey) {
            case ActionKey::AK1:
                @g_currentlyPlayingSound = Audio::Play(g_ak1Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK2:
                @g_currentlyPlayingSound = Audio::Play(g_ak2Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK3:
                @g_currentlyPlayingSound = Audio::Play(g_ak3Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK4:
                @g_currentlyPlayingSound = Audio::Play(g_ak4Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK5:
                @g_currentlyPlayingSound = Audio::Play(g_ak5Sound, g_pianoSoundGain);
                break;
        }
    }

    void OnCpTaken(CSmPlayer@ player) {
        lastCpActionKey = currentActionKey;
    }

    void OnRespawn() {
        SetActionKey(lastCpActionKey);
    }

    void OnStandingRespawn() {
        SetActionKey(ActionKey::AK5);
    }
}