# 開発環境

## 標準手順

```sh
./scripts/setup.sh
./scripts/check.sh
./scripts/godot.sh --editor --path game
```

Godot 4.6.3 Standardを公式GitHub Releasesから取得し、SHA512を検証して `.tools/` に展開する。Python 3、curl、unzip、Bashが必要。macOSとLinux x86_64をサポートする。別途導入済みの場合は `GODOT_BIN` に実行ファイルの絶対パスを設定する。

GodotはユーザーのLibrary等に設定・キャッシュを作成するため、制限付き実行環境では通常のユーザー書き込み権限が必要。ダウンロードには外部ネットワーク接続が必要。Godotの設定画面の更新通知による自動アップグレードは行わず、版更新時はSPECと動作を再確認する。

## このMacの確認結果（2026-09-09）

| 項目 | 状態 |
|---|---|
| Godot | 4.6.3を `.tools/Godot.app` に導入、公式SHA512照合済み |
| Xcode | 26.6、Developerディレクトリ設定済み |
| Java | 17.0.10あり |
| Android Studio / SDK | あり。build-tools 36.1.0 / 37.0.0、platform android-36.1 |
| Godot 4.6向けAndroid SDK一式 | 未完了。下記の固定パッケージとの差分あり |
| GitHub CLI | mitsuru-there2で認証確認済み。remote未設定 |
| Export Templates / 署名 / 実機書き出し | 未設定・未検証 |

## Android実機検証の前に

Godot 4.6公式手順に従いAndroid StudioのSDK Managerから次を導入する。既存SDKを削除する必要はない。

- Platform Tools 35.0.0以降
- Build Tools 35.0.1、Platform 35、Command-line Tools
- CMake 3.10.2.4988404、NDK 28.1.13356709

Godot Editor SettingsのJava SDK PathとAndroid SDK Pathを設定する。Editor → Manage Export Templatesでエンジンと一致する4.6.3テンプレートを導入し、Project → ExportにAndroidを追加する。初回はdebug APKを実機へ。アプリIDと署名方針を決めてから共有export presetを作成する。鍵やパスワードはコミットしない。

## iOS実機検証の前に

macOS＋Xcode＋同版Export Templatesを使用する。Project → ExportでiOSを追加し、Apple Team IDとBundle Identifierを指定する。`build/ios/` に空白を含まない名前で書き出し、Xcodeで署名と実機実行を確認する。アカウント固有設定と配布用証明書はリポジトリ外で管理する。

現段階は両OSを対象とする開発基盤であり、ストア配布可能な状態ではない。最低対応OSは実機検証時に確定する。

## Git運用

初期作業ブランチは `codex-initial-setup`。今後も `codex-` 接頭辞の作業ブランチで変更し、関連SPECを同期する。GitHubの所有者・名前・公開範囲が確定後、リモートを作成してpushする。CIが動いたことを確認してから必須チェックとして保護ルールを設定する。

コード・素材の公開ライセンスは未選定。外部依存や素材を追加した時点でライセンス台帳も更新する。

## 公式資料

- [Godot 4.6.3](https://godotengine.org/download/archive/4.6.3-stable/)
- [Android export](https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_android.html)
- [iOS export](https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_ios.html)
