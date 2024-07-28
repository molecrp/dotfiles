#!/bin/sh
case $1 in

  "nvim")
    nvim -v | head --lines=1 | sed "s/NVIM/Neovim/g"
    ;;

  "qemu")
    qemu-system-x86_64 -version | head --lines 1 | sed "s/emulator version /v/g"
    ;;

  "docker")
    docker --version | python3 -c "import re, sys; comp = re.compile('[0-9]+\.[0-9]+\.[0-9]+'); [print('Docker v' + (comp.findall(line))[0]) for line in sys.stdin]"
    ;;

  "containerd")
    containerd --version | ruby -e "version = gets.match(/containerd\s(?!\s)v[0-9]+.[0-9]+.[0-9]+/); puts version[0]"
    ;;

  "firefox")
    firefox-bin --version || firefox --version
    ;;

  *)
    echo "err"
    ;;
esac
