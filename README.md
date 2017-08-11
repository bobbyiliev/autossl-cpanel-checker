# autossl-cpanel-checker
This is a short script that would loop though All of the domain names on your cPanel/WHM server, check if their A record is pointing to the server and if so check their SSL status. Then you would get a email if there are any SSL certificates that are about to expire in 'n' number of days. This is just an example, you can modify it so that it would match your needs.

You need to run it as root if you would like to monitor the SSL certificate status for all sites on a server.
