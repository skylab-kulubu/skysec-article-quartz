---
title: Jingle Bell
tags:
  - htb
  - sherlock
  - soc
  - easy
---

#### Author: **lomar**
![lomar](https://www.hackthebox.com/badge/image/1506415)

---

# Sherlock Scenario

_Torrin is suspected to be an insider threat in Forela. He is believed to have leaked some data and removed certain applications from their workstation. They managed to bypass some controls and installed unauthorised software. Despite the forensic team’s efforts, no evidence of data leakage was found. As a senior incident responder, you have been tasked with investigating the incident to determine the conversation between the two parties involved._

We will perform analysis on the wpndatabase.db file located at Jingle Bell/Torrincase/C/Users/Appdata/Local/Microsoft/Windows/Notifications/. You can use SQLite DB browser.

![](https://miro.medium.com/v2/resize:fit:628/1*zg6ImIsjlps6xAUiSNABRA.png)

![](https://miro.medium.com/v2/resize:fit:700/1*mC-lue_C-NRgxLxhw4pF_g.png)

## Q1) Which software/application did Torrin use to leak Forela’s secrets?

Here is the message from cyberjunkie.

```
<toast activationType="protocol" launch="slack://channel?id=D0544UUC4UB&amp;message=1681985806.920359&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message from cyberjunkie</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev accepted your invitation to join Slack — take a second to say hello.</text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/35f6a85490effd9267c1e097b456bc77.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

A: **Slack**

## Q2) What’s the name of the rival company to which Torrin leaked the data

In the title field of header, **PrimeTech Innovations** written.

```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681986088.823219&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: Hello torrin, did you managed to find the files related to the the Forela Oil extraction plan in Angola?</text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

A: **PrimeTech Innovations**

## Q3) What is the username of the person from the competitor organization whom Torrin shared information with?

A: **Cyberjunkie-PrimeTechDev**

## Q4) What’s the channel name in which they conversed with each other?

A: **forela-secrets-leak**

## Q5) What was the password for the archive server?

```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681986665.563319&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: Just to confirm as we dont want forela's IT team to get suspicious  
            Password for the archive server is :  
            "Tobdaf8Qip$re@1"  
         </text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681986724.763179&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: Confirmation that password is  "Tobdaf8Qip$re@1"</text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

A: **Tobdaf8Qip$re@1**

## Q6) What was the URL provided to Torrin to upload stolen data to?
```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681986817.216049&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: Okay so i am sending you a google drive link where you can upload all other information you gathered so far.</text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

A: [**https://drive.google.com/drive/folders/1vW97VBmxDZUIEuEUG64g5DLZvFP-Pdll?usp=sharing**](https://drive.google.com/drive/folders/1vW97VBmxDZUIEuEUG64g5DLZvFP-Pdll?usp=sharing)

```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681986889.660179&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: https://drive.google.com/drive/folders/1vW97VBmxDZUIEuEUG64g5DLZvFP-Pdll?usp=sharing , remember to upload the documents and pdfs too</text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```

## Q7) When was the above link shared with Torrin?

The message value of the toast tag gives us the timestamp value, we need to convert it to date value.

[https://www.epochconverter.com/](https://www.epochconverter.com/)

![](https://miro.medium.com/v2/resize:fit:700/1*lBIyg4NFVmTn1D1tLAAMMg.png)

or you can use Python

```python
import datetime  
time_stamp = "1681986889.660179"  
print(datetime.datetime.fromtimestamp(float(time_stamp)))
```

## Q8) For how much money did Torrin leak Forela’s secrets?
```
<toast activationType="protocol" launch="slack://channel?id=C05451QSQM8&amp;message=1681987020.043589&amp;team=T054518ADUJ&amp;origin=notification">  
   <header id="T054518ADUJ" title="PrimeTech Innovations" activationType="protocol" arguments="slack://channel?team=T054518ADUJ"></header>  
   <visual>  
      <binding template="ToastGeneric">  
         <text hint-wrap="false" hint-maxLines="1">New message in #forela-secrets-leak</text>  
         <text hint-maxLines="10" hint-style="bodySubtle" hint-wrap="true">Cyberjunkie-PrimeTechDev: Bank Account Number: 03135905179789  
            Sent 10,000 £ to the above account as promised, cheers  
         </text>  
         <image placement="appLogoOverride" hint-crop="circle" src="C:/Users/CYBERJ~1/AppData/Local/Temp/Notification Cache/5ad0b5f5ad7976cea80bb0ae6af2cebf.png"/>  
      </binding>  
   </visual>  
   <audio silent="true"/>  
</toast>
```
A: **£10000**