
# Minecraft保存データバックアップバッチ

Windows用 java版Minecraftの保存データ退避用のバッチ機能です。毎晩、Windowsタスクマネージャーで稼働させてください。変更が無ければ処理はされません。

変更があれば、savesフォルダ丸ごとバックアップします。マイクラの保存フォルダの親フォルダ、世代の設定はsetting.iniに記入してください。

MITライセンスとなります。


**現在のバグ:**
- 保存先がs
saves_1/saves/
saves_2/saves/
のようになってしまいます。

**改善したい点:**
- 変更が発生したディレクトリのみをコピーしたいですが、現在は変更が発生するたびに親ディレクトリ全体が世代バックアップされてしまいます
- 出力するログが適当です
