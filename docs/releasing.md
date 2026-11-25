# Releasing the core

1. Change the code, keep `./gradlew clean build` green (`-Xlint:all -Werror`, self-test).
2. Set the same version in `gradle.properties` and `Agent.VERSION` (SemVer), add a `CHANGELOG.md` section.
3. Push a tag `vX.Y.Z`. The Release workflow verifies the tag, builds, tests and publishes the jar and its SHA-256.
   An existing release is never replaced.
4. In each plugin repository: `scripts/update-core.sh vX.Y.Z`, `./gradlew clean build`, update the plugin version and
   changelog, commit, then release the plugin with its own tag. Plugins that are not updated keep the core they were
   released with.

## Creating the tag on github.com

The tag can also be created from the repository's **Releases → Draft a new release** page: choose a new tag `vX.Y.Z`
on `main`, tick **Set as a pre-release**, leave the files empty and publish. Creating the tag starts the Release workflow.
If the build, tests and checks pass, the workflow attaches the jar and its `.sha256` file, writes the release notes and
clears the pre-release flag. If any check fails, nothing is attached: delete that empty pre-release and its tag, fix the
problem and release again. The workflow never overwrites a file that is already attached to a release.
