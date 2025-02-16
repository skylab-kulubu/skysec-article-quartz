---
title: Port Forwarding
tags:
  - guide
aliases:
  - port_forward
---

#### Author: **lomar**
![lomar](https://www.hackthebox.com/badge/image/1506415)

---

# Port Forwarding
When local services that listen to the IPv4 address `127.0.0.1` are running on the target machine, we may need to access these services from our host machine, in such cases we can access this service by forwarding the port number on which the local service is running to our host machine. We can basically do port forwarding with 3 methods.
# Method 1: SSH
If we can access the victim machine with `SSH`, we can easily perform port forwarding with `SSH` connection.  If you want to perform both port forwarding and getting shell:
```bash
ssh user_name@victim.htb -L local_port:127.0.0.1:remote_port
```
For example:
- There is a service running on port `8080` and listening `127.0.0.1` in victim machine
- We want to forward it to port `8080` of our machine
```bash
ssh user_name@victim.htb -L 8080:127.0.0.1:8080
```

## Running Background
If you only want to perform port forwarding and do not want to run commands with `SSH`:
```bash
ssh user_name@victim.htb -fNL local_port:127.0.0.1:remote_port
```
For example:
- There is a service running on port `8080` and listening `127.0.0.1` in victim machine
- We want to forward it to port `8080` of our machine
```bash
ssh user_name@victim.htb -fNL 8080:127.0.0.1:8080
```
# Method 2: Meterpreter portfwd
The `portfwd` command from within the **Meterpreter** shell is most commonly used as a pivoting technique, allowing direct access to machines otherwise inaccessible from the attacking system. Running this command on a compromised host with access to both the attacker and destination network (or system), we can essentially forward TCP connections through this machine, effectively making it a pivot point. Much like the port forwarding technique used with an ssh connection, `portfwd` will relay TCP connections to and from the connected machines.
```meterpreter
meterpreter > portfwd -h
Usage: portfwd [-h] [add | delete | list | flush] [args]
OPTIONS:
     -L <opt>  The local host to listen on (optional).
     -h        Help banner.
     -l <opt>  The local port to listen on.
     -p <opt>  The remote port to connect on.
     -r <opt>  The remote host to connect on.
meterpreter >
```
- `-L`: Use to specify the listening host. Unless you need the forwarding to occur on a specific network adapter you can omit this option. If none is entered `0.0.0.0` will be used.
- `-h`: Displays the above information.
- `-l`: This is a local port which will listen on the attacking machine. Connections to this port will be forwarded to the remote system.
- `-p`: The port to which TCP connections will be forward to.
- `-r`: The IP address the connections are relayed to (target).
## Add
```meterpreter
meterpreter > portfwd add –l <local_port> –p <target_port> –r  <target_ip>
```
## Delete
```meterpreter
meterpreter > portfwd delete –l <local_port> –p <target_port> –r <target_ip>
```

For example:
- There is a service running on port `8080` and listening `127.0.0.1` in victim machine
- We want to forward it to port `8080` of our machine
```meterpreter
meterpreter > portfwd add –l 8080 –p 8080 –r  127.0.0.1
```

## Flush
This argument will allow us to **remove all the local port forward at once**.
```meterpreter
meterpreter > portfwd flush
```
# Method 3: [Chisel](https://github.com/jpillora/chisel)
## Linux
### Server
To work with Chisel, we first need to run a Chisel server on our host machine, by specifying the port(s) we want to listen to.
```bash
chisel server --port 51234
```
### Client
To route local services to our host, we will run chisel client on the victim machine and route port(s) to our host.
```bash
chisel client your_machine_ip:51234 127.0.0.1:8001:127.0.0.1:8001 127.0.0.1:8443:127.0.01:8443
```
## Windows
## Server
```powershell
$scriptBlock = { Start-Process C:\Windows\Temp\chisel.exe -ArgumentList @('client','10.0.0.2:8080','R:127.0.0.1:33060:127.0.0.1:3306','R:127.0.0.1:8800:127.0.0.1:80') }
Start-Job -ScriptBlock $scriptBlock
```
## Client
```powershell
$scriptBlock = { Start-Process C:\Windows\Temp\chisel.exe -ArgumentList @('server','--port 50001','--socks5') }
Start-Job -ScriptBlock $scriptBlock
```