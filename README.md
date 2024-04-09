# flutter_chatapp

A new Flutter project.

参考： (https://github.com/mixigroup/2023BeginnerTrainingFlutter/)

上記のリポジトリや研修資料などを参照して再現実装したがエラーが起こるため実装内容を変更した。

#### 上記の改良版の実行方法

main.dartで8行目のimport文のコメントアウトを外し、11、14行目ののimportをコメントアウトし実行

### 画像上の文字を認識しメッセージを送信する機能を追加(少し雑なデザイン)

#### 実行方法

①main.dartで11行目のimport文のコメントアウトを外し、8、14行目のimportをコメントアウトし実行

②その後、(https://github.com/hato72/python_ocr) のmain.pyを実行

### 音声認識からメッセージを送信する機能を追加

#### 実行方法

main.dartで14行目ののimport文のコメントアウトを外し、8、11行目のimportをコメントアウトし実行

### 音声認識処理と画像の文字認識処理を同時に実装(整形)

#### 実行方法

音声認識実装の部分の手順を行い、voice/chat_page.dartの3行目をコメントアウトし、5行目のコメントアウトを外す

その後、画像文字認識実装部分の手順②を行う

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
