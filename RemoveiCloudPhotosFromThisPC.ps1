#############################################################################################################################################
## 1. Running this script will remove 'iCloud Photos' icon from 'This PC' in Windows.													   ##
## 2. The icon reappears every time iCloud is updated.																					   ##	
## 3. The following is the full path to the 'iCloud Photos' Registry Key which you can manually remove if necessary:					   ##
##     'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}' ##
#############################################################################################################################################

Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{F0D63F85-37EC-4097-B30D-61B4A8917118}'

###############################################################################################################
## For more information, see: https://www.eightforums.com/general-support/35046-remove-icloud-photos-pc.html ##
###############################################################################################################

#########################
## Powershell Commands ##
#########################

#Remove-Item -Path 'HKLM:\SOFTWARE\Test\Key1'							# This removes key named 'Key1'
#Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Test\Key2' -Name 'hi'		# This removes value named 'hi' in key named 'Key2'
