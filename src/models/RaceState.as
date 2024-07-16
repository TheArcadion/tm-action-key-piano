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
        if (!shouldPlay) return;
        auto audioGain = 0.8f;
        switch (currentActionKey) {
            case ActionKey::AK1:
                Audio::Play(g_ak1Sound, audioGain);
                break;
            case ActionKey::AK2:
                Audio::Play(g_ak2Sound, audioGain);
                break;
            case ActionKey::AK3:
                Audio::Play(g_ak3Sound, audioGain);
                break;
            case ActionKey::AK4:
                Audio::Play(g_ak4Sound, audioGain);
                break;
            case ActionKey::AK5:
                Audio::Play(g_ak5Sound, audioGain);
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