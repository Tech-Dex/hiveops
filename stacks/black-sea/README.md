# TrueNAS Dataset Structure


### Storage Overview
- `apps_pool/`: SSD-based — optimized for application configs and fast access.
- `media_pool/`: HDD-based — bulk storage for downloaded and organized media.

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

```
media_pool/
├── arr/
│ └── media/
│    ├── movies/
│    │  └── animes/
│    └── tv/ 
│       └── animes/
```

### Notes
This dataset structure is designed for educational purposes and does not represent a real stack. It serves as a template for organizing application configurations and media storage efficiently on TrueNAS systems. The structure can be adapted based on specific needs and preferences.