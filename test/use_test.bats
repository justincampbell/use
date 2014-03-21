USE_SETUP=bin/use-setup

setup() {
  OLD_HOME=$HOME

  HOME=$BATS_TMPDIR/HOME
  USE_DIR=$BATS_TMPDIR/USE_DIR

  mkdir -p $HOME
  mkdir -p $USE_DIR

  source $USE_SETUP
}

teardown() {
  HOME=$OLD_HOME

  use
}

fixture() {
  mkdir -p $(dirname $2)
  cp "test/fixtures/$1" "$2"
}

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
