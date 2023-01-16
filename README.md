# Keycloak

[![Docker Repository on Quay](https://quay.io/repository/innovation-hub-bergisches-rheinland/keycloak/status "Docker Repository on Quay")](https://quay.io/repository/innovation-hub-bergisches-rheinland/keycloak)

A custom Keycloak distribution which is configured to use opinionated defaults and necessary extensions.
It is necessary because the new Keycloak operator using the Quarkus distribution does not bring built-in 
support for extensions. See: https://github.com/keycloak/keycloak/issues/10835

## Dependabot

The repository is configured using dependabot and it should automatically open PRs when a new upstream version is available.
Whenever an update for Keycoak is available it will be automatically merged and a new reelase will be created.

## Releasing

Create a new git tag and push it manually:
```sh
tag="v<MAJOR>.<MINOR>.<PATCH>[-<PRERELEASE>]"
git tag "$tag"
git push origin "$tag"
```