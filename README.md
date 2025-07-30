# WoL.sh -  Shell script to send WoL magic packets

## Introduction

WoL.sh is a relatively simple shell script to send or only generate Wake-on-LAN magic packets to the broadcast or to a specific IP address and / or port.

## How to use it

Firstly, you need to enable Wake-on-LAN on the device you want to turn on. On most devices, that means accessing their UEFI (BIOS on much older systems) settings and enabling it.

Secondly, you need at least the MAC address of the card for which you have enabled Wake-on-LAN. You can easily obtain that with `ip addr show` or `ifconfig` in Linux or `ipconfig` in Windows.

Lastly, execute the script as per below.

## Syntax

```
 ./WoL.sh --mac <MAC> [OPTIONS...]

 OPTIONS

 --mac|-m
   MAC address of the device you want to turn on (format: XX:XX:XX:XX:XX:XX).
   Mandatory.

 --ip|-i
   IP address to send the magic packet to.
   Optional.
   Default is to broadcast to all IPs (255.255.255.255).

 --port|-p
   Port to send the magic packet to.
   Optional.
   Default is 9.

 --dry-run|-d
   Don't send the magic packet, just print the command.
   Optional.

 --verbose|-v
   Print the command used to send magic packet.
   Optional.

 --help|-h
   Show this help message.

 EXAMPLES

 ./WoL.sh --mac 00:11:22:33:44:55
 ./WoL.sh -m 00:11:22:33:44:55 -i 192.168.1.100 -p 7
 ./WoL.sh --mac 00:11:22:33:44:55 --dry-run --verbose
```

## Troubleshooting

The easiest way to start troubleshooting is to run Wireshark using the wol display filter. Please note that if you use the IP option and you are not running Wireshark on the computer with that IP, Wireshark will never capture the packet because it will not reach that computer.