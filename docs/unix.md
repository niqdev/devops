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
cat test.txt | sed -nE "s/^.*a='([^']*).*c='([^']).*$/c=\2 a=\1/gp" | sort -r | uniq > result.txt

# extract 2nd string i.e. "2nd: bbb"
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
TODO

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

jq
http
```
