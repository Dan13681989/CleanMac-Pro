#!/usr/bin/env bats

@test "cleanmac.sh file exists and is executable" {
  [ -x "./cleanmac.sh" ]
}
