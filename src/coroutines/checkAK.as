uint g_LastUpdate;
int g_pgNow;
uint g_LRLI;
uint g_SRLI;
uint g_RR;
uint g_SI;
int g_StartTime;
int g_LastSeq;
int g_RespawnRegainControl;

RaceState@ currentState;

void CheckAKCoro()
{
    @currentState = RaceState();
    yield();

    CGameCtnApp@ app = GetApp();
    if (app is null) return;

    while (true) {
        yield();
		
		if (!g_enableAKPianoSound) continue;

        CSmArenaClient@ playground = cast<CSmArenaClient>(app.CurrentPlayground);
        if (playground is null || playground.ArenaInterface is null || app.GameScene is null)
            continue;

        if (playground.GameTerminals.Length == 0)
            continue;

        CGameTerminal@ gameTerminal = playground.GameTerminals[0];
        CSmPlayer@ player = cast<CSmPlayer>(gameTerminal.ControlledPlayer);
        if (player is null)
            continue;

        if (app.Network.PlaygroundClientScriptAPI is null) continue;
            g_pgNow = app.Network.PlaygroundClientScriptAPI.GameTime;

        if (g_LastSeq != int(gameTerminal.UISequence_Current)) {
            g_LastSeq = int(gameTerminal.UISequence_Current);
            // if we change UI sequences, replace race state
            @currentState = RaceState();
        }

        // don't check other stuff if we're not playing
        if (g_LastSeq != int(SGamePlaygroundUIConfig::EUISequence::Playing)) continue;

        if (g_StartTime != player.StartTime) {
            // we restarted or something
            g_StartTime = player.StartTime;
            @currentState = RaceState();
        }

        if (g_LRLI != player.CurrentLaunchedRespawnLandmarkIndex) {
            g_LRLI = player.CurrentLaunchedRespawnLandmarkIndex;
            g_SRLI = player.CurrentStoppedRespawnLandmarkIndex;
            currentState.OnCpTaken(player);
        }

        g_SI = player.SpawnIndex;

        if (g_RR != player.Score.NbRespawnsRequested) {
            g_RR = player.Score.NbRespawnsRequested;
            // one second delay on respawn, but only if we haven't already respawned
            if (g_RespawnRegainControl < g_pgNow)
                g_RespawnRegainControl = g_pgNow + 995;
            startnew(OnRespawnCoro);
        }
        g_RR = player.Score.NbRespawnsRequested;
        g_LastUpdate = Time::Now;
        
        bool raceStarted = player.StartTime <= g_pgNow;
        
        uint16 pressed = ReadActionKeyPressed(playground);

        if (pressed == currentState.lastKeyPress)
            continue;

        if (currentState.IsActionKeyPress(ActionKey::AK1, pressed))
            currentState.OnPressActionKey(ActionKey::AK1);
        else if (currentState.IsActionKeyPress(ActionKey::AK2, pressed))
            currentState.OnPressActionKey(ActionKey::AK2);
        else if (currentState.IsActionKeyPress(ActionKey::AK3, pressed))
            currentState.OnPressActionKey(ActionKey::AK3);
        else if (currentState.IsActionKeyPress(ActionKey::AK4, pressed))
            currentState.OnPressActionKey(ActionKey::AK4);
        else if (currentState.IsActionKeyPress(ActionKey::AK5, pressed))
            currentState.OnPressActionKey(ActionKey::AK5);

        if (!raceStarted){
            currentState.SetActionKey(ActionKey::AK5);
        }

        currentState.lastKeyPress = pressed;

        // only check for override if we're not in a respawning state
        if (g_RespawnRegainControl < g_pgNow) {
            CSceneVehicleVis@ vis = VehicleState::GetVis(app.GameScene, player);
            if (vis !is null) {
                CheckAgainstVisSteering(vis.AsyncState.InputSteer);
            }
        }
    }
}

const uint16 OFFSET_ARENA_INTERFACE_ACTION_KEYS_PRESSED = 0x10b0;
uint16 ReadActionKeyPressed(CSmArenaClient@ playground) {
    if (playground is null || playground.ArenaInterface is null) return 0;
    return Dev::GetOffsetUint16(playground.ArenaInterface, OFFSET_ARENA_INTERFACE_ACTION_KEYS_PRESSED);
}



float akDetectionDelta = 0.0001;
float lastInputSteer = 0;
uint inputSteerSameConsecutiveFrames;
uint inputSteerSameConsecutiveFramesStart;
void CheckAgainstVisSteering(float InputSteer) {
    InputSteer = Math::Abs(InputSteer);
    auto currAkLimit = GetActionKeyLimit(currentState.currentActionKey);
    // with controller you can steer less than the current AK
    if (InputSteer > currAkLimit + akDetectionDelta) {
        // then we can't be in the right AK
        currentState.SetActionKey(InferAkFromInput(InputSteer));
        inputSteerSameConsecutiveFrames = 0;
    } else if (InputSteer < currAkLimit - akDetectionDelta && InputSteer > akDetectionDelta) {
        if (Math::Abs(InputSteer - lastInputSteer) < akDetectionDelta) {
            if (inputSteerSameConsecutiveFrames == 0) inputSteerSameConsecutiveFramesStart = Time::Now;
            inputSteerSameConsecutiveFrames++;
        }
        // this should rarely, if ever, trigger for players using a controller even if they're really good. also wait at least 40ms so for FPS > 100 we don't trigger early.
        if (inputSteerSameConsecutiveFrames >= 4 && (Time::Now - inputSteerSameConsecutiveFramesStart) >= 40) {
            auto inferred = InferAkFromInput(InputSteer, true);
            // we can never be in AK5 since this branch is for steering less than the detected limit
            if (inferred != ActionKey::AK5) {
                currentState.SetActionKey(inferred);
            }
            inputSteerSameConsecutiveFrames = 0;
        }
    } else {
        inputSteerSameConsecutiveFrames = 0;
    }
    lastInputSteer = InputSteer;
}

float GetActionKeyLimit(ActionKey actionKey) {
    switch (actionKey) {
        case ActionKey::AK1:
            return 0.2;
        case ActionKey::AK2:
            return 0.4;
        case ActionKey::AK3:
            return 0.6;
        case ActionKey::AK4:
            return 0.8;
        case ActionKey::AK5:
        default:
            return 1;
    }
}

ActionKey InferAkFromInput(float input, bool strict = false) {
    if ((!strict || input >= 0.2 - akDetectionDelta) && input <= 0.2 + akDetectionDelta) return ActionKey::AK1;
    if ((!strict || input >= 0.4 - akDetectionDelta) && input <= 0.4 + akDetectionDelta) return ActionKey::AK2;
    if ((!strict || input >= 0.6 - akDetectionDelta) && input <= 0.6 + akDetectionDelta) return ActionKey::AK3;
    if ((!strict || input >= 0.8 - akDetectionDelta) && input <= 0.8 + akDetectionDelta) return ActionKey::AK4;
    return ActionKey::AK5;
}