@test "nginx is installed" {
	PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
	test -n "$(which nginx)"
}
@test "default site is disabled" {
	test ! -e /etc/nginx/sites-enabled/default
}
