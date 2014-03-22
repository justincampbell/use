#!/usr/bin/env bats

load test_helper

@test "sources a user profile" {
  fixture "home-profile-with-echo" "$HOME/.profile"

  run use

  [ $output = "sourced home profile" ]
  [ $status -eq 0 ]
}

@test "sources a user profile and company profile" {
  fixture "home-profile-with-echo" "$HOME/.profile"
  fixture "company-profile-with-echo" "$USE_DIR/my_company/.profile"

  run use my_company

  [ ${lines[0]} = "sourced home profile" ]
  [ ${lines[1]} = "sourced company profile" ]
  [ $status -eq 0 ]
}

@test "sources a user profile and fails on a missing company profile" {
  fixture "home-profile-with-echo" "$HOME/.profile"

  run use missing

  [ ${lines[0]} = "sourced home profile" ]
  [ ${lines[1]} = "$USE_DIR/missing/.profile not found" ]
  [ $status -eq 1 ]
}
