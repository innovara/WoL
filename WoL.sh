#   
#   WoL.sh -  Shell script to send WoL magic packets
#   
#   Copyright (C) 2024, Manuel Fombuena <mfombuena@innovara.co.uk>
#   
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#   
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#   
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <https://www.gnu.org/licenses/>.
#   

export PATH=/sbin:/usr/sbin:$PATH

### HELP STARTS ###
usage() {
  echo "

 Shell script to send a magic packet to turn on a device with Wake-On-LAN enabled.

 SYNTAX

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
 "
  exit 1
}
### HELP ENDS ###

### VARIABLE INITIALIZATION STARTS ###
mac=''
ip='255.255.255.255'
port=9
### VARIABLE INITIALIZATION ENDS ###

### ARGUMENT PROCESSING STARTS ###
while true ; do
  case $1 in
    --help|-h)
      usage
      ;;
    --mac|-m)
      mac=${2//:/}
      shift
      ;;
    --ip|-i)
      ip="${2}"
      shift
      ;;
    --port|-p)
      port="${2}"
      shift
      ;;
    --*|-*)
      echo "ERROR:  invalid syntax. Use -h for help."
      exit 2
      ;;
    *)
      break
  esac
  shift
done
### ARGUMENT PROCESSING ENDS ###

### ARGUMENT HANDLING STARTS ###
if [[ -z "${mac}" ]]; then
  echo "ERROR:  invalid syntax. You need at least -m <MAC>."
  exit 2
elif [[ ${port} -gt 65535 ]]; then
  echo "ERROR:  port number cannot exceed 65,535."
  exit 2
fi
### ARGUMENT HANDLING ENDS ###

# Magic packet contains 6 bytes of all 255 (FF FF FF FF FF FF in hexadecimal), followed by sixteen repetitions of the target computer's 48-bit MAC address
# More info on https://en.wikipedia.org/wiki/Wake-on-LAN#Magic_packet
magicpacket=$(echo $(printf "f%.0s" {1..12}; printf "$mac%.0s" {1..16}) | sed -e 's/../\\x&/g')

printf "Sending magic packet..."
echo -e $magicpacket | nc -u $ip $port
printf "\033[0;32m Done!\n"
