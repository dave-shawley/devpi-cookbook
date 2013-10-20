@test "virtual environment created for devpi-server" {
	test -d /opt/devpi-server
	test -x /opt/devpi-server/bin/python
}
