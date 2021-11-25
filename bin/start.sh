#!/bin/bash
set -euo pipefail

set -x

[ -z ${CDK_EMQX_CLUSTERNAME+x} ] &&
    CDK_EMQX_CLUSTERNAME=$(git config --get user.name | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]//g')

docker run -e CDK_EMQX_CLUSTERNAME=${CDK_EMQX_CLUSTERNAME} --rm -it \
       -v ~/.aws:/root/.aws \
       -v $(pwd):/opt/ \
       -w /opt \
       --entrypoint /opt/bin/container-entrypoint.sh \
       contino/aws-cdk "$@"
