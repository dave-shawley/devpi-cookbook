verify_devpi_server() {
	server_root=$1
	version=$2
	daemon_user=${3:-devpi}

	sudo -u $daemon_user test -x "$server_root/bin/devpi-server"
	output=$("$server_root/bin/devpi-server" --version)
	test $? -eq 0
	test -z "$version" -o "$output" = "$version"

	test -e "$server_root/data/.event_serial"
	test -e "$server_root/data/.secret"
	test -e "$server_root/data/.sqlite"
}

verify_user() {
	user_name=$1
	user_home=$2
	user_shell=${3:-/bin/false}

	IFS=: userdata=($(getent passwd $user_name))
	test ${userdata[2]} -lt 1000
	test ${userdata[5]} = $user_home
	test ${userdata[6]} = $user_shell
}

verify_virtualenv() {
	test -d "$1"
	test -x "$1/bin/python"
}

# Many installations of sudo do no permit root to run commands with a
# non-login group specified.  Call this function to ensure that root
# has the appropriate privilege assigned to "sudo -g"
ensure_root_can_group_sudo() {
	if ! test -d /etc/sudoers.d
	then
		mkdir /etc/sudoers.d
		chown root /etc/sudoers.d
		chgrp root /etc/sudoers.d
		chmod 0750 /etc/sudoers.d
	fi

	if ! grep -q 'root *ALL=(ALL:ALL) *ALL' /etc/sudoers /etc/sudoers.d/*
	then
		echo 'root ALL=(ALL:ALL) ALL' > /etc/sudoers.d/root
	fi
}
