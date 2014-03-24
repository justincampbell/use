load test_helper

@test "unaliases" {
  alias foo=bar

  use
  run type foo

  [ $status -eq 1 ]
}
