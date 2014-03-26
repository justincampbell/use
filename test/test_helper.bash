USE_SETUP=bin/use-setup

setup() {
  rm -rf $BATS_TMPDIR/use

  HOME=$BATS_TMPDIR/use/HOME
  USE_DIR=$BATS_TMPDIR/use/USE_DIR

  mkdir -p $HOME
  mkdir -p $USE_DIR

  source $USE_SETUP
}

teardown() {
  echo $output
}

fixture() {
  mkdir -p $(dirname $2)
  cp "test/fixtures/$1" "$2"
}

run_script() {
  RUN_SCRIPT=$BATS_TMPDIR/use/run_script.sh
  echo "$1" > $RUN_SCRIPT
  chmod +x $RUN_SCRIPT
  run . $RUN_SCRIPT
}
