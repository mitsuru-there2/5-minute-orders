# Project instructions

## Product and scope

5分戦記 / 5 MINUTE ORDERS is a mobile-first, text-and-map strategy game about
predicting an opponent's intentions and issuing simultaneous orders under
incomplete information.

- Keep order entry manageable within five minutes, even as a nation grows.
  Five minutes is a design constraint, not a mandatory prototype countdown.
- Favor meaningful choices over micromanagement, and rule-changing abilities
  over additional numerical bonuses.
- Start with an offline prototype: two nations, a small map, one to three
  commanders, armies, movement, combat, defense, fog of war, and a simple AI.
- The first release must run entirely on the device. Use an embedded local DB
  for persistence, with no external server, separate DB process, cloud DB,
  account, or network connection required to play or resume a game.
- Do not use postgres MCP in this project.
- Online multiplayer is a future goal. Preserve suitable architectural
  boundaries, but do not implement networking, matchmaking, notifications,
  monetization, or server infrastructure as part of the initial prototype.
- Development downloads and CI may use the network; the offline requirement
  applies to the installed game's runtime.

## Read the relevant sources

- `docs/CONCEPT.md`: original user-provided concept. Preserve the source text;
  record refinements in specifications and decisions instead.
- `docs/specs/`: implementation contracts, accepted requirements, and explicitly
  labeled proposals. Update the relevant SPEC whenever code changes.
- `docs/decisions/`: technical decisions and their rationale.
- `docs/ROADMAP.md`: milestones and unresolved product decisions.
- `docs/DEVELOPMENT.md`: setup, platform prerequisites, and development workflow.
- `docs/DEPENDENCIES.md`: dependency policy and third-party code inventory.

Do not present a proposal as an accepted rule or a planned feature as implemented.
The current foundation has a startup scene and a turn-phase contract; gameplay,
AI, persistence, and networking are not implemented yet. The local DB engine and
Godot integration must be selected and validated before persistence is built.
Update these status notes when the implementation advances.

## Architecture

The Godot project root is `game/`, not the repository root.

| Location | Responsibility |
| --- | --- |
| `game/src/domain/` | State, commands, rules, deterministic turn resolution |
| `game/src/application/` | Command submission, validation, progression, use cases |
| `game/src/infrastructure/` | Local DB adapters; future transport adapters |
| `game/scenes/` | Presentation and UI scripts |
| `game/tests/` | Headless contract and behavioral tests |
| `game/assets/` | Art, fonts, audio, and their attribution inventory |

- Dependencies flow from UI to application to domain. Infrastructure implements
  persistence or transport boundaries; domain never depends on those adapters.
- Keep domain logic in plain GDScript objects such as `RefCounted`. Do not depend
  on Nodes, the scene tree, UI, files, DB APIs, networking, or wall-clock time.
- Keep DB queries and transport details out of UI and domain code. Use clear
  application boundaries without building speculative frameworks.
- Resolve simultaneous orders from a fixed snapshot. Identical state, orders,
  seed, and rule version must produce identical results under the supported
  engine version. Avoid global randomness and incidental iteration order.
- Separate authoritative game state from each player's observation. UI and AI
  receive only permitted information; hiding secret state visually is insufficient.
- Validate commands before locking them. Define unresolved interaction rules in
  the SPEC before implementing them, including movement collisions and retreat.
- Persist versioned data rather than scene nodes. Include schema and rule
  versions, turn, seed, state, and committed orders. Make saves atomic so an
  interrupted write cannot expose a partially resolved turn.
- Future multiplayer should be able to move authoritative progression to a
  server without rewriting domain rules. Do not depend on mobile background
  execution to resolve future online turns.

## Godot and coding conventions

- Use the Standard Godot build and typed GDScript. Read the pinned engine version
  from `.godot-version`; do not silently upgrade it or switch to .NET.
- Use the Compatibility renderer and the current portrait layout baseline.
  Consult `game/project.godot` and the foundation SPEC for exact settings.
- Follow `gdformat` and `gdlint` defaults: tabs and a 100-character line limit.
  Prefer explicit types, small functions, and names that express game concepts.
- Keep generated `.uid` and source import sidecars in Git. Do not commit
  `.godot/`, `.tools/`, `.venv/`, build outputs, credentials, or signing keys.
- For mobile UI, verify readable Japanese text, touch targets, safe areas,
  scaling, and interruption/resume behavior when those features are introduced.
- Record asset sources and licenses in `game/assets/README.md`. Preserve license
  files for bundled fonts and other third-party assets.

## Dependencies and commands

Use ordinary Godot `addons/` placement and Git tracking for game dependencies.
Pin third-party releases or commits, preserve licenses, and record platform
support and update instructions in `docs/DEPENDENCIES.md`. Do not introduce a
Node-style dependency system merely to manage this Godot project.

Python tooling is development-only. `pyproject.toml` declares it, `uv.lock` locks
it, and `.python-version` selects the Python series. Use `uv sync --locked` for
normal installation. Update the manifest and lockfile together when changing
packages. Do not format vendored add-ons with the project's style commands.

Run commands from the repository root:

| Command | Purpose |
| --- | --- |
| `make setup` | Install the pinned Godot build and locked development tools |
| `make tools` | Sync development tools only |
| `make editor` | Open the Godot project in the editor |
| `make run` | Run the startup scene/game |
| `make format` | Rewrite project GDScript formatting |
| `make lint` | Run GDScript static checks |
| `make check` | Check formatting, lint, import, tests, and headless startup |

`Makefile` is a convenience wrapper; implementations live in `scripts/`.
`GODOT_BIN` can select an existing executable, whose version is still checked.

## Validation and completion

- For GDScript changes, run `make format`, then `make check`.
- For game rules, add meaningful behavioral tests to the headless test suite:
  cover affected rules and relevant failures, determinism, or information access.
- For UI changes, inspect the rendered screen and relevant interactions.
  Headless startup alone does not verify layout or mobile usability.
- For persistence changes, test offline save/restart/resume and interrupted saves.
- For documentation-only changes, check consistency and `git diff --check`;
  a full engine test run is not required.
- Keep related SPECs and technical decisions synchronized. Report what changed,
  what was verified, and any remaining limitations. Never claim tests or device
  exports passed unless they were actually run successfully.

## Git workflow

- Work directly on `main` for now. Do not create feature branches, worktrees for
  branch-based development, or pull requests for this personal project.
- Use small, descriptive commits and push directly to the configured `origin`.
  CI runs on pushes to `main`.
- Inspect the working tree before editing and preserve unrelated user changes.
  Do not rewrite published history or force-push unless explicitly requested.
