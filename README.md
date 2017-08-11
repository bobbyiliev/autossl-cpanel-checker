# autossl-cpanel-checker
This is a short script that would loop though All of the domain names on your cPanel/WHM server, check if their A record is pointing to the server and if so check their SSL status. Then you would get a email if there are any SSL certificates that are about to expire in 'n' number of days. This is just an example, you can modify it so that it would match your needs.

This is quite useful for monitoring the status of your SSL certificates and also if you have a lot of sites hosted on your server and you do not have the time to check each SSL certificate manually.

You need to run it as root if you would like to monitor the SSL certificate status for all sites on a server.

Just use this as cron job, here's an example
 - Copy the content of the file and add it to your server
 - Make the file executable by the user:
chmod u+x /root/autosslcheck/autosslcheck.sh
 - Open your crontab:
# crontab -e
 - And add:
# 0 7 * * * /root/autosslcheck/autosslcheck.sh

That is pretty much it, this would run the script every morning at 7 and you will get an email!

Make sure to update the variables in the script accordingly. 
