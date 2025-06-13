# TrueNAS Dataset Structure


### Storage Overview
- `apps_pool/`: SSD-based — optimized for application configs and fast access.
- `media_pool/`: HDD-based — bulk storage for downloaded and organized media.

### Hardlink Note
In order to have hardlinks works properly the `/media` and `/torrents` directories must be on the same filesystem.
That means they must be on the same dataset, so `/arr` is a dataset that contains both `media` and `torrents` directories.


### 📦 Proposed Dataset Tree
```
apps_pool/
├── configs/
│ └── arr/
│ │   ├──  bazarr/
│ │   ├──  bazarr-anime/
│ │   ├──  jellyfin/
│ │   ├──  jellyseerr/
│ │   ├──  prowlarr/
│ │   ├──  qbittorrent/
│ │   ├──  radarr/
│ │   ├──  radarr-anime/
│ │   ├──  sonarr/
│ │   └──  sonarr-anime/
```
mkdir -p media/movies media/movies-animes media/tv media/tv-animes
mkdir -p torrents/movies torrents/movies-animes torrents/tv torrents/tv-animes
```
media_pool/
├── arr/
│ └── media/
│ │  ├── movies/
│ │  ├── movies-animes/
│ │  ├── tv/ 
│ │  └── tv-animes
│ └── torrents/
│ │   ├── movies/
│ │   ├── movies-animes/
│ │   ├── tv/
│ │   └── tv-animes/
```

### Notes
This dataset structure is designed for educational purposes and does not represent a real stack. It serves as a template for organizing application configurations and media storage efficiently on TrueNAS systems. The structure can be adapted based on specific needs and preferences.