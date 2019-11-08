#!/bin/bash
# This test will verify that grub2-efi is correctly signed with correct cert in the CA chain

t_Log "Running $0 -  Verifying that grub2-efi is correctly signed with Fermi National Accelerator Laboratory"

arch=$(uname -m)

if [[ "$el_ver" -ge 7 && "$arch" = "x86_64" ]] ; then
  if [ ! -f /boot/efi/EFI/eurolinux/grubx64.efi ];then
    t_Log "grub2-efi not installed, can't test... skipping"
    exit 0
  fi
  t_InstallPackage pesign grub2-efi
  pesign --show-signature --in /boot/efi/EFI/redhat/grubx64.efi|egrep -q 'Fermi National Accelerator Laboratory'
  t_CheckExitStatus $?
else
  t_Log "previous versions than EuroLinux 7 - or not x86_64 arch - aren't using secureboot ... skipping"
  exit 0
fi

