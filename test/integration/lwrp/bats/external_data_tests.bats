load test_helpers

@test "external-data-server virtualenv created" {
	verify_virtualenv /opt/devpi/external-data-server
}

@test "external-data-server is correctly installed" {
	verify_devpi_server /opt/devpi/external-data-server '' /opt/devpi/data
}

@test "external data directory is created" {
	ensure_root_can_group_sudo
	sudo -u devpi test -w /opt/devpi/data
	sudo -u nobody -g devpi test -w /opt/devpi/data
}
