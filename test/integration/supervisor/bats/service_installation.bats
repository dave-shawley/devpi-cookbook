@test "supervisor is installed" {
	PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/local/sbin"
	PATH="$PATH:/bin:/usr/bin:/usr/local/bin:/opt/local/bin"
	test -n "$(which supervisorctl)"
	test -d /etc/supervisor.d
}

@test "devpi server is configured & managed by supervisor" {
	conf_file=/etc/supervisor.d/devpi-server.conf
	test -e $conf_file
	grep -q 'command=/opt/devpi-server/bin/devpi-server' $conf_file
	grep -q 'command=.* --serverdir /opt/devpi-server/data' $conf_file
	grep -q 'command=.* --port 3141' $conf_file
	grep -q 'autostart=true' $conf_file
	grep -q 'autorestart=true' $conf_file
	grep -q 'user=devpi' $conf_file
}
