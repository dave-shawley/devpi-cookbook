@test "nginx proxies to devpi-server" {
  HOST=$(hostname --fqdn)
  TMPFILE=$BATS_TMPDIR/root-pypi
  wget -q -O$TMPFILE http://$HOST/root/pypi
  grep 'type.*"indexconfig"' $TMPFILE
  grep 'type.*"mirror"' $TMPFILE
}
