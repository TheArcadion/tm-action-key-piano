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
		playNote(currentActionKey);
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
