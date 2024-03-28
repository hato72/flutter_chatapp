//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/post_page.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env.dart';

class ChatPage extends StatefulWidget{
  
  const ChatPage({super.key,required this.title});
  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{
  //String text = "";
  String _text = "";

  Future<void> openPostPage() async {
    final v = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostPage(),
        fullscreenDialog: true,
      ),
    );

    if (v != null){
      // setState(() {
      //   text = v;
      // });
      await postChat(v);
    }
  }

  Future<void> postChat(String text) async{
    //String apikey = dotenv.get('Api_key');
    String apikey = Env.apikey;
    final response = await http.post(
      Uri.parse('https://api.openapi.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apikey',
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": text}
        ]
      }),
    );

    Map<String, dynamic> answer = json.decode(response.body);
    // Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    // const answer = model.fromJson(body);
    
    setState(() {
      _text = answer['choices'][0]["message"]["content"];
      //_text = answer.choices.first.message.content;
    });
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),

      body: Center(
        child: Text(
          _text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await openPostPage();
        },
        tooltip: 'post',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
