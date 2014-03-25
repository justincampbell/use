load test_helper

@test "prints the version" {
  run use version

  echo $output | grep -E "\d+\.\d+\.\d+"
}
