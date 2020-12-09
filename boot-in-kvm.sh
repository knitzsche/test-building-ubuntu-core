#!/bin/bash
help() {
  echo "Command requires one arg: path to img file to boot in kvm."
  exit
}

if [ "$#" -ne 1 ]; then
    help
    exit 1
fi

IMG=$1

sudo qemu-system-x86_64 -smp 1 -m 2048 \
 -net nic,model=virtio -net user,hostfwd=tcp::8022-:22 \
 -drive file=/usr/share/OVMF/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on \
 -drive file=$IMG,cache=none,format=raw,id=disk1,if=none \
 -device virtio-blk-pci,drive=disk1,bootindex=1 -machine accel=kvm
