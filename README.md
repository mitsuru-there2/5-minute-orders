# 5分戦記 / 5 MINUTE ORDERS

操作は軽い。判断は重い。5分で命令を出し、相手の5分を読む。

スマホ向けのテキスト・マップ中心の同時ターン戦略ゲーム。現在は開発基盤のみ。ゲーム本体は次のマイルストーンで実装する。

初期版は端末内で完結するローカルゲームとし、DBもローカルDBのみを使用する。外部サーバーやネットワーク接続はプレイに不要。将来のオンラインマルチプレイに備えて保存・通信とゲームルールを分離する。ローカルDBの方式選定と実装は今後行う。

## 開始

```sh
make setup  # macOS / Linux: 固定版Godot＋開発ツールを導入
make check  # format確認・lint・インポート・テスト・起動確認
./scripts/godot.sh --editor --path game
./scripts/godot.sh --path game
```

事前に[uv](https://docs.astral.sh/uv/getting-started/installation/)とmakeを導入する。`make format`で整形、`make lint`で静的チェック。Pythonの開発依存は`pyproject.toml`と`uv.lock`で管理し、ゲーム本体には同梱しない。

Windowsは公式アーカイブから4.6.3 Standardを導入し `game/project.godot` を開く。開発ツールは`uv sync --locked`で導入できる。makeがない場合のコマンド実行はGit Bashで `GODOT_BIN` に実行ファイルのパスを設定する。

## 構成

| パス | 役割 |
|---|---|
| `game/` | Godotプロジェクト。ここをエディターで開く |
| `game/src/domain/` | 画面・I/Oに依存しないゲームルール |
| `game/src/application/` | ユースケース・ターン進行の調整 |
| `game/src/infrastructure/` | 保存・将来の通信アダプター |
| `game/scenes/` | 画面と表示用スクリプト |
| `game/tests/` | ヘッドレステスト |
| `docs/CONCEPT.md` | ユーザー提供の原案をそのまま保存 |
| `docs/specs/` | 実装仕様とプロトタイプ計画 |
| `docs/decisions/` | 技術選定とその理由 |
| `scripts/` | 再現可能な環境構築・検証 |

## 開発資料

- [開発環境](docs/DEVELOPMENT.md)
- [依存とコマンド管理](docs/DEPENDENCIES.md)
- [現状とロードマップ](docs/ROADMAP.md)
- [販促戦略（SNS・SEO・X運用）](docs/MARKETING.md)
- [技術選定](docs/decisions/0001-stack.md)
- [基盤SPEC](docs/specs/000-foundation.md)
- [プロトタイプSPEC](docs/specs/001-prototype.md)
- [素材管理](game/assets/README.md)

コード変更時は関連SPECを更新し、`make check` を通す。当面はmainのみで開発し、PRを作らず直接コミット・pushする。外部公開ライセンスは未選定。ストア配布はまだ行わない。

リポジトリ: https://github.com/mitsuru-there2/5-minute-orders
