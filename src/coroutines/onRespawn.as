void OnRespawnCoro() {
    auto app = GetApp();
    if (app.GameScene is null) return;
    auto cp = cast<CSmArenaClient>(app.CurrentPlayground);
    if (cp is null || cp.ArenaInterface is null) return;
    if (cp.GameTerminals.Length == 0) return;
    auto player = cast<CSmPlayer>(cp.GameTerminals[0].ControlledPlayer);
    CSceneVehicleVis@ vis1 = VehicleState::GetVis(app.GameScene, player);
    if (vis1 is null) return;
    vec3 lastPos = vis1.AsyncState.Position;
    @player = null;
    yield();
    uint count = 0, count_standing = 0, count_flying = 0;
    while (count < 8) {
        if (app is null || app.GameScene is null || app.CurrentPlayground is null)
            return;
        
        auto playerTmp = cast<CSmPlayer>(cp.GameTerminals[0].ControlledPlayer);
        if (playerTmp is null) return;
        auto vis = VehicleState::GetVis(app.GameScene, playerTmp);
        if (vis is null) return;
        if ((vis1.AsyncState.Position - lastPos).LengthSquared() < 0.0001) {
            count_standing++;
        } else {
            count_flying++;
        }
        lastPos = vis1.AsyncState.Position;
        count++;
        yield();
    }
    if (count_flying >= count_standing) {
        currentState.OnRespawn();
    } else {
        currentState.OnStandingRespawn();
    }
}