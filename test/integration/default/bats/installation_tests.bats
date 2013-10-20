@test "virtual environment created for devpi-server" {
	test -d /opt/devpi-server
	test -x /opt/devpi-server/bin/python
}

@test "administrative user is created" {
	grep -q devpi /etc/passwd
	test "$(id -gn devpi)" = "daemon"
}

@test "devpi-server installed into virtual environment" {
	test -x /opt/devpi-server/bin/devpi-server
}
