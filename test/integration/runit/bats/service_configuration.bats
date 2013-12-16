@test "devpi-server is enabled" {
	test -e /etc/nginx/sites-available/devpi-server
	test -L /etc/nginx/sites-enabled/devpi-server
}
