# 依存とコマンド管理

Godotの `project.godot` はエンジン設定であり、npmのpackage.jsonのような依存解決・scriptsの統合ファイルではない。公式のAsset Libraryはアドオンの取得手段。導入したゲーム用コードは通常 `game/addons/` に配置する。

| 目的 | このプロジェクトの管理場所 |
|---|---|
| Godotの版 | `.godot-version` |
| Pythonの系列 | `.python-version`（3.12） |
| 開発用パッケージ宣言 | `pyproject.toml` |
| 解決済み依存の版・配布ハッシュ | `uv.lock` |
| 開発コマンド | `Makefile`、実処理は `scripts/` |
| ゲームのアドオン | `game/addons/`＋本書の台帳（現在なし） |

`make tools` / `uv sync --locked` でロックファイルに合わせて導入する。更新は明示的にpyprojectを変更して `uv lock`、`uv sync --locked`、`make check` を実行し、宣言とロックファイルを同じ変更に含める。Pythonとgdtoolkitは開発専用で、スマホアプリの依存にはしない。

## 開発ツール

- gdtoolkit 4.5.0（MIT）: https://github.com/Scony/godot-gdscript-toolkit
- `gdlint`: 命名・複雑さなどの静的チェック。標準ルールを採用。
- `gdformat`: 標準整形（タブ・行幅100）。`--check` は書き換えず差分を検出。
- Godot自身のパース・実行検証は引き続き必須。gdtoolkitだけでGodotの型やAPIの正しさは保証できない。

uvはPython製の開発ツールだけを管理する。ゲーム依存に独自パッケージマネージャーを導入せず、Godotで一般的なaddons配置とGit管理を採用する。Makefileは任意のコマンド短縮であり、Godotの起動に必須ではない。

## ゲーム用アドオンの管理方針

現在は外部アドオンなし。導入時は固定リリースまたはコミットの必要ファイルを `game/addons/` に格納し、ライセンスを保持してGitで管理する。本書に名前、版/commit、取得URL、ライセンス、対象OS、導入理由、更新手順を記録する。浮動最新版をビルド時に取得しない。ローカルDBの連携アドオンもこの方針に従う。

参考:
- https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html
- https://docs.astral.sh/uv/concepts/projects/sync/
