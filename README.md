softlayer
=========

Tools and bits for SoftLayer related stuff.  Requires the Softlayer API http://sldn.softlayer.com/

Have some SLAPI fun!

Gateway Fix:  tools/getSLgateways.rb
=========
Have a lot of servers?  Softlayer wants you to re-ip them?  Here's a script to fix all the routes via their proper gateways
so private traffic doesn't choke the backbone.

Edit the file and add your SL credentials and change the output directories.  This will create both the /etc/sysconfig/route-* file as well as
a cli route command to run so you won't need to reboot.




Donations:

DVC: 12VfaJToeCxRAU36bWfehBBooLeBaKx4tP        
BTC: 13SiDLjdg6qbjnQeHVEZBbPUBz8UNdKuMG        LTC: LPG57GTMr7uiasi8UzzkiJLMV8GfohLVfA
