bool g_allLocalSoundsPresent = true;

const string AudioRemoteUrl = "https://github.com/TheArcadion/tm-action-key-piano/raw/main/sounds";
const string AudioLocalPath = IO::FromStorageFolder("sounds");


void initLocalSoundsDir() {
	if (!IO::FolderExists(AudioLocalPath)) {
        IO::CreateFolder(AudioLocalPath);
    }
}

bool refreshRequested = false;
bool failedDownloads = false;
void refreshLocalSounds() {
	refreshRequested = true;
	failedDownloads = false;
	// Create dir if not exists
	initLocalSoundsDir();
	
	// Sound paths active music notes
	for(uint i = 0; i < c_ActivePianoTypes.Length; i++) 
	{
		for(uint j = 0; j < c_ActiveMusicNotes.Length; j++) {
			// Check if audio is present already
			auto type = c_ActivePianoTypes[i];
			auto note = c_ActiveMusicNotes[j];
			auto localPath = getLocalPath(type, note);
			if (IO::FileExists(localPath)) continue;
			
			// Downloads missing file
			print("download " + type + " " + resolveNotePath(note));
			downloads.InsertLast(AssetDownload(getRemotePath(type, note), localPath));
			g_allLocalSoundsPresent = false;
		}
	}
	// Sound paths extra piano music notes
	for(uint i = 0; i < c_ActiveExtraPianoNotes.Length; i++) 
	{
		// Check if audio is present already
		auto note = c_ActiveExtraPianoNotes[i];
		auto localPath = getLocalPath(PianoTypes::Piano, note);
		if (IO::FileExists(localPath)) continue;
		
		// Downloads missing file
		print("download " + PianoTypes::Piano + " " + resolveNotePath(note));
		downloads.InsertLast(AssetDownload(getRemotePath(PianoTypes::Piano, note), localPath));
		g_allLocalSoundsPresent = false;
	}
	
	// Notify user if necessary
	if (downloads.Length > 0)
		UI::ShowNotification(Meta::ExecutingPlugin().Name, "Downloading " + downloads.Length + " sound files (max 20MB total), please wait...");
}

string getLocalPath(PianoTypes type, int note) {
	return AudioLocalPath + "/" + type + "/" + resolveNotePath(note) + ".flac";
}

string getRemotePath(PianoTypes type, int note) {
	return AudioRemoteUrl + "/" + type + "/" + resolveNotePath(note) + ".flac";
}



AssetDownload@[] downloads;
const int c_simultaneousDownloads = 30;
void updateDownloads() {
	if (g_allLocalSoundsPresent) return;
	if (!refreshRequested) return;
	if (downloads.Length == 0 && refreshRequested) {
		g_allLocalSoundsPresent = true;
		refreshRequested = false;
		if (!failedDownloads) 
			UI::ShowNotification(Meta::ExecutingPlugin().Name, "Sound files downloaded successfully");
		else {
			error("Failed downloading sound files. Please create an issue at https://github.com/TheArcadion/tm-action-key-piano/issues... Please include your <your_user>/OpenplanetNext/Openplanet.log file.");
			UI::ShowNotification(
				Meta::ExecutingPlugin().Name, 
				"Failed downloading sound files. Please create an issue at https://github.com/TheArcadion/tm-action-key-piano/issues...",
				vec4(.6, 0, 0, 1),
				30000
			);
		}
		return;
	}
	
    AssetDownload@ dl;
    for (int i = 0; i < Math::Min(c_simultaneousDownloads, downloads.Length); i++) {
        @dl = downloads[i];
        if (dl is null || dl.finished)
            downloads.RemoveAt(i);
        if (!dl.started)
            dl.Start();
    }
}


class AssetDownload {
    string url;
    string destination;

    bool started;
    bool finished;
	
    AssetDownload(const string &in url, const string &in destination) {
        this.url = url;
        this.destination = destination;
    }

    void Start() {
        if (started) return;
        started = true;
        startnew(CoroutineFunc(this.RunDownload));
        CheckDestinationDir();
    }

    void CheckDestinationDir() {
        auto parts = this.destination.Split("/");
        auto fileName = parts[parts.Length - 1];
        parts.RemoveLast();
        auto dir = string::Join(parts, "/");
        if (!IO::FileExists(dir) && !IO::FolderExists(dir)) {
            IO::CreateFolder(dir, true);
        }
    }

    void RunDownload() {
        uint failCount = 0;
        while (failCount < 3) {
            Net::HttpRequest@ req = Net::HttpGet(this.url);
            while (!req.Finished()) {
                yield();
            }
            this.finished = true;
            if (req.ResponseCode() == 200) {
                req.SaveToFile(this.destination);
                return;
            } else {
                failCount++;
				warn("Failed to download " + this.url);
				warn("Response code: " + req.ResponseCode());
				warn("Response body: " + req.String().SubStr(0, 100));
            }
        }
		failedDownloads = true;
    }
}
