# ADR 0001: 技術構成

日付: 2026-09-09 / 状態: 初期採用

| 項目 | 選定 | 理由 |
|---|---|---|
| エンジン | Godot 4.6.3 Standard固定 | 原案のGodot 4指定に合致。確認できた安定版を再現可能に固定 |
| 言語 | 型付きGDScript | エンジン標準、モバイル向けC#の追加制約を避ける |
| 描画 | Compatibility / Control UI | テキストと2D地図中心で3D描画は不要 |
| 対象 | iOS / Android、初期は縦持ち | スマホの短時間入力を優先 |
| ローカル開発 | Godot内蔵エディター＋CLI、Git | 外部エディターやNode等への依存を増やさない |
| テスト | Godot headlessの自前ランナー | 最小依存。複雑になった時点でGUT等を再評価 |
| CI | GitHub Actions / Ubuntu | ローカルと同じ固定版・コマンドを使う |
| 補助ツール | Bash、curl、unzip、Python 3.12、uv、make | 環境構築・依存固定・開発コマンド集約 |
| lint / format | gdtoolkit 4.5.0（gdlint / gdformat） | 開発専用依存としてuv.lockで推移的依存も固定 |
| データ | 端末内のローカルDB（実装方式は選定予定） | 初期版は通信なしで保存・再開できる |
| バックエンド | 初期版は不要 | アプリ内で進行・AI・ターン解決を完結させる |

Godot Resourceを外部から受信して実行する設計は採らず、将来の通信は検証可能なデータ形式にする。再現性は同一rules_versionとエンジン版を前提とし、異なる版での再現は別途検証する。

初期版の「サーバーレス」は外部サーバーを必要としない端末内完結を意味し、クラウドのサーバーレスサービスは使用しない。DBサーバーの別プロセスも不要とする。ローカルDBの製品・Godot連携方式は、iOS / Androidでの動作と保存の整合性を確認して保存機能の実装前に選定する。ローカルDBはまだ未実装。

将来のオンラインマルチプレイを拡張目標とする。初期版ではapplicationがローカルの進行・保存アダプターを利用し、domainとUIにDB操作や通信処理を埋め込まない。将来は命令送信・結果取得の通信アダプターを追加できる境界を保つ。

オンライン化時はサーバーが命令受付・締切・冪等な解決・プレイヤー別結果配信を担当する。スマホのバックグラウンド動作にターン解決を依存させない。このプロジェクトではpostgres MCPを利用しない。

参考（2026-09-09確認）:
- https://godotengine.org/download/archive/4.6.3-stable/
- https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_android.html
- https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_ios.html
