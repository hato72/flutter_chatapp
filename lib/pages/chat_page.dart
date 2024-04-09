import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/consts.dart';

class ChatPage extends StatefulWidget{
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5),),
    enableLog: true
  );

  final ChatUser _currentUser = ChatUser(id: '1',firstName: 'hato', lastName: 'ko');

  final ChatUser _gptChatUser = ChatUser(id: '2',firstName: 'Chat', lastName: 'GPT');

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
          0,
          166, 
          126,
          1
        ),
        title: const Text(
          'Chat with ChatGPT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(0,166,126,1),
          textColor: Colors.white,
        ), 
        onSend: (ChatMessage m){
          getChatResponse(m);
        },
        messages: _messages
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0,m);
      _typingUsers.add(_gptChatUser);
    });
    List<Map<String, dynamic>> messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return {'role': 'user', 'content': m.text};
      } else {
        return {'role': 'assistant', 'content': m.text};
      }
    }).toList();
    final request = ChatCompleteText(
      model: GptTurboChatModel(), 
      messages: messagesHistory,
      maxToken: 200
    );
    final response = await _openAI.onChatCompletion(
      request: request);
    for (var i in response!.choices){
      if (i.message != null){
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptChatUser, 
              createdAt: DateTime.now(),
              text: i.message!.content
            ),
          );
        });
      }
    }

    setState(() {
      _typingUsers.remove(_gptChatUser);
    });
  }
}