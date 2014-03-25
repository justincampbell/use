load test_helper

@test "unaliases previous aliases" {
  fixture "home-profile-with-alias" "$HOME/.profile"

  run_script "
    alias foo=true
    use
    alias | grep foo
  "

  [ $status -eq 1 ]
}

@test "home profile aliases are re-aliased" {
  fixture "home-profile-with-alias" "$HOME/.profile"

  run_script "
    use
    alias | grep alias_from_home_profile
  "

  [ $status -eq 0 ]
}

@test "company profile aliases are re-aliased" {
  fixture "home-profile-with-alias" "$HOME/.profile"
  fixture "company-profile-with-alias" "$USE_DIR/my_company/.profile"

  run_script "
    use my_company
    alias | grep alias_from_company_profile
  "

  [ $status -eq 0 ]
}
