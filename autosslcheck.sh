#!/bin/bash

##
# AutoSSL expiration checker
# The script checks all domain names on the server
# If a domain name is pointed to one of the server's IP addresses the script would check for a valid SSL cetificate
# 2017 Bobby I.                       
##

# Enter your servername here:
server="example.servername.net"

# Enter your server IP address here:
serverip="8.8.8.8"

# Enter your Email address
email="myemai@mydomain.com"

# This would craete temp dir if it doesn't exist:
if [ ! -d /root/autosslcheck ]; then
  mkdir -p /root/autosslcheck;
fi

# The report will be saved here and then this temp file will be emailed over to you:
echo "Hello, this is a short report regarding the SSL certificates status on your $server server. Date: $(date)" > /root/autosslcheck/report.txt
echo "" >> /root/autosslcheck/report.txt

for i in $(cat /etc/userdomains | awk -F: '{ print $1 }'); do
        domainArecord=$(dig a +short $i)
        if [[ $domainArecord == *"$serverip"* ]]; then
                today=$(date +%F)
                expires=$(echo | openssl s_client -servername $i -connect $i:443 2>/dev/null | openssl x509 -noout -dates | grep 'notAfter' | sed 's/notAfter=//')
                daysleft=$(( ( $(date -ud "$expires" +'%s') - $(date -ud "$today" +'%s') )/60/60/24 ))
                daysleft=$((daysleft-1))
                if [ $daysleft -lt 14 ]; then
                        echo '' >> /root/autosslcheck/report.txt
                        echo "# The SSL certificate for $i expires in about: " >> /root/autosslcheck/report.txt
                        echo $daysleft days >> /root/autosslcheck/report.txt
                        echo '----' >> /root/autosslcheck/report.txt
                fi
        fi
done

sleep 1

mail -s "SSL report for: $server" $email < /root/autosslcheck/report.txt
