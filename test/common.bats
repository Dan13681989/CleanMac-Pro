#!/usr/bin/env bats

load "$BATS_TEST_DIRNAME/../lib/common.sh"

@test "log_info prints with [INFO]" {
  run log_info "Test message"
  [ "$status" -eq 0 ]
  [[ "$output" == *"[INFO]"* ]]
}

@test "move_to_trash respects DRY_RUN" {
  DRY_RUN=true
  run move_to_trash /tmp/somefile
  [[ "$output" == *"[DRY RUN]"* ]]
}

@test "check_dependency detects existing command" {
  run check_dependency bash
  [ "$status" -eq 0 ]
}
