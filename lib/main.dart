//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//mixi新卒研修資料の実装：
//import 'package:flutter_chatapp/chat_page.dart';

//上記の改良版：
//import 'package:flutter_chatapp/pages/chat_page.dart';

//文字認識機能の実装：
//import 'package:flutter_chatapp/pages/ocr/chat_page_next.dart';

//音声認識機能の実装：
import 'package:flutter_chatapp/voice/chat_page.dart';


void main() async {

  //runApp(const MyApp());
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // OS のテーマ設定に合わせて変更できる
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      //home: const ChatPage(title: 'Chat by ChatGPT'),
      home: ChatPage(),
    );
  }
}