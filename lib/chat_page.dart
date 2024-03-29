//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/model/answer.dart';
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

  bool loading = false;

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
    String? apikey = Env.apikey;
    //print(apikey.runtimeType);

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
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

    //Map<String, dynamic> answer = json.decode(response.body);
    Map<String, dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    final answer = Answer.fromJson(body);
    
    setState(() {
      //_text = answer['choices'][0]["message"]["content"];
      _text = answer.choices.first.message.content;
    });
  }

  // Widget createProgressIndicator() {   
  //   return Container(     
  //     alignment: Alignment.center,     
  //     child: const CircularProgressIndicator(       
  //       color: Colors.green,     
  //     )   
  //   ); 
  // }

  @override
  Widget build(BuildContext context) {
    // Scaffold は土台みたいな感じ（白紙みたいな）
    return Scaffold(
      // AppBar は上のヘッダー
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      // Center で真ん中寄せ
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            loading
                ? const CircularProgressIndicator(
                    color: Colors.orange,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
