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
        currentActionKey = currentActionKey == actionKey ? ActionKey::AK5 : actionKey;
		if (!g_initialized) return;
        auto shouldPlay = currentActionKey != actionKey || actionKey != ActionKey::AK5;
        if (!shouldPlay) return;
        switch (currentActionKey) {
            case ActionKey::AK1:
                Audio::Play(g_ak1Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK2:
                Audio::Play(g_ak2Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK3:
                Audio::Play(g_ak3Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK4:
                Audio::Play(g_ak4Sound, g_pianoSoundGain);
                break;
            case ActionKey::AK5:
                Audio::Play(g_ak5Sound, g_pianoSoundGain);
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