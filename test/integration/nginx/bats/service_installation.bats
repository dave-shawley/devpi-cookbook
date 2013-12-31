@test "nginx is installed" {
	PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
	test -n "$(which nginx)"
}
@test "default site is disabled" {
	test ! -e /etc/nginx/sites-enabled/default
}
@test "nginx is running" {
	pid=$(ps -A -opid,command | awk '$2 ~ /^nginx/ {print $1}')
	test -n "$pid"
}
@test "nginx log directory exists" {
	test -d /var/log/devpi-server
}
@test "devpi-server is available on port 80" {
	SITE_FILE=/etc/nginx/sites-enabled/devpi-server
	HOST=$(awk '/server_name/ { print $2 }' $SITE_FILE | tr -d ';')
	wget -O /tmp/devpi-out http://localhost:3141
	wget -O /tmp/nginx-out http://$HOST:80
	diff /tmp/devpi-out /tmp/nginx-out
	rm /tmp/devpi-out /tmp/nginx-out
}
