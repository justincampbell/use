USE_SETUP=bin/use-setup

setup() {
  HOME=$BATS_TMPDIR/HOME
  USE_DIR=$BATS_TMPDIR/USE_DIR

  mkdir -p $HOME
  mkdir -p $USE_DIR

  source $USE_SETUP
}

fixture() {
  mkdir -p $(dirname $2)
  cp "test/fixtures/$1" "$2"
}
