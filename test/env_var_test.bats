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

@test "exports USE with the current profile" {
  fixture "empty-profile" "$HOME/.profile"
  fixture "empty-profile" "$USE_DIR/my_company/.profile"

  run_script "
    use my_company
    env | grep USE=my_company
  "

  [ $status -eq 0 ]
}

@test "does not set USE if the profile is not found" {
  run_script "
    use missing
    env | grep USE=
  "

  [ $status -eq 1 ]
}

@test "does not set USE_PROFILE if the profile is not found" {
  run_script "
    use missing
    env | grep USE_PROFILE=
  "

  [ $status -eq 1 ]
}
