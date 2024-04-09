//import 'package:flutter_chatapp/chat_page.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/voice/chat_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_chatapp/pages/chat_page_next.dart';
//import 'package:flutter_chatapp/pages/chat_page.dart';


// 中枢！main.dart の main() が最初に呼ばれる
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