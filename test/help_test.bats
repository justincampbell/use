load test_helper

@test "shows help when -h is passed" {
  run use -h

  echo $output | grep help
  [ $status -eq 0 ]
}

@test "shows help when --help is passed" {
  run use --help

  echo $output | grep help
  [ $status -eq 0 ]
}

@test "shows help when only help is passed" {
  run use help

  echo $output | grep help
  [ $status -eq 0 ]
}

@test "does not do anything else when showing help" {
  fixture "home-profile-with-echo" "$HOME/.profile"

  run use help

  echo $output | grep -v "echo from home profile"
  [ $status -eq 0 ]
}
