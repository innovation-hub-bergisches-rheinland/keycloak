# Keycloak

A custom Keycloak distribution which is configured to use opinionated defaults and necessary extensions.
It is necessary because the new Keycloak operator using the Quarkus distribution does not bring built-in 
support for extensions. See: https://github.com/keycloak/keycloak/issues/10835

## Dependabot

The repository is configured using dependabot and it should automatically open PRs when a new upstream 
Keycloak version is available.

## Releasing

Either create a new git tag and push it manually:
```sh
git tag MAJOR.MINOR.PATCH
git push --follow-tags origin main
```