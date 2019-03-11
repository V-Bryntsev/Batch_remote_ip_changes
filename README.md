# Batch_remote_ip_changes
Batch remote IP changes script for windows clients

## Algorithm:
1. Read list of IPs from csv file
2. Create cycle by file lines
3. Ping old ip
4. Ping new ip
5. Get network adapter configuraton and change it
6. Ping new ip
7. Go to next ip in cycle
## Files:
1. ips.csv - example file with IP addresses. Firt string must be "old_ip;new_ip"!!
2. Batch_remote_ip_changes.ps1 - script for batch remote ip changes
