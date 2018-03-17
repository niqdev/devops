# Linux

### Useful commands

```bash
# create nested directories
mkdir -p parent/child1/child2 && cd $_

# scroll file from bottom
less +G /var/log/auth.log

# find files
find /etc -name '*shadow'

# prints lines that match regexp
# -i case insensitive
# -v inverts the search
# -c count lines
grep -E '^root' /etc/passwd
# password encryption
grep password.*unix /etc/pam.d/*

# example substitution
echo -e "a='1st' b='2nd' c='3rd'\na='4th' b='5th' c='6th'" > test.txt
cat test.txt | sed -nE "s/^.*a='([^']*).*c='([^']*).*$/\2\n\1/gp" | sort -r | uniq

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

# unix timestamp
date +%s

# calendar
cal -3
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
du -sh /*

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
# open TCP ports
lsof -i -n -P | grep TCP

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
```

### Network

Documentation

* [Subnetting](https://gist.github.com/niqdev/1ab727c3c01de2993cad070c04ba8b47)

```bash
# active network interfaces
ifconfig

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
```

<br>
