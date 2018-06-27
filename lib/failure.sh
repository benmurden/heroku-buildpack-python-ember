fail_bin_install() {
  local bin="$1"
  local version="$2"

  # re-curl the result, saving off the reason for the failure this time
  local error=$(curl --silent --get --retry 5 --retry-max-time 15 --data-urlencode "range=$version" "https://nodebin.herokai.com/v1/$bin/$platform/latest.txt")

  if [[ $error = "No result" ]]; then
    case $bin in
      node)
        echo "Could not find Node version corresponding to version requirement: $version";;
      iojs)
        echo "Could not find Iojs version corresponding to version requirement: $version";;
      yarn)
        echo "Could not find Yarn version corresponding to version requirement: $version";;
    esac
  else
    echo "Error: Invalid semantic version \"$version\""
  fi

  false
}