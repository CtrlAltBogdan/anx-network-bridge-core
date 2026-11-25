# Contributing

* `./gradlew clean build` compiles with `-Xlint:all -Werror` and runs the self-test (`CoreSelfTest`, no network needed).
* Keep the core free of dependencies and of platform APIs; platform code lives in the platform repositories.
* `Agent.VERSION` must equal `version` in `gradle.properties` (checked by `checkVersion`).
* A change reaches the plugins only when they vendor a new tag (`scripts/update-core.sh <tag>` in each plugin repository).
