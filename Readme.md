## Get-VMLoggedOnUsers

This script connects to a vCenter Server and grabs all VMs in a particular folder, in this example "Workstation". It only selects powered on VMs running a Windows OS.

The script then iterates against each VM returned and connects to the VM to gather logged on users.

It only returns domain users, so not any local/system accounts and excludes the user account running the script as this is seen as a connection to the remote VMs.

The script can be used to perform an action depending on whether there are or are not logged on users.

In this example, if there are no logged on users, VMTools can be updated.