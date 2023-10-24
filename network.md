# Add mounts etcc
```
sudo mount -t nfs 192.168.1.5:volume1/media $HOME/nas/media

sudo mount -t nfs 192.168.1.5:volume1/Public $HOME/nas/public
sudo mount -t nfs 192.168.1.5:volume1/Vault $HOME/nas/vault
```

might be nice to mount in home for correct permissions

unmount with:
```
sudo umount /mnt/nas
```

# startup script??
```
#!/bin/bash

# Replace with your home network SSID or a specific IP range
HOME_SSID="your_home_SSID"

# Get the current SSID
CURRENT_SSID=$(iwgetid -r)

if [ "$CURRENT_SSID" == "$HOME_SSID" ]; then
  mount /mnt/nas
fi
```

# fstab

```
192.168.1.5:/volume1/media /mnt/nas nfs timeo=50,bg,defaults 0 0
```
If the first mount attempt fails, the bg option will cause the system to retry the mount in the background, allowing the boot process to continue.

The timeo parameter sets the NFS timeout value in deciseconds (tenths of a second). For example, setting timeo=50 would set the timeout to 5 seconds.

# vpn
todo

# mullvad
todo

# modem
todo
