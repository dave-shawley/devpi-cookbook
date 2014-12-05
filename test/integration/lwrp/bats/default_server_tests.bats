@test "default-server virtualenv created" {
	test -d /opt/devpi/default-server
	test -x /opt/devpi/default-server/bin/python
}

@test "devpi user created" {
	IFS=: userdata=($(getent passwd devpi))
	test ${userdata[2]} -lt 1000
	test "${userdata[5]}" = "/opt/devpi/default-server"
	test "${userdata[6]}" = "/bin/false"
}

@test "devpi group created" {
	getent group devpi
}

@test "data directory is created" {
	test -d /etc/sudoers.d && echo "root ALL=(ALL:ALL) ALL" > /etc/sudoers.d/root
	sudo -u devpi test -w /opt/devpi/default-server/data
	sudo -u nobody -g devpi test -w /opt/devpi/default-server/data
}

@test "devpi-server installed into virtualenv" {
	test -x /opt/devpi/default-server/bin/devpi-server
	/opt/devpi/default-server/bin/devpi-server --help
}

@test "devpi-server is initialized" {
	test -e /opt/devpi/default-server/data/.event_serial
	test -e /opt/devpi/default-server/data/.secret
	test -e /opt/devpi/default-server/data/.sqlite
}
