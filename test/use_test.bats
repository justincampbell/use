#!/usr/bin/env bats

load test_helper

@test "sources a user profile" {
  fixture "home-profile-with-echo" "$HOME/.profile"

  run use

  echo $output

  [ "$output" = "sourced home profile" ]
}

@test "sources a user profile and company profile" {
  fixture "home-profile-with-echo" "$HOME/.profile"
  fixture "company-profile-with-echo" "$USE_DIR/my_company/.profile"

  run use my_company

  [ "${lines[0]}" = "sourced home profile" ]
  [ "${lines[1]}" = "sourced company profile" ]
}
