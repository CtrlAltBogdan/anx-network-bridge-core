# Architecture

```
anx-network-bridge-core (own repository, tagged)      a platform repository
  run.anx.bridge.Agent       ─ vendored at a tag ─▶   core/   (checked against core.lock)
  Config, Json, Telemetry,                             src/    VelocityBridge (the Velocity adapter)
  Bedrock, Commands, Platform
```

* **Core** contains everything that does not depend on the platform: the HTTP client (JDK `HttpClient`, one daemon thread),
  the queue and back-off, pairing, telemetry, rewards, the YAML subset parser and the JSON code. It has no dependencies.
* **The adapter** implements `Platform`: counts players and backend servers, runs console commands, adds proof codes to the
  ping answer and registers the `anx` command.
* Each platform repository builds on its own: `core/` is a copy of an exact Core tag, so a source archive of any release
  builds without network access to other repositories. `core.lock` records the tag, its commit and a SHA-256 of the tree;
  the build and CI fail if they do not match. Updating Core is an explicit commit (`scripts/update-core.sh <tag>`).
* The server-side API is owned by anx.run (https://api.anx.run/docs, tag "Agents"); this plugin is a client of it.
