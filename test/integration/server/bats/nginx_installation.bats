http_get() {
	if test -z "$HTTP_PROGRAM"
	then
		if which curl > /dev/null 2>&1
		then
			HTTP_PROGRAM="curl -o"
		else
			if which wget > /dev/null 2>&1
			then
				HTTP_PROGRAM="wget -O"
			else
				echo "*** Please make sure either wget or curl exist"
				exit 1
			fi
		fi
	fi
	$HTTP_PROGRAM $@
}
@test "nginx is installed" {
	PATH=/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin
	test -n "$(which nginx)"
}
@test "default site is disabled" {
	test ! -e /etc/nginx/sites-enabled/default
	test -e /etc/nginx/sites-available/default
}
@test "nginx is running" {
	pid=$(ps -A -opid,command | awk '$2 ~ /^nginx/ { print $1 }')
	test -n "$pid"
}
@test "devpi-server is available on port 80" {
	SITE_FILE=/etc/nginx/sites-enabled/devpi-server
	HOST=$(awk '/server_name/ { print $2 }' $SITE_FILE | tr -d ';')
	http_get /tmp/devpi-out http://localhost:3141
	http_get /tmp/nginx-out http://$HOST:80
	diff /tmp/devpi-out /tmp/nginx-out
	rm /tmp/devpi-out /tmp/nginx-out
}
