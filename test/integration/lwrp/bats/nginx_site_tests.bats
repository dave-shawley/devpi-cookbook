load test_helpers

@test "nginx-enabled virtualenv created" {
	verify_virtualenv /opt/devpi/nginx-enabled
}

@test "nginx-enabled is correctly installed" {
	verify_devpi_server /opt/devpi/nginx-enabled
}

@test "nginx-enabled data directory is created" {
	ensure_root_can_group_sudo
	sudo -u devpi test -w /opt/devpi/nginx-enabled/data
	sudo -u nobody -g devpi test -w /opt/devpi/nginx-enabled/data
}

@test "nginx site is enabled" {
	test -e /etc/nginx/sites-enabled/devpi
}

@test "nginx site uses correct port" {
	grep 'proxy_pass.*3144;' /etc/nginx/sites-enabled/devpi
}

@test "default nginx site is disabled" {
	test ! -e /etc/nginx/sites-enabled/default
}
