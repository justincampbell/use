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
