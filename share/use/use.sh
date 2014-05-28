#!/bin/bash

USE_DIR=${USE_DIR:-$HOME/.use}
USE_ENV_PATTERNS=(
  AWS
  EC2
  FOG
  KNIFE
  OPSCODE
)
USE_VERSION="0.2.0"

use_help() {
  echo "use $USE_VERSION"
  echo "github.com/justincampbell/use"
  echo ""
  echo "  Usage:"
  echo "    use                 reset, source home profile"
  echo "    use my_company      reset, source home and my_company profiles"
  echo "    use help/-h/--help  show this help"
  echo "    use --version       show the version"
  echo ""
}

use_unalias() {
  unalias -a
}

use_unset_env_vars() {
  for env_var in $(env | cut -f 1 -d "=" | sort); do
    for pattern in "${USE_ENV_PATTERNS[@]}"; do
      if [[ $env_var =~ $pattern ]]; then
        unset $env_var
      fi
    done
  done
}

use_home() {
  source $HOME/.profile
}

use_company() {
  export USE="$1"

  if [[ "$USE" != "" ]]; then
    export USE_PROFILE=$USE_DIR/$USE/.profile

    if [[ ! -f $USE_PROFILE ]]; then
      echo "$USE_PROFILE not found"
      unset USE USE_PROFILE
      return 1
    fi

    source $USE_PROFILE
  fi
}

use() {
  case "$1" in
    -h|--help|help)
      use_help
      ;;
    --version|version)
      echo $USE_VERSION
      ;;
    *-*)
      echo "$@ is not a valid option"
      use_help
      exit 1
      ;;
    *)
      use_unalias
      use_unset_env_vars
      use_home
      use_company $1
      ;;
  esac
}
