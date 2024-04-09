import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class APIHandler {
  final _openAI = OpenAI.instance.build(
    token: '<your api key>',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  Future<String> getResponse(String message) async {
    try {
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": message})
      ], maxToken: 200, model: Gpt40631ChatModel());

      final response = await _openAI.onChatCompletion(request: request);
      if (response != null && response.choices.isNotEmpty) {
        final content = response.choices[0].message?.content;
        if (content != null) {
          return content.trim();
        }
      }

      return 'Some thing went wrong';
    } catch (e) {
      return 'Bad response';
    }
  }

  // void dispose() {
  //   _openAI.close();
  // }
}