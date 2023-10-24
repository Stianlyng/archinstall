username='stian'

sudo pacman -Syu virt-manager qemu-desktop dnsmasq iptables-nft

sudo systemctl enable --now libvirtd.service

#1. Create kvm and libvirt groups if not present
sudo groupadd -f kvm
sudo groupadd -f libvirt

# 2. Add current user to kvm and libvirt groups
sudo usermod -aG libvirt $username
sudo usermod -aG kvm $username

# 3. Add these two lines at the end of /etc/libvirt/libvirtd.conf
unix_sock_group = "libvirt"
unix_sock_ro_perms = "0777"
unix_sock_rw_perms = "0770"

# 4. Add these two lines at the end of /etc/libvirt/qemu.conf
swtpm_user = "swtpm"
swtpm_group = "swtpm"
user = $username
group = $username

# After Reboot.  Delete the default QEMU/KVM System/Root Session” connection
# And add a new one using QEMU/KVM User Session:
# File > Add Connection > Hypervisor: “QEMU/KVM User Session” > Autoconnect > “Enable”



# Also might need this to allow editing guests?
# yay -S libguestfs
#
# See archinstall/assets/guides/How to install Virt-Manager Complete Edition – Discovery (10_24_2023 9_46_09 PM).html
