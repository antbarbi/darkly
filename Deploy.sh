VM_NAME=darkly
ISO=/home/$USER/Downloads/Darkly_i386.iso
DISK_PATH="/tmp/VirtualBox VMs/$VM_NAME.vdi"

# Ensure directory exists
mkdir -p "$(dirname "$DISK_PATH")"

# Remove existing VDI file if it exists
if [ -f "$DISK_PATH" ]; then
  echo "Removing existing disk image: $DISK_PATH"
  rm -f "$DISK_PATH"
fi

if VBoxManage showvminfo "$VM_NAME" &>/dev/null; then
  echo "Unregistering existing VM: $VM_NAME"
  VBoxManage unregistervm "$VM_NAME" --delete
fi

VBoxManage createvm --name $VM_NAME --register > /dev/null
VBoxManage modifyvm $VM_NAME  --memory 2048 --cpus 2 --vram 2 > /dev/null
VBoxManage modifyvm $VM_NAME  --nic1 nat --cableconnected1 on > /dev/null

# Port forwarding rules
VBoxManage modifyvm $VM_NAME --natpf1 "ssh,tcp,,2222,,22"       # SSH
VBoxManage modifyvm $VM_NAME --natpf1 "http,tcp,,8080,,80"      # HTTP
VBoxManage modifyvm $VM_NAME --natpf1 "https,tcp,,8443,,443"    # HTTPS

VBoxManage createmedium disk --filename "$DISK_PATH" --size 2000 > /dev/null
VBoxManage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$DISK_PATH"
VBoxManage storagectl $VM_NAME --name "IDE Controller" --add ide
VBoxManage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ISO"

VBoxManage startvm $VM_NAME --type headless