# RemoveiCloudPhotosFromThisPC
This script serves to remove 'iCloud Photos' listed under 'This PC' in File Explorer in Windows. The shortcut is automatically created every time iCloud for Windows is installed or updated. Removal of the shortcut is not possible within File Explorer, but can be achieved by removing the shortcut's associated registry key.

The script will:
1. Find the registry key
2. Attempt to remove the registry key

Upon a successful removal of the registry key, a message of success will be printed. 'iCloud Photos' should no longer be listed under 'This PC' in File Explorer.

# Important
Editing registry requires elevated priveleges. Be sure to run the script as an Administrator.
