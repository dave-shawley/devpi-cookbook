@test "devpi-server is enabled" {
	test -e /etc/nginx/sites-available/devpi-server
	test -L /etc/nginx/sites-enabled/devpi-server
}
@test "nginx max body size is set" {
	grep -q 'client_max_body_size 0' /etc/nginx/sites-enabled/devpi-server
}
