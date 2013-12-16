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
