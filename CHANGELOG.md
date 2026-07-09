# [1.7.0](https://github.com/mogenius/github-actions/compare/v1.6.3...v1.7.0) (2026-07-09)


### Features

* use github arm64 runner for arm builds ([53164c0](https://github.com/mogenius/github-actions/commit/53164c06bb4229044bee9906d0d0bdf05bb5e6bf))

## [1.6.3](https://github.com/mogenius/github-actions/compare/v1.6.2...v1.6.3) (2026-07-08)


### Bug Fixes

* adding more logging for automerge action ([e51e799](https://github.com/mogenius/github-actions/commit/e51e799e790dd26564c573c65121d71ab1c05eb0))

## [1.6.2](https://github.com/mogenius/github-actions/compare/v1.6.1...v1.6.2) (2026-07-08)


### Bug Fixes

* install gh cli if it is not installed ([b13f430](https://github.com/mogenius/github-actions/commit/b13f430d5b889a3557dc8b8a0d0a9e671f91f749))

## [1.6.1](https://github.com/mogenius/github-actions/compare/v1.6.0...v1.6.1) (2026-07-06)


### Bug Fixes

* **deps:** update actions/checkout action to v7 ([ae30452](https://github.com/mogenius/github-actions/commit/ae30452e49c70bcd81078d5c0821adb9ad4d89d3))
* **deps:** update actions/setup-go action to v6.5.0 ([f888cad](https://github.com/mogenius/github-actions/commit/f888cad5d0176185c2db04ed26517969d6cc68a2))
* **deps:** update docker/build-push-action action to v7.3.0 ([d3353ee](https://github.com/mogenius/github-actions/commit/d3353eefa520fe561884045749a61f427763f9c5))
* **deps:** update docker/login-action action to v4.4.0 ([32db021](https://github.com/mogenius/github-actions/commit/32db021fc7b4d7a186232de8061e6a298ab3416f))
* **deps:** update docker/setup-buildx-action action to v4.2.0 ([dfba123](https://github.com/mogenius/github-actions/commit/dfba12343888b1b20c8f088294ba007210c31255))
* **deps:** update docker/setup-qemu-action action to v4.2.0 ([8745da2](https://github.com/mogenius/github-actions/commit/8745da27470335a2ff0422292e24e3aed14a724d))
* **deps:** update golangci/golangci-lint-action action to v9.3.0 ([651acfc](https://github.com/mogenius/github-actions/commit/651acfcf3b45ecbe39966b73dd017b9fc2ba4d3d))

# [1.6.0](https://github.com/mogenius/github-actions/compare/v1.5.0...v1.6.0) (2026-06-30)


### Features

* switch sbom to default to true ([bcf29d5](https://github.com/mogenius/github-actions/commit/bcf29d5ace72e4b1d66fcf35a69f5d5f35b976b9))

# [1.5.0](https://github.com/mogenius/github-actions/compare/v1.4.4...v1.5.0) (2026-06-30)


### Features

* adding build inputs for sbom and provenance ([70130fa](https://github.com/mogenius/github-actions/commit/70130fa2b1007142f24c4cb9f9e0a1b9b29acb81))
* enable image signing per default ([a1f465c](https://github.com/mogenius/github-actions/commit/a1f465c7958172976e7a34e05df1dcf81f7c1125))

## [1.4.4](https://github.com/mogenius/github-actions/compare/v1.4.3...v1.4.4) (2026-06-26)


### Bug Fixes

* **deps:** update azure/setup-helm action to v5.0.1 ([#13](https://github.com/mogenius/github-actions/issues/13)) ([2cf4595](https://github.com/mogenius/github-actions/commit/2cf459561526a1ca6d6f02bdf24c66258153aa22))

## [1.4.3](https://github.com/mogenius/github-actions/compare/v1.4.2...v1.4.3) (2026-06-18)


### Bug Fixes

* **deps:** update actions/checkout action to v6.0.3 ([#9](https://github.com/mogenius/github-actions/issues/9)) ([9078036](https://github.com/mogenius/github-actions/commit/90780368bce99f0841bbae4fcb08561bf49a967d))

## [1.4.2](https://github.com/mogenius/github-actions/compare/v1.4.1...v1.4.2) (2026-06-18)


### Bug Fixes

* update sigstore/cosign-installer to v4 ([6638925](https://github.com/mogenius/github-actions/commit/6638925b9ca787165ec0af2d0cdca415c85e43ce))

## [1.4.1](https://github.com/mogenius/github-actions/compare/v1.4.0...v1.4.1) (2026-06-18)


### Bug Fixes

* sign images using its digest ([888602d](https://github.com/mogenius/github-actions/commit/888602dc62120951638fd861f3ada7685659ed94))

# [1.4.0](https://github.com/mogenius/github-actions/compare/v1.3.2...v1.4.0) (2026-06-18)


### Features

* adding image signing as an option for renovate ([389c7e0](https://github.com/mogenius/github-actions/commit/389c7e06d25631f4c8362078829b1eaa713f237f))

## [1.3.2](https://github.com/mogenius/github-actions/compare/v1.3.1...v1.3.2) (2026-06-16)


### Bug Fixes

* set repository for token creation ([4242318](https://github.com/mogenius/github-actions/commit/424231845c685e2f70514dcfa338ad87cbe9c450))

## [1.3.1](https://github.com/mogenius/github-actions/compare/v1.3.0...v1.3.1) (2026-06-16)


### Bug Fixes

* set github npm token for semantic release ([085bf1d](https://github.com/mogenius/github-actions/commit/085bf1d44d2206d1dbdf3181c4f46ac672e81b60))

# [1.3.0](https://github.com/mogenius/github-actions/compare/v1.2.0...v1.3.0) (2026-06-15)


### Features

* adding action to automerged approved merge requests ([9779b0e](https://github.com/mogenius/github-actions/commit/9779b0e434607b652537d87338aea15585f93a84))

# [1.2.0](https://github.com/mogenius/github-actions/compare/v1.1.2...v1.2.0) (2026-06-15)


### Features

* adding predefined go actions ([21ac54d](https://github.com/mogenius/github-actions/commit/21ac54dfcae2e5285608b2cc3bbd878253ba347a))

## [1.1.2](https://github.com/mogenius/github-actions/compare/v1.1.1...v1.1.2) (2026-06-11)


### Bug Fixes

* improve qemu install action ([c4f7989](https://github.com/mogenius/github-actions/commit/c4f7989e52dba7adb4c8419a4dcb48102b037d2e))

## [1.1.1](https://github.com/mogenius/github-actions/compare/v1.1.0...v1.1.1) (2026-06-03)


### Bug Fixes

* adding default container labels to multi arch build ([08ee50a](https://github.com/mogenius/github-actions/commit/08ee50aae4fa93a382adf5689205d3e259c5da13))

# [1.1.0](https://github.com/mogenius/github-actions/compare/v1.0.0...v1.1.0) (2026-06-02)


### Bug Fixes

* improve renovate config ([372b134](https://github.com/mogenius/github-actions/commit/372b1343d975cfeb060050144b46aa97c582f532))


### Features

* adding helm reusable actions ([117e5c4](https://github.com/mogenius/github-actions/commit/117e5c459cce769d2b2be7ee33630f25b2b9b02f))

# 1.0.0 (2026-06-02)


### Bug Fixes

* adding input for armv7 runner defaulting to self hosted ([6bbba2e](https://github.com/mogenius/github-actions/commit/6bbba2ed28de00ac8ffca1aa2c8f38c6b73b7602))
* adding secret envs for container builds ([079d1e7](https://github.com/mogenius/github-actions/commit/079d1e76fe98f17ba03a34c6c6c318fe9291f257))
* explicitly set GITHUB_TOKEN env var so secret-envs can resolve it ([99827d9](https://github.com/mogenius/github-actions/commit/99827d9d6d116491d980bd1452c5698a2aa71fc3))
* improved renovate ([e7bbc72](https://github.com/mogenius/github-actions/commit/e7bbc72b52b9de09d67ea692f39ab5063a175a5b))
* ref name [skip ci] ([a2aab69](https://github.com/mogenius/github-actions/commit/a2aab6984bdb504c651486b1d0e202bf1e312db2))
* roll back to app-id ([8de4f95](https://github.com/mogenius/github-actions/commit/8de4f95f32d358b0be4097a008bf62b6156fde09))
* setting owner for token ([adcf70d](https://github.com/mogenius/github-actions/commit/adcf70d842afd0bac6634028a3280a87e1ec43b3))
* use | as sed delimiter to handle / in image paths ([fc5b299](https://github.com/mogenius/github-actions/commit/fc5b299592331d09e8fd358cba54610a76320c0c))


### Features

* add the possibility to pass secrets to the docker build ([c6f4486](https://github.com/mogenius/github-actions/commit/c6f44860fea8de870f786f65507a5c01c59ed3ff))
* adding multi arch build workflow ([27822e1](https://github.com/mogenius/github-actions/commit/27822e16d951ac5b04a35d4a6d65e1cd18e8e0bf))
* adding reusable workflow for gitops deploy ([18103e8](https://github.com/mogenius/github-actions/commit/18103e87b48bc7522a6ed179847a3f49127807a1))
* addint the option to use github app auth ([dd980fa](https://github.com/mogenius/github-actions/commit/dd980fa240c0c00ce9c7fa3ac40dd565a500a6af))
* make semantic release runner configurable ([af51616](https://github.com/mogenius/github-actions/commit/af516163c475fa351ca5a88c4ae9dea4f09dbd35))
* writing a short readme and adding semantic release action ([d607b8c](https://github.com/mogenius/github-actions/commit/d607b8cbccb215bcdff50820a55f540df939c8b8))
