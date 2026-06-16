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
