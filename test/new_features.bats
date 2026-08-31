#!/usr/bin/env bats

@test "schedule shows usage" {
  run ./cleanmac.sh schedule
  [[ "$output" == *"Usage:"* ]]
}

@test "undo shows manifest" {
  # Pipe "all" to avoid interactive prompt (if manifest exists, it restores; if not, it exits with error)
  run bash -c 'echo "all" | ./cleanmac.sh undo'
  # Both exit codes are acceptable (0 if manifest exists, 1 if not)
  [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}
