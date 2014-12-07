load test_helpers

@test "version-specific virtualenv created" {
	verify_virtualenv /opt/devpi/devpi-server-2.0.0
}

@test "version-specific server is correctly installed" {
	verify_devpi_server /opt/devpi/devpi-server-2.0.0
}

@test "version-specific data directory is created" {
	ensure_root_can_group_sudo
	sudo -u devpi test -w /opt/devpi/devpi-server-2.0.0/data
	sudo -u nobody -g devpi test -w /opt/devpi/devpi-server-2.0.0/data
}
