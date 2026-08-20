#!/usr/bin/env bats

@test "dummy always passes" {
  run echo "OK"
  [ "$status" -eq 0 ]
}
