import 'dart:convert';

import 'package:flutter_chatapp/consts.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> chatgpt(String prompt) async {
    if (NEXT_PUBLIC_OPENAI_API_KEY.isEmpty) {
      return 'APIキーが指定されていません。';
    }

    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $NEXT_PUBLIC_OPENAI_API_KEY',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
            }
          ],
        }),
      );
      //print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }else if (res.statusCode == 429) {
        return 'リクエスト上限に達しました。';
      } else {
        return '内部エラーが発生しました: ${res.statusCode}';
      }
      //return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $NEXT_PUBLIC_OPENAI_API_KEY',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );
      print(res.body);

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }else if (res.statusCode == 429) {
        return 'リクエスト上限に達しました.';
      } else {
        return '内部エラーが発生しました. : ${res.statusCode}';
      }
      //return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}