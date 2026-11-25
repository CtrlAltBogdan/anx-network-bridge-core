# Changelog

The core follows [Semantic Versioning](https://semver.org). Tags `vX.Y.Z` are never moved.

## [1.0.0] - 2026-11-25

First release as a separate repository. Same code as the core of ANX Network Bridge 1.0.0 shipped with anx.run 1.5.0.

### Added
- Agent: pairing, heartbeat, configuration, telemetry, vote rewards with per-vote memory, MOTD proof codes.
- JDK `HttpClient` on one daemon thread; bounded ordered queue (10 measurements, 4 minutes); back-off up to 5 minutes;
  stop on a refused key.
- Dependency-free JSON code and YAML-subset config reader; Floodgate lookup by reflection.
- Self-test with a full agent run against a local stand-in for the anx.run API (30 checks).
