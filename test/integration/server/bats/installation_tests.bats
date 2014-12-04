@test "virtual environment created for devpi-server" {
	test -d /opt/devpi-server
	test -x /opt/devpi-server/bin/python
}

@test "administrative user and group are created" {
	grep -q devpi /etc/passwd
	grep -q devpi /etc/group
	test "$(id -gn devpi)" = "daemon"
	id -Gn devpi | grep -q devpi
}

@test "devpi-server installed into virtual environment" {
	test -x /opt/devpi-server/bin/devpi-server
}
