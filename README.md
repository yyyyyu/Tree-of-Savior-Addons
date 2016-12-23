# Tree of Savior Addons

## Keep Head Message

`!!メッセージ` でキャラの頭上に表示される文字をマップ移動時やチャンネル変更時、クライアント再起動時に消えないようにするアドオン。

- チャットコマンド
	- /khm off アドオンを動作しないように設定
	- /khm on  上のコマンドで行った設定を戻す
	- /khm lazysaveon  メッセージの保存をチャット入力時ではなくマップ移動時・チャンネル変更時に実行
	- /khm lazysaveoff メッセージの保存を `!!メッセージ` 入力毎に実行
	- ※ /khm は /keepheadcommand でもOK(長い)

インストールは手動でよろ。

- ダウンロード
	- [_keepheadmessage-☕-v1.0.0.ipf](https://github.com/yyyyyu/Tree-of-Savior-Addons/blob/master/KeepHeadMessage/_keepheadmessage-%E2%98%95-v1.0.0.ipf)
		初回リリース
	- [_keepheadmessage-☕-v1.1.0.ipf](https://github.com/yyyyyu/Tree-of-Savior-Addons/blob/master/KeepHeadMessage/_keepheadmessage-%E2%98%95-v1.0.0.ipf)
		キャラクター毎にメッセージを保持するよう修正


## Unbuff

2chスレにあった[Unsummon](http://mint.2ch.net/test/read.cgi/ogame2/1477572608/798)を参考にして、レビテーションなどのスキルでも利用できるようにしたもの。
Unsummonと競合して動かないかも。未検証。

- 召喚中にサモニング再利用で解除
- レビテーション中にレビテーション再利用で解除
- チャットコマンドでも解除
	- サモニング解除
		- /unbuff summoning
		- /unbuff su
		- /unbuff s
	- レビテーション解除
		- /unbuff levitation
		- /unbuff le
		- /unbuff l
- 他にも同様のスキルがあれば http://twitter.com/y__y__u に以下を教えてください。
	- /unbuff traceon コマンド実行後にバフのある状態で該当スキルを使ってバフを付け、
		バフついた状態で同じスキルを実行(CD中でOK)すると。
		必要な情報(バフIDなど)がチャット欄に出力されるのでそれをください。
	- /unbuff traceoff を実行すれば上記の出力は止まります。

インストールは手動でよろ。
ダウンロード => [_unbuff-☕-v1.0.0.ipf](https://github.com/yyyyyu/Tree-of-Savior-Addons/blob/master/unbuff/_unbuff-%E2%98%95-v1.0.0.ipf)
