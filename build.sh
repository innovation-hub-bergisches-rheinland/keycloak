#!/usr/bin/env bash
set -euo pipefail

tag='custom-keycloak'

docker build --tag "${tag}" .
