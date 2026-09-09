# SPEC 000: 開発基盤

状態: 実装済み。ゲームルール本体は未実装。

- Godot 4.6.3 Standard / 型付きGDScript / Compatibility renderer。
- Godotルートは `game/`。基準解像度390×844、縦持ち、canvas_itemsで拡縮。
- 起動シーンは開発用の英語テキストのみ。日本語フォント・セーフエリア・ゲーム操作は次段階。
- domainはRefCountedベース。applicationは進行を調整し、infrastructureは初期版のローカルDB保存と、将来の通信アダプターの配置先とする。現時点で保存・通信は未実装。
- 依存方向: UI → application → domain。infrastructureはdomainに依存し、domainは外側を参照しない。
- TurnPhaseは ORDERS → LOCKED → MOVEMENT → COMBAT → EVENTS → RESULTS → ORDERS の語彙と遷移のみ。READY判定、時間切れ、移動・戦闘解決そのものは実装していない。
- GDScriptはgdtoolkit 4.5.0のgdformat標準設定（タブ・行幅100）で整形し、gdlint標準ルールで検査する。対象は自作のsrc・scenes・tests。第三者addonsは自動整形しない。
- 開発依存はpyproject.tomlとuv.lock、Python系列は.python-version（3.12）で管理する。makeにsetup・tools・editor・run・format・lint・checkを集約する。
- checkはformat差分とlint違反を先に検査し、違反時は失敗する。CIは同じロックファイルとcheckを使用する。
- テストはSceneTreeスクリプトをheadless実行し、失敗は終了コード1。チェックはインポート・フェーズ契約・3フレームの起動を確認し、Godotのエラーログも失敗扱いとする。
- `.godot-version` を唯一の版指定とする。setupは公式配布のSHA512照合後に `.tools/` に展開する。システム環境を変更しない。
- 当面はmainのみで開発し、PRを作らず直接コミット・pushする。GitHub Actionsはmainへのpushを契機にLinuxで同じsetup/checkを実行する。署名・配布は行わない。

受入条件: クリーン環境からsetup/checkが成功し、エディターでmainシーンを実行できる。
