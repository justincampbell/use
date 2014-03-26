load test_helper

@test "shows help when -h is passed" {
  run use -h

  echo $output | grep "Usage:"
  [ $status -eq 0 ]
}

@test "shows help when --help is passed" {
  run use --help

  echo $output | grep "Usage:"
  [ $status -eq 0 ]
}

@test "shows help when only help is passed" {
  run use help

  echo $output | grep "Usage:"
  [ $status -eq 0 ]
}

@test "does not do anything else when showing help" {
  fixture "home-profile-with-echo" "$HOME/.profile"

  run use help

  echo $output | grep -v "echo from home profile"
  [ $status -eq 0 ]
}

@test "prints the version when --version is passed" {
  run use version

  echo $output | grep -E "[0-9]+\.[0-9]+\.[0-9]+"
}

@test "shows error and help if an invalid option is passed" {
  run use --foo

  echo ${lines[0]} | grep "not a valid"
  echo $output | grep "Usage:"
  [ $status -eq 1 ]
}
