# Unix

### Basic commands

```bash
# create nested directories
mkdir -p parent/child1/child2 && cd $_

# find files
find /etc -name '*shadow'

# prints lines that match regexp
# -i case insensitive
# -v inverts the search
# -c count lines
grep -E '^root' /etc/passwd

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

# calculator
echo 1+2 | bc

# count lines
wc -l file

# lowercase random uuid
uuidgen | tr "[:upper:]" "[:lower:]"

# number of bytes
stat --printf="%s" file
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
dd if=/dev/zero of=/dev/SWAP_NAME bs=1024 count=1024000
# (2) create swap file (2GB)
fallocate -l 2G /dev/SWAP_NAME
# change owner and permissions
chown root:root /dev/SWAP_NAME
chmod 0600 /dev/SWAP_NAME
# put swap signature on partition
mkswap /dev/SWAP_NAME
# register space with the kernel
swapon /dev/SWAP_NAME
# make changes permanent after reboot
echo "/dev/SWAP_NAME    none    swap    sw    0   0" | tee -a /etc/fstab
# list swap partitions
swapon --show
```

### Monitoring

```bash
TODO

# list processes
ps aux
```

### Other

```bash
TODO

# sysfs info
udevadm info --query=all --name=/dev/xvda
# monitor kernel uevents
udevadm monitor

jq
http
```
