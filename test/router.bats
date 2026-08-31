#!/usr/bin/env bats

# Test that the main router works
@test "cleanmac.sh shows usage without arguments" {
  run ./cleanmac.sh
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "cleanmac.sh lists subcommands" {
  run ./cleanmac.sh
  [[ "$output" == *"ai-optimizer"* ]]
  [[ "$output" == *"network-optimizer"* ]]
}

@test "cleanmac.sh unknown subcommand returns error" {
  run ./cleanmac.sh unknown-command
  [ "$status" -ne 0 ]
  [[ "$output" == *"Unknown subcommand"* ]]
}

# Test a specific subcommand (network-optimizer)
@test "network-optimizer --help works" {
  run ./cleanmac.sh network-optimizer --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}
