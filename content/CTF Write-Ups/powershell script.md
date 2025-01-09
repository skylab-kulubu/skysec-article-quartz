---
title: Powershell Script
tags:
  - letsdefend
  - easy
  - soc
---
_You’ve come across a puzzling Base64 script, seemingly laced with malicious intent. Your mission, should you choose to accept it, is to dissect and analyze this script, unveiling its true nature and potential risks. Dive into the code and reveal its secrets to safeguard our digital realm. Good luck on this daring quest!_

![](https://miro.medium.com/v2/resize:fit:700/1*SEgm2y-Yr90PR0sjmnMrag.png)

Initial Desktop View

![](https://miro.medium.com/v2/resize:fit:700/1*3Q_dd8kbQNKOWB9bYkJKkw.png)

The PowerShell Script

![](https://miro.medium.com/v2/resize:fit:700/1*fIQLV3Xz0hWodCZCODWsgQ.png)

Decoded PowerShell Argument

- `powershell.exe`  
    This invokes the PowerShell executable to run commands.
- `-NoP` (NoProfile)  
    Prevents PowerShell from loading user profile scripts. This reduces execution time and bypasses any custom security configurations in the profile.
- `-sta` (Single Threaded Apartment)  
    Starts PowerShell in single-threaded mode, which is useful for certain operations, such as GUI or COM object interaction.
- `-NonI` (NonInteractive)  
    Runs PowerShell in non-interactive mode, meaning no user input is required. It allows the script to execute in the background without interaction.
- `-W Hidden` (WindowStyle Hidden)  
    Starts PowerShell with a hidden window, making it invisible to the user, which is critical for stealthy operations.
- `-Enc` (EncodedCommand)  
    Indicates that the following string is a Base64-encoded command. This encoding is used to obscure the actual command being executed, making it harder to detect or analyze.

# What encoding is the malicious script using?

Answer: Base64

# What parameter in the powershell script makes it so that the powershell window is hidden when executed?

Answer: -W hidden

# What parameter in the Powershell script prevents the user from closing the process?

Answer: -NoNI

# What line of code allows the script to interact with websites and retrieve information from them?

Answer: $WC=New-ObjEcT SySTeM.NET.WebCliENt

# What is the user agent string that is being spoofed in the malicious script?

Answer: Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko

# What line of code is used to set the proxy credentials for authentication in the script?

`Answer: $wc.PROxY.CrEdenTialS = [SysTem.NEt.CRedeNTIAlCAcHE]::DeFAULTNetWOrKCredENTiAls`

# When the malicious script is executed, what is the URL that the script contacts to download the malicious payload?

Answer: `http://98[.]103[.]103[.]170:7443/index[.]asp`