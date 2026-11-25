# ANX Network Bridge Core

English · [Русский](README_RU.md)

The platform-independent part of ANX Network Bridge, the official [anx.run](https://anx.run) agent for Minecraft networks:
the HTTP client, the offline queue, pairing, telemetry, vote rewards and diagnostics. It has no dependencies.

This repository does not produce a plugin. The plugins are:

- [anx-network-bridge-velocity](https://github.com/CtrlAltBogdan/anx-network-bridge-velocity)
- [anx-network-bridge-bungee](https://github.com/CtrlAltBogdan/anx-network-bridge-bungee) (BungeeCord and Waterfall)
- [anx-network-bridge-paper](https://github.com/CtrlAltBogdan/anx-network-bridge-paper)

## How the plugins use it

Each plugin repository contains a copy of this source in `core/` at an exact tag, recorded in `core.lock` with the tag's
commit and a SHA-256 of the source tree (`scripts/core-tree-hash.sh`). The plugin build fails if `core/` differs from the
lock, and CI checks the lock against this repository. A plugin picks up a new core only through an explicit commit
(`scripts/update-core.sh <tag>`), so a core change can never alter an existing plugin release.

## Contents

| Class | Role |
|---|---|
| `Agent` | Scheduling, HTTP, queue, back-off, pairing, rewards, status |
| `Telemetry` | Builds the telemetry body from platform counts (aggregates only) |
| `Config` | `config.yml` reader for the YAML subset the plugins use |
| `Json` | Minimal JSON writer and parser |
| `Bedrock` | Floodgate lookup through reflection |
| `Commands` | `anx status` and `anx pair <code>` |
| `Platform` | Interface implemented by each platform adapter |

The API it talks to is documented at https://api.anx.run/docs (tag "Agents").

## Data handling

Telemetry contains aggregate player counts, mode availability and permitted backend server names. Player names,
UUIDs, IP addresses and chat are not included in telemetry. Vote rewards use a separate API flow: the plugin receives
the voted player's nickname so it can execute the commands configured by the server owner.

Pairing credentials stay on the Minecraft host in `agent.key`; do not add that file to a repository or attach it to a
bug report. The core uses the Java standard library rather than bundling an HTTP or JSON framework into each plugin.

## Build and test

```sh
./gradlew clean build
```

Java 21; the wrapper pins Gradle 9.9.2 and checks its SHA-256. `build` compiles with `-Xlint:all -Werror` and runs the
self-test: JSON, configuration, telemetry body without player ids, queue limits, and a full agent run against a local API
stand-in (pairing, telemetry, proof codes, a reward with a lost acknowledgement, an outage with ordered resend, a revoked key).

## Releases

A tag `vX.Y.Z` equal to `version` in `gradle.properties` builds, tests and publishes a GitHub Release with the jar (for
inspection; plugins vendor the source) and its SHA-256. See [CHANGELOG.md](CHANGELOG.md).

## License

MIT, see [LICENSE](LICENSE).
