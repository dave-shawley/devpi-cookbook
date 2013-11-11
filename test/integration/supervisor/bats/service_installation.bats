@test "supervisor is installed" {
	PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/opt/local/sbin"
	PATH="$PATH:/bin:/usr/bin:/usr/local/bin:/opt/local/bin"
	test -n "$(which supervisorctl)"
	test -d /etc/supervisor.d
}
