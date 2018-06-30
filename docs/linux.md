# Linux

Resources

* [How Linux Works](https://amzn.to/2lHW1cB) (2014)(2nd) by Brian Ward (Book)

### Useful commands

```bash
# create nested directories
mkdir -p parent/child1/child2 && cd $_

# scroll file from bottom
less +G /var/log/auth.log
# follow also if doesn't exist
tail -F /var/log/auth.log

# find files
find /etc -name '*shadow'

# prints lines that match regexp
# -i case insensitive
# -v inverts the search
# -c count lines
grep -E '^root' /etc/passwd
# password encryption
grep password.*unix /etc/pam.d/*

# sed = stream editor
# example substitution
echo -e "a='1st' b='2nd' c='3rd'\na='4th' b='5th' c='6th'" > test.txt
cat test.txt | sed -nE "s/^.*a='([^']*).*c='([^']*).*$/\2\n\1/gp" | sort -r | uniq
# delete lines three through six
sed 3,6d /etc/passwd

# pick a single field out of an input stream
ls -l | awk '{print $9}'
# extract 2nd string
echo "aaa bbb ccc" > test.txt
cat test.txt | awk '{printf("2nd: %s\n",$2)}'

# pack archive
tar cvf archive.tar file1 file2
# table-of-content
tar tvf archive.tar
# unpack archive
tar xvf archive.tar -C output
# compress and pack archive
tar zcvf archive.tar.gz /path/to/images/*.jpg
# unpack compressed archive
tar zxvf archive.tar.gz

# pack archive
zip -r backup.zip file-name directory-name
# zip with password (prompt)
zip -e backup.zip file-name
# unpack jar
unzip my-lib.jar -d /tmp/my-lib

# count lines
wc -l file

# lowercase random uuid
uuidgen | tr "[:upper:]" "[:lower:]"

# number of bytes
stat --printf="%s" file

# calculator
echo 1+2 | bc
# print number in binary base 2 format
echo 'obase=2; 240' | bc
# reverse-polish calculator
echo '1 2 + p' | dc
# evaluate expressions
expr 1 + 2

# unix timestamp
date +%s
# timestamp in microsecond
date +%s%N

# calendar
cal -3

# configure kernel parameters at runtime
sysctl

# test conditions ([)
test a = a && echo equal

# create temporary file
mktemp
# X is a template
mktemp /tmp/my-tmp.XXXXXX
# signal handler to catch the signal that CTRL-C generates and remove the temporary files
TMPFILE=$(mktemp /tmp/my-tmp.XXXXXX)
trap "rm -f $TMPFILE; exit 1" INT

# compare files
diff FILE1 FILE2

# here document
DATE=$(date)
cat <<EOF
Date: $DATE
line1
line2
EOF

# strip full path and extension if specified e.g. mail
basename /var/log/mail.log .log

# image conversion
giftopnm
pnmtopng

# when operating on huge number of files to avoid buffer issues
# e.g. verify file's type
# INSECURE find . -name '*.md' -print | xargs file
# change the find output separator and the xargs argument delimiter from a newline to a NULL character
# two dashes if there is a chance that any of the target files start with a single dash
find . -name '*.md' -print0 | xargs -0 file --
# supply a {} to substitute the filename and a literal ; to indicate the end of the command
find . -name '*.md' -exec file {} \;

# replaces current shell process with the program you name after exec system call
# after you press CTRL-D or CTRL-C to terminate the cat program,
# your window should disappear because its child process no longer exists
exec cat

# subshell example () e.g. path remains the same outside
(PATH=/bad/invalid:$PATH; echo $PATH)
# fast way to copy and preserve permissions
tar cf - orig | (cd target; tar xvf -)

# X Window System
xwininfo
xlsclients -l
xev
xinput --list
dbus-monitor --system
dbus-monitor --session

# compile C program
cc -o hello hello.c
# list shared library (so)
ldd /bin/bash
```

Script templates
```bash
# shebang
#!/bin/sh
#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

# import
. imported_file.sh
source imported_file.sh

# read and store in a variable
read MY_VAR
echo $MY_VAR
# read stdin
read -p "Are you sure? [y/n]" -n 1 -r
```

### Diagnostic

```bash
# sysfs info
udevadm info --query=all --name=/dev/xvda
# monitor kernel uevents
udevadm monitor

# view kernel's boot and runtime diagnostic messages
dmesg | less

# system logs paths configuration
vim /etc/rsyslog.conf
vim /etc/rsyslog.d/50-default.conf
# test system logger
logger -p mail.info mail-message
tail -n 1 /var/log/syslog
```

### Filesystem

```bash
# copy data in blocks of a fixed size
# /dev/zero is a continuous stream of zero bytes
dd if=/dev/zero of=DUMP_FILE bs=1024 count=1

# view partition table
# use (g)parted only for partioning disk (supports MBR and GPT)
sudo parted -l

# create filesystem
mkfs -t ext4 /dev/PARTITION_NAME
ls -l /sbin/mkfs.*

# list devices and corresponding filesystems UUID
blkid
# list attached filesystems
mount
# mount device on mount point
mount -t ext4 /dev/PARTITION_NAME /MOUNT/POINT
# mount filesystem by its UUID
mount UUID=xxx-yyy-zzz /MOUNT/POINT
# make changes permanent after reboot
echo "UUID=$(sudo blkid -s UUID -o value /dev/PARTITION_NAME)      /MOUNT/POINT   ext4    defaults,nofail        0       2" | sudo tee -a /etc/fstab
# mount all filesystems
mount -a
# unmount (detach) a filesystem
umount /dev/PARTITION_NAME

# view size and utilization of mounted filesystems
df -h
# disk usage
du -sh /* | sort -g
# disk size
fdisk --list

# check memory and swap size
free -h

# (1) create swap file (~1GB)
dd if=/dev/zero of=/dev/SWAP_FILE bs=1024 count=1024000
# (2) create swap file (2GB)
fallocate -l 2G /dev/SWAP_FILE
# change owner and permissions
chown root:root /dev/SWAP_FILE
chmod 0600 /dev/SWAP_FILE
# put swap signature on partition
mkswap /dev/SWAP_FILE
# register space with the kernel
swapon /dev/SWAP_FILE
# make changes permanent after reboot
echo "/dev/SWAP_FILE    none    swap    sw    0   0" | tee -a /etc/fstab
# list swap partitions
swapon --show

# simple static server on port 8000
python -m SimpleHTTPServer

# copy directory to remote host
scp -r directory remote_host:~/new-directory
tar cBvf - directory | ssh remote_host tar xBvpf -
rsync -az directory remote_host:~/new-
# equivalent to /*
# -nv dry run
rsync -a directory/ remote_host:~/new-directory
```

### Monitoring

```bash
# list processes
# m show threads
ps aux

# display current system status
# Spacebar Updates the display immediately
# M Sorts by current resident memory usage
# T Sorts by total (cumulative) CPU usage
# P Sorts by current CPU usage (the default)
# u Displays only one user’s processes
# f Selects different statistics to display
# ? Displays a usage summary for all top commands
top
top -p PID1 PID2
# alternatives
htop
atop

# monitor system performance
vmstat 2

# list open files and the processes using them
lsof | less
lsof /dev

# print all the system calls that a process makes
strace cat /dev/null
strace uptime
# track shared library calls
ltrace ls /

# CPU usage
/usr/bin/time ls

# change process priority (-20 < nice value < +20)
renice 20 PID

# load average: for the past 1 minute, 5 minutes and 15 minutes
uptime

# check memory status
free
cat /proc/meminfo

# check major/minor page faults
/usr/bin/time cal > /dev/null

# show statistics for machine’s current uptime (install sysstat)
iostat
# show partition information
iostat -p ALL

# show I/O resources used by individual processes
iotop

# see the resource consumption of a process over time
pidstat -p PID 1

# reports CPU and IO stats
iostat -mt 2

# system resource statistics
dstat
```

### Network

```bash
# active network interfaces
ifconfig
# enable/disable network interface
ifconfig NETWORK_INTERFACE up
ifconfig NETWORK_INTERFACE down

# show routing table
# Destination: network prefix e.g. 0.0.0.0/0 matches every address (default route)
# flag U: up
# flag G: gateway
# convention: the router is usually at address 1 of the subnet
route -n

# ICMP echo request
# icmp_req: verify order and no gap
# time: round-trip time
ping -c 3 8.8.8.8

# show path packets take to a remote host
traceroute 8.8.8.8

# (DNS) find the IP address behind a domain name
host www.github.com

# network manager
nmcli
nmcli device show
# returns zero as its exit code if network is up
nm-online
# network details e.g. ssid/password
cat /etc/NetworkManager/system-connections/NETWORK_NAME

# override hostname lookups
vim /etc/hosts

# traditional configuration file for DNS servers
cat /etc/resolv.conf
# DNS settings
cat /etc/nsswitch.conf

# static IP
/etc/network/interfaces

# -t Prints TCP port information
# -u Prints UDP port information
# -l Prints listening ports
# -a Prints every active port
# -n Disables name lookups (speeds things up; also useful if DNS isn’t working)
# list open TCP connections
netstat -nt
# print listening TCP ports
netstat -ntl
# list running services
netstat -plunt

# processes listening on open TCP ports
lsof -i -n -P | grep TCP
lsof -iTCP -sTCP:LISTEN
# process running on specific port
lsof -n -i:PORT_NUMBER
# list unix domain socket
lsof -U

# well-known ports
cat /etc/services

# release IP with DHCP
dhclient -r NETWORK_INTERFACE_NAME
# renew IP
dhclient -v NETWORK_INTERFACE_NAME

# public IP via external services
http ident.me
http ipv4.ident.me
http ipv6.ident.me
http icanhazip.com
http ipv4.icanhazip.com
http ipv6.icanhazip.com

# Linux kernel does not automatically move packets from one subnet to another
# enable temporary IP forwarding in the router's kernel
sysctl -w net.ipv4.ip_forward
# change permanent configs upon reboot
vim /etc/sysctl.conf

# example NAT (IP masquerading)
sysctl -w net.ipv4.ip_forward
iptables -P FORWARD DROP
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

# firewalling on individual machines is sometimes called IP filtering
# firewall rules in series or chain make up a table
# INPUT chain: protect individual machine
# FORWARD chain: protect a network of machines
# show iptable configuration
iptables -L
# block IP
iptables -A INPUT -s BLOCKED_IP -j DROP
# block IP/port
iptables -A INPUT -s BLOCKED_IP/CIDR -p tcp --destination-port BLOCKED_PORT -j DROP
# allow IP (insert at the bottom)
iptables -A INPUT -s ALLOWED_IP -j ACCEPT
# allow IP (insert at the top)
iptables -I INPUT -s ALLOWED_IP -j ACCEPT
# allow IP (specify order)
iptables -I INPUT RULE_NUMBER -s ALLOWED_IP -j ACCEPT
# delete rule #number in chain
iptables -D INPUT RULE_NUMBER

# show ARP kernel cache
arp -n

# list wireless network
iw dev NETWORK_INTERFACE scan
# show details of connected network
iw dev NETWORK_INTERFACE link

# manage both authentication and encryption for a wireless network interface
wpa_supplicant
```

### Applications

```bash
# old insecure
telnet www.wikipedia.org 80
# press enter twice after
GET / HTTP/1.0

# details about communication
curl --trace-ascii trace_file https://www.wikipedia.org > /dev/null
vim trace_file

# sshd server configs
vim /etc/ssh/sshd_config
# generate key pair
ssh-keygen -t rsa -b 4096 -C KEY_NAME -N "PASSPHRASE" -f KEY_PATH

# list network interfaces
tcpdump -D
# sniff hex and ascii (-A) by interface/host/port
tcpdump -XX -n -i INTERFACE_NAME tcp and host IP_ADDRESS and port PORT_NUMBER

# Swiss Army knife
# banner grabbing
cat <(echo HEAD / HTTP/1.0) - | netcat IP_ADDRESS PORT_NUMBER
# install traditional (with -e option)
apt-get install netcat -y
# choose /bin/nc.traditional
update-alternatives --config nc
# listen on server
netcat -l -p 6996 -e /bin/bash
# run client
cat <(echo ls -la) - | netcat IP_ADDRESS 6996

# scan open ports
nmap -Pn IP_ADDRESS

# other
# * ssh/scp/sftp/rsync
# * curl/wget

# system calls
man recv
man send
```

### Useful links

* [Subnetting](https://gist.github.com/niqdev/1ab727c3c01de2993cad070c04ba8b47)
* [OpenWrt](https://openwrt.org)
* [BusyBox](https://www.busybox.net)
* [Netfilter](https://netfilter.org/index.html)
* [Iptables Essentials](https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands)
* [iptables vs nftables](https://unixia.wordpress.com/2015/12/16/iptables-vs-nftables)
* [Shorewall](http://www.shorewall.net)
* [Nmap](https://nmap.org)
* [tshark](https://hackertarget.com/tshark-tutorial-and-filter-examples)
* [Postfix](http://www.postfix.org)
* [HTTPie](https://httpie.org)
* [jq](https://stedolan.github.io/jq)
* [Linux Performance](http://www.brendangregg.com/linuxperf.html)
* [Samba](https://www.samba.org)
* [Program Library HOWTO](https://www.dwheeler.com/program-library)

<br>
