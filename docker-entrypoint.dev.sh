#!/usr/bin/env bash
set +e

bundle check || bundle install --jobs="$(nproc)"

exec "$@"
