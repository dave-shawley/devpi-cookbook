@test "deleted server environment does not exist" {
	test ! -d /opt/devpi/should-not-exist
}

@test "nginx site is deleted" {
	test ! -e /etc/nginx/sites-available/should-be-removed
	test ! -e /etc/nginx/sites-enabled/should-be-removed
}
