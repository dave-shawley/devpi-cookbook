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
