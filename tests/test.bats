setup() {
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=$(mktemp -d -t testmemcached-XXXXXXXXXX)
  export PROJNAME=testmemcached
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME} --project-type=drupal9 --docroot=web --create-docroot
  ddev start
}

teardown() {
  cd ${TESTDIR}
  ddev delete -Oy ${DDEV_SITENAME}
  rm -rf ${TESTDIR}
}

@test "basic installation" {
  cd ${TESTDIR}
  ddev get ${DIR}
  ddev restart
#  v=$(ddev exec 'printf "version\nquit\nquit\n" | nc memcached 11211')
#  [[ "${v}" = VERSION* ]]
#  res=$(ddev exec 'printf "list-tubes\nquit\n" | nc -C beanstalkd 11300')
#  [[ "${res}" = OK* ]]
#  status=$(ddev exec 'drush sapi-sl --format=json | jq -r .default_solr_server.status')
#  [ "${status}" = "enabled" ]
#  sleep 10 # After a restart, the solr server may not be ready yet.
#  ddev drush search-api-solr:reload default_solr_server

}
