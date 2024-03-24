import 'dart:io';

// バックアップ設定クラス
class BackupSettings {
  late String minecraftDirectory; // マインクラフトディレクトリの親ディレクトリのパス
  late int generations; // 世代数

  // コンストラクタ
  BackupSettings(this.minecraftDirectory, this.generations);

  // 設定ファイルから設定を読み込むファクトリメソッド
  factory BackupSettings.fromConfigFile(String configFile) {
    var config = File(configFile);
    var lines = config.readAsLinesSync();

    var minecraftDirectory = ''; // マインクラフトディレクトリの親の初期値
    var generations = 3; // 世代数の初期値

    // 設定ファイルの各行を解析して設定を取得
    for (var line in lines) {
      var parts = line.split('=');
      if (parts.length == 2) {
        var key = parts[0].trim();
        var value = parts[1].trim();
        if (key == 'minecraftDirectory') {
          minecraftDirectory = value;
        } else if (key == 'generations') {
          generations = int.parse(value);
        }
      }
    }

    return BackupSettings(minecraftDirectory, generations);
  }
}

// ログファイルにメッセージを出力する関数
void logMessage(String message) {
  var logFile = File('backup_log.txt');
  var timestamp = DateTime.now().toString();
  logFile.writeAsStringSync('$timestamp: $message\n', mode: FileMode.append);
}

// バックアップの実行と世代管理
void performBackup(BackupSettings settings) {
  var sourceDirectory = '${settings.minecraftDirectory}/saves';
  logMessage('バックアップ対象のフォルダ: $sourceDirectory');
  if (hasChanges(sourceDirectory)) {
    logMessage('更新が検出されました。バックアップを実行します。');

    for (int i = settings.generations; i > 1; i--) {
      String currentBackup = '${settings.minecraftDirectory}/saves_$i';
      String previousBackup = '${settings.minecraftDirectory}/saves_${i - 1}';
      if (Directory(previousBackup).existsSync()) {
        // 移動先のディレクトリが存在している場合は削除する
        if (Directory(currentBackup).existsSync()) {
          Directory(currentBackup).deleteSync(recursive: true);
        }
        Directory(previousBackup).renameSync(currentBackup); // ディレクトリを移動
      }
    }


    Directory('${settings.minecraftDirectory}/saves_1').createSync(recursive: true);
    Directory(sourceDirectory).listSync(recursive: true).forEach((FileSystemEntity entity) {
      if (entity is File) {
        var newFile = File('${settings.minecraftDirectory}/saves_1/${entity.path.split('/').last}');
        newFile.createSync(recursive: true); // ファイルを作成
        newFile.writeAsBytesSync(File(entity.path).readAsBytesSync()); // バイトを書き込む
      }
    });
    logMessage('バックアップが正常に実行されました。');
  } else {
    logMessage('更新がないため、バックアップは実行されませんでした。');
  }
}


// 更新があるかどうかを確認する関数
bool hasChanges(String directory) {
  var sourceDirectory = Directory(directory);
  var backupDirectory = Directory('${directory}_1');

  // saves_1ディレクトリが存在しない場合は変更ありと判定
  if (!backupDirectory.existsSync()) {
    return true;
  }

  // ディレクトリ内のファイルを取得
  var sourceFiles = sourceDirectory.listSync(recursive: true).whereType<File>().toList();
  var backupFiles = backupDirectory.listSync(recursive: true).whereType<File>().toList();

  // ファイルの数が異なる場合は変更ありと判定
  if (sourceFiles.length != backupFiles.length) {
    return true;
  }

  // ファイルごとに内容を比較
  for (var i = 0; i < sourceFiles.length; i++) {
    var sourceContent = sourceFiles[i].readAsStringSync();
    var backupContent = backupFiles[i].readAsStringSync();
    if (sourceContent != backupContent) {
      return true;
    }
  }

  // すべてのファイルが一致している場合は変更なしと判定
  return false;
}







// メイン関数
void main() {
  var configFile = 'setting.ini';
  var settings = BackupSettings.fromConfigFile(configFile);

  logMessage('マインクラフトディレクトリ: ${settings.minecraftDirectory}');
  logMessage('世代数: ${settings.generations}');

  performBackup(settings);
}

