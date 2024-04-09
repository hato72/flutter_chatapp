import 'package:flutter/material.dart';
import 'package:flutter_chatapp/voice/models/chat_provider.dart';
import 'package:flutter_chatapp/voice/widget/TextAndVoiceField.dart';
//OCRを含める時は3行目をコメントアウトし、以下のコメントアウトを外す
//import 'package:flutter_chatapp/voice/widget/TextVoiceOCR.dart';
import 'package:flutter_chatapp/voice/widget/chat_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ChatPage extends StatelessWidget{
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Chat with ChatGPT',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        //ダークモード切替
        // actions: [
        //   Row(
        //     children: [
        //       Icon(Icons.dark_mode),
        //       SizedBox(width: 8),
        //       Switch.adaptive(value: true, onChanged: (value) {})
        //     ],
        //   )
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context,ref,child){
                final chats = ref.watch(chatProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context,index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }
            )
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextAndVoiceField(),
          ),
          const SizedBox(
            height: 10
          )
        ],
      )
    );
  }
}