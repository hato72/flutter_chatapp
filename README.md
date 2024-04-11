# flutter_chatapp

A new Flutter project.

参考： (https://github.com/mixigroup/2023BeginnerTrainingFlutter/)

上記のリポジトリや研修資料などを参照して再現実装したがエラーが起こるため実装内容を変更した。
<dl>
<dt>上記の改良版の実行方法：</dt>

<dd>main.dartで8行目のimport文のコメントアウトを外し、11、14行目ののimportをコメントアウトし実行</dd>

***

#### 画像上の文字を認識しメッセージを送信する機能を追加(少し雑なデザイン)：

<dt>実行方法</dt>
<dd>
①main.dartで11行目のimport文のコメントアウトを外し、8、14行目のimportをコメントアウトし実行

②その後、(https://github.com/hato72/python_ocr) のmain.pyを実行
</dd>

***

#### 音声認識からメッセージを送信する機能を追加：

<dt>実行方法</dt>

<dd>main.dartで14行目ののimport文のコメントアウトを外し、8、11行目のimportをコメントアウトし実行</dd>

***

#### 音声認識処理と画像の文字認識処理を同時に実装(整形)：

<dt>実行方法</dt>

<dd>
音声認識実装の部分の手順を行い、voice/chat_page.dartの3行目をコメントアウトし、5行目のコメントアウトを外す

その後、画像文字認識実装部分の手順②を行う
</dd>

***

</dl>

#### 開発アイデア・実装メモ
claudeは、プログラムファイルを選択した際に、ファイルが自動的に"選択したファイル名.txt"に変換されるようになっているが、chatGPTではファイルを送信することができない 

=> 本プログラムでclaudeと同様のシステムを実装したい
