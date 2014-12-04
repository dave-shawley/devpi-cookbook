@test "devpi client is installed" {
	test -x /opt/devpi-server/bin/devpi
	/opt/devpi-server/bin/devpi --version
}
