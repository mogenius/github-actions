# mogenius/github-actions

Reusable GitHub Actions workflows for the mogenius platform.

Always pin calls to a full commit SHA to guarantee reproducibility:

```yaml
uses: mogenius/github-actions/.github/workflows/<workflow>.yml@<sha> # main
```

---

## Workflows

### `semantic-release.yml` — Prepare Version

Runs [semantic-release](https://semantic-release.gitbook.io/) to determine the next version and outputs build metadata for downstream jobs. Supports GitHub App auth or a PAT.

#### Secrets

| Name | Description |
|------|-------------|
| `APP_ID` | GitHub App client ID (use with `APP_PRIVATE_KEY`) |
| `APP_PRIVATE_KEY` | GitHub App private key |
| `RELEASE_TOKEN` | PAT alternative to App auth |

Either `RELEASE_TOKEN` or both App secrets must be set.

#### Inputs

| Name | Default | Description |
|------|---------|-------------|
| `version_override` | `''` | Pin an explicit version, bypassing semantic-release |
| `default_version` | `'dev'` | Fallback version when no release is created |
| `dry_run` | `false` | Run semantic-release without creating a tag or release |
| `ref` | `''` | Git ref to checkout (defaults to the triggering ref) |
| `runner` | `'self-hosted'` | Runner label for the prepare job |

#### Outputs

| Name | Description |
|------|-------------|
| `version` | Resolved version (`version_override` > semver > `default_version`) |
| `semver` | Semver string without `v` prefix; empty if no release was created |
| `is_release` | `'true'` when semantic-release published a new release |
| `commit_hash` | Short commit hash |
| `git_branch` | Branch name |
| `build_timestamp` | ISO 8601 build timestamp |

#### Example

```yaml
prepare:
  uses: mogenius/github-actions/.github/workflows/semantic-release.yml@<sha> # main
  secrets:
    APP_ID: ${{ secrets.RELEASE_APP_ID }}
    APP_PRIVATE_KEY: ${{ secrets.RELEASE_APP_SECRET }}
  with:
    default_version: 'dev'
```

---

### `build-multiarch.yml` — Build Multi-Arch Container

Builds a Docker image natively on amd64 and arm64 runners, cross-compiles armv7 on amd64 via QEMU, then assembles a combined multi-arch manifest.

`COMMIT_HASH`, `GIT_BRANCH`, `BUILD_TIMESTAMP`, and `VERSION` are always injected as build args. Use `build_args` for args shared across all architectures and the per-arch variants for anything that differs (e.g. arch-specific base images).

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `version` | yes | — | Image version tag |
| `image` | yes | — | Full image path without tag (e.g. `ghcr.io/myorg/myimage`) |
| `registry` | no | `ghcr.io` | Container registry hostname for `docker login` |
| `dockerfile` | no | `./Dockerfile` | Path to Dockerfile |
| `context` | no | `.` | Docker build context path |
| `architectures` | no | `amd64,arm64,armv7` | Comma-separated architectures to build |
| `build_args` | no | `''` | Build args injected into every arch build |
| `build_args_amd64` | no | `''` | Extra build args for the amd64 job only |
| `build_args_arm64` | no | `''` | Extra build args for the arm64 job only |
| `build_args_armv7` | no | `''` | Extra build args for the armv7 job only |
| `build_secrets` | no | `''` | Docker build secrets as literal `id=value` pairs — values cannot be secret references |
| `build_secret_envs` | no | `''` | Mount env vars as docker build secrets (multiline `id=envname`). Use this for secrets — `GITHUB_TOKEN` is always available, others require `secrets: inherit` |
| `push_latest` | no | `true` | Push a `:latest` tag alongside the version tag |
| `runner_amd64` | no | `arc-runner-set-amd64` | Runner label for amd64 native builds |
| `runner_arm64` | no | `arc-runner-set-arm64` | Runner label for arm64 native builds |
| `runner_armv7` | no | `self-hosted` | Runner label for armv7 builds |

#### Outputs

| Name | Description |
|------|-------------|
| `digest_amd64` | Image digest for amd64 |
| `digest_arm64` | Image digest for arm64 |
| `digest_armv7` | Image digest for armv7 |

#### Example

```yaml
build:
  needs: [prepare]
  uses: mogenius/github-actions/.github/workflows/build-multiarch.yml@<sha> # main
  secrets: inherit
  with:
    version: ${{ needs.prepare.outputs.version }}
    image: ghcr.io/myorg/myimage
    build_args: |
      DEV_BUILD=yes
    build_args_amd64: |
      BASE_IMAGE=ghcr.io/myorg/base:latest-amd64
    build_args_arm64: |
      BASE_IMAGE=ghcr.io/myorg/base:latest-arm64
    build_args_armv7: |
      BASE_IMAGE=ghcr.io/myorg/base:latest-armv7
    build_secret_envs: |
      GITHUB_NPM_TOKEN=GITHUB_TOKEN
      MY_SECRET=MY_SECRET
```

---

### `gitops-deploy.yml` — GitOps Deploy

Updates an image tag in a GitOps repository (e.g. an ArgoCD application YAML) and commits the change. Matches the tag line using a [Renovate](https://docs.renovatebot.com/) `datasource=docker depName=` annotation comment. Supports GitHub App auth or a PAT.

#### Secrets

| Name | Description |
|------|-------------|
| `APP_ID` | GitHub App client ID (use with `APP_PRIVATE_KEY`) |
| `APP_PRIVATE_KEY` | GitHub App private key |
| `RELEASE_TOKEN` | PAT alternative to App auth |

Either `RELEASE_TOKEN` or both App secrets must be set. The app or PAT must have write access to the gitops repository.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `version` | yes | — | Version tag to deploy |
| `repository` | yes | — | GitOps repository to update (e.g. `org/repo`) |
| `file` | yes | — | Path to the application YAML file within the repository |
| `package` | yes | — | Full image name matching the `depName=` annotation (e.g. `ghcr.io/myorg/myimage`) |
| `ref` | no | `'main'` | Branch to checkout and push to |
| `runner` | no | `'self-hosted'` | Runner label for the deploy job |

#### Example

```yaml
deploy:
  if: needs.prepare.outputs.is_release == 'true'
  needs: [prepare, build]
  uses: mogenius/github-actions/.github/workflows/gitops-deploy.yml@<sha> # main
  secrets:
    APP_ID: ${{ secrets.GITOPS_APP_ID }}
    APP_PRIVATE_KEY: ${{ secrets.GITOPS_APP_PRIVATE_KEY }}
  with:
    version: ${{ needs.prepare.outputs.version }}
    repository: myorg/my-argocd-applications
    file: dev/my-service/application.yaml
    package: ghcr.io/myorg/my-service
```

---

### `go-build.yml` — Go Build

Compiles all packages in a Go module with `go build ./...`.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | no | `'.'` | Working directory (path to module root) |
| `go_version` | no | `'stable'` | Go version to use |
| `output` | no | `''` | Output binary path passed to `-o` (omit to skip) |
| `ldflags` | no | `''` | Linker flags passed to `-ldflags` |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
build:
  uses: mogenius/github-actions/.github/workflows/go-build.yml@<sha> # main
  with:
    go_version: '1.24.x'
    ldflags: '-X main.version=${{ needs.prepare.outputs.version }}'
```

---

### `go-test.yml` — Go Test

Runs `go test ./...` with optional race detector and test filtering.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | no | `'.'` | Working directory (path to module root) |
| `go_version` | no | `'stable'` | Go version to use |
| `race` | no | `false` | Enable race detector (`-race`) |
| `run` | no | `''` | Test filter passed to `-run` |
| `args` | no | `''` | Extra arguments passed to `go test` |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
test:
  uses: mogenius/github-actions/.github/workflows/go-test.yml@<sha> # main
  with:
    go_version: '1.24.x'
    race: true
```

---

### `golangci-lint.yml` — golangci-lint

Runs [golangci-lint](https://golangci-lint.run/) via the official action. Respects a `.golangci.yml` config in the repository if present.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | no | `'.'` | Working directory (path to module root) |
| `go_version` | no | `'stable'` | Go version to use |
| `golangci_lint_version` | no | `'v1.64.8'` | golangci-lint version (Renovate-tracked) |
| `args` | no | `''` | Extra arguments passed to `golangci-lint run` |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
lint:
  uses: mogenius/github-actions/.github/workflows/golangci-lint.yml@<sha> # main
  with:
    go_version: '1.24.x'
    args: '--timeout 5m'
```

---

### `helm-lint.yml` — Helm Lint

Runs `helm lint` against a chart directory.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | yes | — | Path to the Helm chart directory |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
lint:
  uses: mogenius/github-actions/.github/workflows/helm-lint.yml@<sha> # main
  with:
    path: ./charts/my-service
```

---

### `helm-template.yml` — Helm Template

Renders a chart with `helm template` to validate manifests without a cluster. Supports inline values and `--set` overrides.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | yes | — | Path to the Helm chart directory |
| `values` | no | `''` | Inline values YAML passed via `-f` (written to a temp file) |
| `set` | no | `''` | Additional `--set` overrides, one `key=value` per line |
| `release_name` | no | `'release'` | Helm release name used during templating |
| `namespace` | no | `'default'` | Kubernetes namespace used during templating |
| `update_dependencies` | no | `false` | Run `helm dependency update` before templating |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
template:
  uses: mogenius/github-actions/.github/workflows/helm-template.yml@<sha> # main
  with:
    path: ./charts/my-service
    values: |
      replicaCount: 2
      image:
        tag: latest
    set: |
      ingress.enabled=true
```

---

### `helm-unittest.yml` — Helm Unit Tests

Runs [helm-unittest](https://github.com/helm-unittest/helm-unittest) against a chart directory.

#### Inputs

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| `path` | yes | — | Path to the Helm chart directory |
| `test_files` | no | `'unittests/**/*.yaml'` | Glob pattern for test files relative to the chart directory |
| `strict` | no | `true` | Run helm-unittest with `--strict` flag |
| `helm_unittest_version` | no | `'v1.1.0'` | Version of the helm-unittest plugin to install |
| `update_dependencies` | no | `false` | Run `helm dependency update` before running tests |
| `runner` | no | `'self-hosted'` | Runner label |

#### Example

```yaml
unittest:
  uses: mogenius/github-actions/.github/workflows/helm-unittest.yml@<sha> # main
  with:
    path: ./charts/my-service
    test_files: 'tests/**/*.yaml'
```
