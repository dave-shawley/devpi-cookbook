@test "runit is installed" {
	PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/local/sbin
	PATH=$PATH:/bin:/usr/bin:/usr/local/bin:/opt/local/bin
	test -n "$(which sv)"
	test -n "$(which runsvdir)"
	test -d /etc/service
}

@test "devpi-server job is installed" {
	test -d /etc/service/devpi-server
	test -d /etc/service/devpi-server/log
	test -d /etc/service/devpi-server/supervise
	test -x /etc/service/devpi-server/run
}

@test "devpi-server job parameters are set" {
	config_line=$(grep '^exec chpst' /etc/service/devpi-server/run)
	echo $config_line | grep -- 'exec chpst .* -u devpi '
	echo $config_line | grep -- '"/opt/devpi-server/bin/devpi-server"'
	echo $config_line | grep -- '--port 3141[^0-9]'
	echo $config_line | grep -- '--serverdir "/opt/devpi-server/data"'
}

@test "devpi-server job is running" {
	/etc/init.d/devpi-server status | grep '^run: '
}
