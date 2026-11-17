#!/usr/bin/env bats
# Tests for the "Update image tag" step's `run` script in
# .github/workflows/gitops-deploy.yml. The script is extracted straight out
# of the workflow YAML with yq and executed verbatim, so there is no
# separate copy of the logic that could drift from production.

WORKFLOW="${BATS_TEST_DIRNAME}/../.github/workflows/gitops-deploy.yml"

setup() {
  WORKDIR="$(mktemp -d)"
  FILE="${WORKDIR}/application.yaml"
  SCRIPT="$(yq -r '.jobs.deploy.steps[] | select(.name == "Update image tag") | .run' "${WORKFLOW}")"
}

teardown() {
  rm -rf "${WORKDIR}"
}

run_script() {
  # Matches GitHub Actions' default `run:` shell (bash --noprofile --norc -eo pipefail {0}).
  VERSION="$1" FILE="$FILE" PACKAGE="$2" run bash -eo pipefail -c "$SCRIPT"
}

@test "the step can be extracted from the workflow" {
  [ -n "$SCRIPT" ]
}

@test "form 1: replaces tag: value and keeps the depName comment" {
  cat > "${FILE}" <<EOF
spec:
  source:
    tag: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/mogenius-ai-config
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -eq 0 ]
  grep -q "tag: 1.1.0 # datasource=docker depName=ghcr.io/mogenius/mogenius-ai-config" "${FILE}"
}

@test "form 1: replaces targetRevision: value and keeps the depName comment" {
  cat > "${FILE}" <<EOF
spec:
  source:
    targetRevision: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/mogenius-ai-config
EOF

  run_script "2.0.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -eq 0 ]
  grep -q "targetRevision: 2.0.0 # datasource=docker depName=ghcr.io/mogenius/mogenius-ai-config" "${FILE}"
}

@test "form 2: replaces the inline tag on an image: line and keeps the renovate comment" {
  cat > "${FILE}" <<EOF
foo:
  image: ghcr.io/mogenius/mogenius-ai-config:1.0.0 # renovate
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -eq 0 ]
  grep -q "image: ghcr.io/mogenius/mogenius-ai-config:1.1.0 # renovate" "${FILE}"
}

@test "form 2: matches without a trailing comment" {
  cat > "${FILE}" <<EOF
foo:
  image: ghcr.io/mogenius/mogenius-ai-config:1.0.0
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -eq 0 ]
  grep -q "image: ghcr.io/mogenius/mogenius-ai-config:1.1.0" "${FILE}"
}

@test "does not touch unrelated image: lines for a different package" {
  cat > "${FILE}" <<EOF
foo:
  image: ghcr.io/mogenius/other-service:1.0.0 # renovate
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -ne 0 ]
  grep -q "image: ghcr.io/mogenius/other-service:1.0.0 # renovate" "${FILE}"
}

@test "does not touch unrelated tag: lines for a different depName" {
  cat > "${FILE}" <<EOF
spec:
  source:
    tag: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/other-service
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -ne 0 ]
  grep -q "tag: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/other-service" "${FILE}"
}

@test "dots in the package name are literal, not wildcards" {
  cat > "${FILE}" <<EOF
foo:
  image: ghcrXio/mogeniusXmogenius-aiXconfig:1.0.0 # renovate
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  # A decoy line with the dots/slashes swapped for other single characters
  # must not match, proving PACKAGE_RE escapes regex metacharacters.
  [ "$status" -ne 0 ]
  grep -q "image: ghcrXio/mogeniusXmogenius-aiXconfig:1.0.0 # renovate" "${FILE}"
}

@test "updates both a tag: line and an image: line for different packages in one file" {
  cat > "${FILE}" <<EOF
alpha:
  tag: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/alpha
beta:
  image: ghcr.io/mogenius/mogenius-ai-config:1.0.0 # renovate
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"

  [ "$status" -eq 0 ]
  grep -q "tag: 1.0.0 # datasource=docker depName=ghcr.io/mogenius/alpha" "${FILE}"
  grep -q "image: ghcr.io/mogenius/mogenius-ai-config:1.1.0 # renovate" "${FILE}"
}

@test "is idempotent when run twice with the same version" {
  cat > "${FILE}" <<EOF
foo:
  image: ghcr.io/mogenius/mogenius-ai-config:1.0.0 # renovate
EOF

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"
  [ "$status" -eq 0 ]
  cp "${FILE}" "${WORKDIR}/after-first.yaml"

  run_script "1.1.0" "ghcr.io/mogenius/mogenius-ai-config"
  [ "$status" -eq 0 ]

  diff "${WORKDIR}/after-first.yaml" "${FILE}"
}
