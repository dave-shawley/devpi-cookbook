load test_helpers

@test "master is listening on configured port" {
	http_get 'http://localhost:3142/+status' | grep role | grep MASTER
}

@test "replica is listening on configured port" {
	http_get 'http://localhost:3143/+status' | grep role | grep REPLICA
}

@test "replica is connected to master" {
	master_url=`http_get 'http://localhost:3143/+status' | sed -ne '/master-url/s/^.*: "\([^"]*\)".*$/\1/p'`
	test "$master_url" = "http://localhost:3142"
}

@test "master is connected to replica" {
	http_get 'http://localhost:3142/+status' | grep -A10 polling_replicas | grep 'remote-ip.*127.0.0.1'
}
