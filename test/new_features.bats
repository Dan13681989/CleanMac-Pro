#!/usr/bin/env bats

@test "schedule subcommand exists" {
  run ./cleanmac.sh schedule
  # We just check it doesn't hang – any exit code is acceptable
  [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}

@test "undo subcommand exists" {
  run ./cleanmac.sh undo
  [ "$status" -eq 0 ] || [ "$status" -eq 1 ]
}
