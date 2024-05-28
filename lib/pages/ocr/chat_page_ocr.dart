import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/consts.dart';
import 'dart:typed_data';
import 'dart:convert';
//import 'dart:html' as html;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class ChatPage extends StatefulWidget{
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  Uint8List? _pickedImage;
  String _ocrResult = "";
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void endLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();
    if (imageBytes != null) {
      setState(() {
        _pickedImage = imageBytes;
        _ocrResult = ""; // リセット
      });
    }
  }

  Future<void> _sendImage() async {
    if (_pickedImage != null) {
      String base64Image = base64Encode(_pickedImage!);
      Uri url = Uri.parse('http://127.0.0.1:5000/trimming');
      String body = json.encode({
        'post_img': base64Image,
      });

      //startLoading();

      try {
        Response response = await http.post(url, body: body);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          setState(() {
            _ocrResult = data['ocr_result'];
          });
          getChatResponse(ChatMessage(
            user: _currentUser, 
            createdAt: DateTime.now(),
            text: _ocrResult,
          ));
        } else {
          print('エラー: ${response.statusCode}');
        }

        //final data = json.decode(response.body);
        //String imageBase64 = data['result'];
        //Uint8List bytes = base64Decode(imageBase64);

        // setState(() {
        //   _ocrResult = data['ocr_result'];
        // });

      } catch (e) {
        print('Error: $e');
      }

      //endLoading();
    }
  }

  final _openAI = OpenAI.instance.build(
    token: NEXT_PUBLIC_OPENAI_API_KEY,
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
      // body: DashChat(
      //   currentUser: _currentUser,
      //   typingUsers: _typingUsers,
      //   messageOptions: const MessageOptions(
      //     currentUserContainerColor: Colors.black,
      //     containerColor: Color.fromRGBO(0,166,126,1),
      //     textColor: Colors.white,
      //   ), 
      //   onSend: (ChatMessage m){
      //     getChatResponse(m);
      //   },
      //   messages: _messages,
      // ),
      body: Column(
        children: [
          Expanded(
            child: DashChat(
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
              messages: _messages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              ElevatedButton(
                onPressed: _sendImage,
                child: const Text('OCR'),
              ),
            ],
          )
        ],
      )
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