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

kvm -smp 2 -m 1500 -netdev user,id=mynet0,hostfwd=tcp::8022-:22,hostfwd=tcp::8090-:80 -device virtio-net-pci,netdev=mynet0 -vga qxl -drive file=$IMG,format=raw
