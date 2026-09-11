# Project instructions

## Product and scope

Latest acceptance (2026-09-11): `docs/specs/010-remaining-decisions.md` adopts R01–R16
as provisional rules and R17–R21 as initial tuning values and methods. R22–R24 retain
their later-stage final decisions. It overrides older proposal/pending labels below
and in SPECs 002–009 on the same subjects; unrelated accepted rules remain intact.
Do not re-ask accepted choices individually. Complete missing formulas, numeric tables,
and map layouts with worked examples before implementing the affected rules. Tune through
playtesting and record rule versions and evidence; ask about changes to core gameplay.
Gameplay remains unimplemented and playtesting has not yet occurred.

5分戦記 / 5 MINUTE ORDERS is a mobile-first, text-and-map strategy game about
predicting an opponent's intentions and issuing simultaneous orders under
incomplete information.

- Keep order entry manageable within five minutes, even as a nation grows.
  Five minutes is a design constraint, not a mandatory prototype countdown.
- Favor meaningful choices over micromanagement, and rule-changing abilities
  over additional numerical bonuses.
- The first release has exactly four player slots, four factions, a fixed 8x8
  orthogonal square grid, and plains/forest/mountain/water terrain effects.
  Each faction appears once: one human-selected faction and three remaining AI factions.
  Water gameplay focuses on river crossings; no navy or naval combat in the first release.
  Losing a capital eliminates that nation only, not automatically ending the match.
  Remove eliminated nations' commanders and armies, neutralize their remaining land,
  and preserve land already occupied by surviving nations. One survivor wins;
  simultaneous elimination of all remaining nations is a draw. See SPEC 003 for ordering.
  The match allows 30 order turns; resolve the last orders' combat before adjudication,
  without a 31st input phase. Capital elimination and one/zero-survivor results take
  priority. Otherwise the surviving nation with the highest sum of owned territory
  development levels wins; a tie for highest is a draw. Apply final occupation level
  reductions before scoring. Eliminated humans see defeat and may choose AI spectating.
  Spectator visibility and controls remain proposals, as do detailed faction/terrain rules.
  Start with one commander; cap the roster at five, except one of the four factions
  may have six. Recruiting above the cap requires dismissing an existing commander.
  Keep armies, movement, combat, defense, fog of war,
  and local AI. Two-nation maps may remain as focused rule-test fixtures.
- Each nation has a leader who remains in its immutable capital and has per-turn actions.
  No relocation or capital changes. The leader is separate from the five/six commander
  slots; start with one leader plus one commander. Faction ability assignments and
  detailed leader rules remain proposals in SPEC 006. Leaders have popularity and science;
  taxation lowers popularity, public support actions raise it, and research raises science.
  Choose exactly one of taxation, research, or public support per turn. Commanders
  handle capital development. Popularity modifies normal fund income only. Science
  levels 0–3 add 20% material production and 10% attack/defense per level, reaching
  +60%/+30% at level 3 without repeated compounding. Research grants one point per
  action; cumulative thresholds are 2/5/9. Popularity is 0–100, starts at 50, taxation
  costs 15 popularity (requires at least 15), and public support adds 20 capped at 100.
  Normal fund-income modifiers are -10%/0%/+10%/+20% at popularity 0–24/25–49/50–74/75–100.
  Research/public support cost only the leader action. Science attack/defense modifiers
  apply to both armies and garrisons. Stacking with other effects remains a proposal.
  See SPEC 006.
- Defeating neutral armies recruits the commander only, without accompanying troops.
  Neutral armies remain on their initial tiles, defend without roaming or invading,
  and never respawn. Their number, locations, and strength remain undecided.
  Recruited neutral commanders join without soldiers on the defeated army's tile,
  not at the capital. Commanders with no combat-ready
  soldiers may move, develop, recruit, and occupy territory without enemy armies,
  including capitals. Encounter and retreat outcomes remain undecided. Normal ownership
  requirements for development/recruitment still apply; hidden enemies cannot affect validation.
  Rare recruitment events are rolled randomly
  each turn, without achievement-based triggers. Do not guarantee fixed-turn recruitment.
  Preserve seeded determinism. Probabilities, dismissal consequences, faction assignment,
  neutral-army rules, and commander abilities remain proposals in SPEC 004.
- Garrisons can be recruited directly in owned territories even without a commander.
  Purchases finalize immediately and new units can be used in the same turn.
  Purchases and replacements do not consume commander actions. Garrisons contain
  infantry only, with capacity 2/3/4 at territory levels 1/2/3. Land starts at level 1.
  Capitals start with no garrison; this does not determine the starting commander's army.
  Commanders level up and their unit capacity grows to at most ten units per commander.
  Max level is five; capacities at levels 1–5 are 5/6/7/8/10. Combat and development
  can support progression; exact experience rules remain proposals in SPEC 004.
  Each commander has one ability fixed when the candidate appears and shown before
  recruitment is accepted; players cannot choose or reroll it. Leveling never adds abilities.
  Units have individual names and variable parameters. Each turn presents randomized
  recruit candidates for purchase or replacement. Terrain and development affect
  candidate counts: at levels 1/2/3, plains have 3/4/5, forests 2/3/4, mountains 0–1/1/2
  (50% chance of one at mountain level 1), and water has zero. Capitals guarantee at least
  two candidates; every nonempty candidate list includes at least one infantry soldier.
  Candidate pricing remains a proposal in SPEC 008. Replaced soldiers are dismissed
  without a reserve slot or refund. At zero HP soldiers leave with injuries and return
  after resting for two turns, rejoining their original army or garrison. Injured
  soldiers still occupy command slots and may be dismissed to recruit replacements.
  Commander rest is restricted to owned territory without movement. Garrisons heal
  automatically by 20% max HP each turn even if they fought. Rest fully heals surviving
  army units. Otherwise armies naturally heal 20% max HP only when on owned territory
  after turn-end movement; pending enemy/neutral territory occupation does not qualify.
  Wind faction armies are an exception: they also heal 20% on enemy/neutral land,
  without double healing on owned land. Only a commander with precise scouting
  can reveal the forest faction's concealed troop counts; ordinary scouting cannot.
  Armies that fought at turn opening may rest afterward on owned land. Completed
  healing is not canceled by the next battle. Injury in T means absence in T+1 and
  T+2, returning at full HP before T+3 combat. See SPEC 009.
  Injured soldiers whose original formation disappears do not return. Rest and automatic
  garrison healing cost no funds. Rounding and precise healing timing remain undecided.
  Rank-based unit comparisons (C/B/A/S/SS) and roughly 100% individual variation
  are requested; interpreting this as a 1x–2x same-type stat range, rank thresholds,
  and generation probabilities remain proposals in SPEC 008.
  Unit types, recruitment costs, purchase-phase
  restrictions, and detailed recovery rules remain proposals in SPEC 007.
- Commanders can issue a territory-development order. Territories develop by up to
  three stages. Terrain/development effects have three axes: funds, resources, and defense
  modifiers. Funds pay for troops; resources aggregate materials and pay for development.
  Use one development level per territory and the accepted terrain profiles in SPEC 005.
  Land starts at level 1 and develops to maximum level 3. Normal development adds one
  level, terrain specialists up to two, paying the full material cost of levels gained.
  Occupation lowers development by one to a minimum of level 1; no level-0 ruin state.
  Exact costs and ability assignments remain proposals.
  Do not collapse funds and resources into one currency.
- The first release must run entirely on the device. Use an embedded local DB
  for persistence, with no external server, separate DB process, cloud DB,
  account, or network connection required to play or resume a game.
- Do not use postgres MCP in this project.
- Turn timing: finish turn T work and recruitment before combat at the start of T+1.
  Movement occurs at the end of T; there is no new input between movement and combat.
  Opposing armies crossing the same edge pass through without fighting en route.
  Multiple friendly armies may share a tile and cooperate in combat while retaining
  separate commanders, orders, and unit caps.
  Defeated armies retreat to an eligible adjacent owned tile. If none exists, only
  the commander returns to the capital after wandering for two turns, without troops.
  Wandering commanders occupy roster slots and may be dismissed, canceling their return.
  Wandering in T means return before T+3 combat with level, experience, and ability intact.
  Retreat automatically selects an eligible adjacent owned tile closest to the capital;
  eligible tiles must remain owned and free of enemy armies after all battles.
  Retreat does not trigger another battle. Terrain and capital locations are public;
  territory ownership updates only within vision. Ordinary enemy observation shows
  commander presence and approximate troop counts; scouting reveals detailed composition
  and abilities. Commanders, garrisons, and capitals reveal their tile and orthogonal
  neighbors. All owned tiles are always visible, without automatically revealing their
  neighbors. Commanders/garrisons on mountains see Manhattan radius 2. Enemy troop
  counts use qualitative size labels; thresholds remain undecided. Scouting targets
  one tile within Manhattan distance 3 and reveals detailed composition and abilities.
  Ownership loss must not remain displayed as current ownership; enemy details in
  loss logs and scouting observation timing remain undecided.
  distance metric and ties remain proposals in SPEC 004. Elimination cancels any return.
  Combat uses no randomness; recruitment
  candidates and events still use deterministic seeded randomness.
  Completed development, rest, and leader work are not rolled back by that combat.
  Development materials are fully spent; rejected invalid orders do not spend them.
  Terrain specialists may develop one step if only one step is affordable; show
  the resulting level and cost before confirmation. Rivers are tile edges;
  sea/lake tiles cannot be entered, occupied, or developed.
  River faction crossing applies to retreats as well as advances. Bridges and ordinary
  crossings are fixed at map generation, without in-match construction or destruction.
  Remaining timing details and income boundaries are proposals in SPEC 009. Gameplay is not implemented.
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
