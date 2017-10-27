#!/bin/bash

test_standard_ops() {
  # Padded for pretty output
  suite_name="STANDARD    "

  pushd ${home} > /dev/null
    pushd operations > /dev/null
      if interpolate ""; then
        pass "cf-deployment.yml"
      else
        fail "cf-deployment.yml"
      fi
      check_interpolation "aws.yml"
      check_interpolation "azure.yml"
      check_interpolation "bosh-lite.yml"
      check_interpolation "cf-syslog-skip-cert-verify.yml"
      check_interpolation "configure-confab-timeout.yml" "-v confab_timeout=60"
      check_interpolation "configure-default-router-group.yml" "-v default_router_group_reservable_ports=1234-2024"
      check_interpolation "disable-router-tls-termination.yml"
      check_interpolation "enable-cc-rate-limiting.yml" "-v cc_rate_limiter_general_limit=blah" "-v cc_rate_limiter_unauthenticated_limit=something"
      check_interpolation "enable-privileged-container-support.yml"
      check_interpolation "enable-uniq-consul-node-name.yml"
      check_interpolation "non-collocated-cf-syslog-drain.yml"
      check_interpolation "openstack.yml"
      check_interpolation "override-app-domains.yml" "-l example-vars-files/vars-override-app-domains.yml"
      check_interpolation "rename-deployment.yml" "-v deployment_name=renamed_deployment"
      check_interpolation "rename-network.yml" "-v network_name=renamed_network"
      check_interpolation "scale-to-one-az.yml"
      check_interpolation "stop-skipping-tls-validation.yml"
      check_interpolation "use-azure-storage-blobstore.yml" "-l example-vars-files/vars-use-azure-storage-blobstore.yml"
      check_interpolation "use-blobstore-cdn.yml" "-l example-vars-files/vars-use-blobstore-cdn.yml"
      check_interpolation "use-compiled-releases.yml"
      check_interpolation "use-external-dbs.yml" "-l example-vars-files/vars-use-external-dbs.yml"
      check_interpolation "use-latest-stemcell.yml"
      version=$(bosh interpolate ${home}/cf-deployment.yml -o use-latest-stemcell.yml --path=/stemcells/alias=default/version)
      if [ "${version}" == "latest" ]; then
        pass "use-latest-stemcell.yml"
      else
        fail "use-latest-stemcell.yml, expected 'latest' but got '${version}'"
      fi
      version=$(bosh interpolate ${home}/cf-deployment.yml -o windows-cell.yml -o use-latest-windows-stemcell.yml --path=/stemcells/alias=windows2012R2/version)
      if [ "${version}" == "latest" ]; then
        pass "use-latest-windows-stemcell.yml"
      else
        fail "use-latest-windows-stemcell.yml, expected 'latest' but got '${version}'"
      fi
      check_interpolation "use-postgres.yml"
      check_interpolation "use-s3-blobstore.yml" "-l example-vars-files/vars-use-s3-blobstore.yml"
      check_interpolation "use-swift-blobstore.yml" "-l example-vars-files/vars-use-swift-blobstore.yml"
      check_interpolation "use-trusted-ca-cert-for-apps.yml" "-l example-vars-files/vars-use-trusted-ca-cert-for-apps.yml"
      check_interpolation "windows-cell.yml"
    popd > /dev/null # operations
  popd > /dev/null
}
