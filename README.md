
# Minecraft保存データバックアップバッチ

Windows用 java版Minecraftの保存データ退避用のバッチ機能です。毎晩、Windowsタスクマネージャーで稼働させてください。変更が無ければ処理はされません。

変更があれば、savesフォルダ丸ごとバックアップします。マイクラの保存フォルダの親フォルダ、世代の設定はsetting.iniに記入してください。

MITライセンスとなります。


バグあり

保存先が
saves_1/saves/
saves_2/saves/
になってしまう。

**現在のバグ:**
- 保存先がs
saves_1/saves/
saves_2/saves/
のようになってしまいます。

**改善したい点:**
- 変更が発生したディレクトリのみをコピーしたいですが、現在は変更が発生するたびに親ディレクトリ全体が世代バックアップされてしまいます


# MITライセンス:

Copyright (c) 2011-2013 Jason Huck, Simon Georget http://opensource.org/licenses/MIT

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.