import 'package:flutter/material.dart';
import 'package:flutter_chatapp/models/chat_provider.dart';
import 'package:flutter_chatapp/widget/TextAndVoiceField.dart';
import 'package:flutter_chatapp/widget/chat_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//https://www.youtube.com/watch?v=UaKFvEPjs9I&list=WL&index=2 58分くらい

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