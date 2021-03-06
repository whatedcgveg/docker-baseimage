#!/bin/env bats

setup() {
    load setup_common
    load setup_container_daemon
}

teardown() {
    load teardown_container_daemon
}

@test "Checking that the /tmp directory is cleaned when CLEAN_TMP_DIR=1..." {
    [ -n "$CONTAINER_ID" ]

    docker exec "$CONTAINER_ID" sh -c "touch /tmp/test_file"

    docker restart "$CONTAINER_ID"
    sleep 5

    docker exec "$CONTAINER_ID" sh -c "[ ! -f /tmp/test_file ]"
}
