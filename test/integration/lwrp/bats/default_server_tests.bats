load test_helpers

@test "default-server virtualenv created" {
	verify_virtualenv /opt/devpi/default-server
}

@test "devpi user created" {
	verify_user devpi /opt/devpi/default-server
}

@test "devpi group created" {
	getent group devpi
}

@test "default-server is correctly installed" {
	verify_devpi_server /opt/devpi/default-server
}

@test "default-server data directory is created" {
	ensure_root_can_group_sudo
	sudo -u devpi test -w /opt/devpi/default-server/data
	sudo -u nobody -g devpi test -w /opt/devpi/default-server/data
}
