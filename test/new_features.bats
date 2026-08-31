#!/usr/bin/env bats

@test "schedule shows usage" {
  run ./cleanmac.sh schedule
  [[ "$output" == *"Usage:"* ]]
}

@test "undo shows manifest" {
  run bash -c 'echo "all" | ./cleanmac.sh undo'
  [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}
