bool g_allLocalSoundsPresent = true;

const string AudioRemoteUrl = "https://github.com/TheArcadion/tm-action-key-piano/raw/main/sounds";
const string AudioLocalPath = IO::FromStorageFolder("sounds");


void initLocalSoundsDir() {
	if (!IO::FolderExists(AudioLocalPath)) {
        IO::CreateFolder(AudioLocalPath);
    }
}

void refreshLocalSounds() {
	// Create dir if not exists
	initLocalSoundsDir();
	
	// Sound paths
	string[] toDownload;
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
}

string getLocalPath(PianoTypes type, MusicNote note) {
	return AudioLocalPath + "/" + type + "/" + resolveNotePath(note) + ".flac";
}

string getRemotePath(PianoTypes type, MusicNote note) {
	return AudioRemoteUrl + "/" + type + "/" + resolveNotePath(note) + ".flac";
}



AssetDownload@[] downloads;
const int c_simultaneousDownloads = 30;
void updateDownloads() {
	if (downloads.Length == 0) {
		g_allLocalSoundsPresent = true;
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
    }
}
