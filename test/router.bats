#!/usr/bin/env bats

@test "cleanmac.sh shows usage without arguments" {
  run ./cleanmac.sh
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "cleanmac.sh lists subcommands" {
  run ./cleanmac.sh
  [[ "$output" == *"schedule"* ]] || [[ "$output" == *"undo"* ]]
}

@test "cleanmac.sh unknown subcommand returns error" {
  run ./cleanmac.sh unknown-command
  [ "$status" -ne 0 ]
  [[ "$output" == *"Unknown subcommand"* ]]
}

@test "subcommand schedule shows usage" {
  run ./cleanmac.sh schedule
  [[ "$output" == *"Usage:"* ]]
}
