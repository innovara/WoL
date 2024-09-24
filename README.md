# WoL.sh -  Shell script to send WoL magic packets

## Introduction

WoL.sh is a relatively simple shell script to send Wake-on-LAN magic packets to the broadcast or to an specific IP address and / or port.

## How to use it

Firstly, you need to enable Wake-on-LAN on the device you want to turn on. On most devices, that means accessing their UEFI (BIOS on much older systems) settings and enabling it.

Secondly, you need at least the MAC address of the card in which you have enabled Wake-on-LAN. You can easily obtain that with `ip addr show` or `ifconfig` in Linux or `ipconfig` in Windows.

Lastly, execute the script as per below.

## Syntax

```
 WoL.sh --mac <MAC> --ip <IP> --port <PORT>

 OPTIONS

 --mac|-m
   MAC address of the device you want to turn on.
   Mandatory.

 --ip|-i
   IP address to send the magic packet to.
   Optional.
   Default is to broadcast to all IPs (255.255.255.255).

 --port|-p
   Port to send the magic packet to.
   Optional.
   Default is 9.

 --help|-h
   This help.
```

## Troubleshooting

The easiest way to start troubleshooting is to run Wireshark using the wol display filter. Please note that if you use the IP option and you are not running Wireshark on the computer with that IP, it will never receive it.