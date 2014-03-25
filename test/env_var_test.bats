load test_helper

@test "unsets environment variables containing AWS" {
  fixture "empty-profile" "$HOME/.profile"

  run_script "
    export AWS_ACCESS_KEY_ID=abc123
    use
    env | grep AWS
  "

  [ $status -eq 1 ]
}

@test "does not unset other environment variables" {
  fixture "empty-profile" "$HOME/.profile"

  run_script "
    export FOO=bar
    use
    env | grep FOO
  "

  [ $status -eq 0 ]
}

@test "allows overriding of USE_ENV_PATTERNS" {
  fixture "empty-profile" "$HOME/.profile"

  run_script "
    export USE_ENV_PATTERNS=(FOO BAR)
    export AWS_ACCESS_KEY_ID=abc123
    use
    env | grep AWS
  "

  [ $status -eq 0 ]
}
