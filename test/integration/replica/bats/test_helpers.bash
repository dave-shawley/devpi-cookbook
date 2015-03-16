http_get() {
	if test -z "$HTTP_PROGRAM"
	then
		if which curl > /dev/null 2>&1
		then
			HTTP_PROGRAM="curl -s"
		else
			if which wget > /dev/null 2>&1
			then
				HTTP_PROGRAM="wget -O-"
			else
				echo "*** Please make sure either wget or curl exist"
				exit 1
			fi
		fi
	fi
	$HTTP_PROGRAM $@
}
