PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# fonts color
Green="\033[32m"
Red="\033[31m"
Yellow="\033[33m"
GreenBG="\033[42;37m"
RedBG="\033[41;37m"
Font="\033[0m"
# fonts color

DOMAIN=$(cat /conf/account.conf | awk -F= '{if($1~"DOMAIN")print $2}')
DNSAPI=$(cat /conf/account.conf | awk -F= '{if($1~"DNSAPI")print $2}')

cat >/var/spool/cron/crontabs/root<<EOF
0 0 3 * * /conf/acme.sh >/dev/null 2>&1
EOF

if [ ! -f "/ssl/${DOMAIN}.cer" ] && [ -n "${DOMAIN}" ]; then
    /conf/acme.sh
fi

/entry.sh daemon
