#!/usr/bin/env bats

@test "dummy test always passes" {
  run echo "Hello from CleanMac-Pro tests!"
  [ "$status" -eq 0 ]
}
