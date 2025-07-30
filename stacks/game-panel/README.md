# Game Panel Setup

## File Permissions

After deployment, set the correct permissions for log storage (bug in pterodactyl panel?):
```sh
chown -R nginx:nginx /app/storage/logs
```

## Environment Configuration

Set the `APP_KEY` in your `.env` file. You can generate a secure key using one of the following commands:

```bash
head -c 32 /dev/urandom | base64
# or (PowerShell)
[Convert]::ToBase64String((1..32 | ForEach-Object {Get-Random -Maximum 256}) -as [byte[]])
```

## Create Admin User

To create an admin user, exec into the container and run:

```sh
php artisan p:user:make --email=admin@domain.com --username=admin --name-first=admin --name-last=user --password=admin --admin=1 --no-password
```

## Reverse Proxy Configuration

If using Nginx Proxy Manager (or another reverse proxy), configure the scheme for Wings as:

```
http://wings:443
```

Enable websocket support


## Network Configuration

To configure a unique network for Wings, specify the following IPv4 and IPv6 settings:

**IPv4**
- **Subnet:** `172.16.50.0/24`
- **Gateway:** `172.16.50.1`

**IPv6**
- **Subnet:** `fdd0:0:0:5::/64`
- **Gateway:** `fdd0:0:0:5::1`

## Directory Structure

### Storage Overview

- **apps_pool/**: SSD-backed storage, ideal for application configurations and fast-access data.
- **secure_pool/**: HDD-backed storage with RAID1 redundancy, designed for secure backups and sensitive data.

### 📦 Proposed Dataset Tree

Organize your game panel files using the following structure for optimal performance and reliability:

```sh
mkdir -p apps_pool/configs/pterodactyl/panel
mkdir -p apps_pool/configs/pterodactyl/wings
mkdir -p secure_pool/pterodactyl/backup
```

```
apps_pool/
└── configs/
    └── pterodactyl/
        ├── panel/
        └── wings/

secure_pool/
└── pterodactyl/
    └── backup/
```
