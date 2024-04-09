import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_chatapp/voice/handler/api_handler.dart';
import 'package:flutter_chatapp/voice/models/chat_model.dart';
import 'package:flutter_chatapp/voice/models/chat_provider.dart';
import 'package:flutter_chatapp/voice/handler/voice_handler.dart';
import 'package:flutter_chatapp/voice/widget/toggle_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum InputMode{
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget{
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField>{
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  final APIHandler _openAI = APIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();
  var _isReplying = false;
  var _isListening = false;

  @override
  void initState(){
    voiceHandler.initSpeech();
    super.initState();
  }


  @override
  void dispose(){
    _messageController.dispose();
    //_openAI.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value){
              value.isNotEmpty ? setInputMode(InputMode.text) : setInputMode(InputMode.voice);
            },
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              )
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        ToggleButton(
          isListening: _isListening,
          isReplying: _isReplying,
          inputMode: _inputMode,
          sendTextMessage: () {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        )
      ],
    );
  }
  void setInputMode(InputMode inputMode){
    setState(() {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() async{
    // if(voiceHandler.isEnabled){
    //   print("not supported");
    //   return;
    // }
    if(voiceHandler.speechToText.isListening){
      await voiceHandler.StopListening();
      setListeningState(false);
    }else{
      setListeningState(true);
      final result = await voiceHandler.startListening();
      setListeningState(false);
      sendTextMessage(result);
    }
  }

  void sendTextMessage(String message) async {
    // final chats = ref.read(chatProvider.notifier);
    //   chats.add(ChatModel(
    //     id: DateTime.now().toString(),
    //     message: message,
    //     isMe: true
    //   ),
    // );
    setState(() {
      _isReplying = true;
    });
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('typing...', false, 'typing');
    setInputMode(InputMode.voice);

    final AIResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(AIResponse, false, DateTime.now().toString());
    setState(() {
      _isReplying = false;
    });
  }

  void setListeningState(bool isListening){
    setState(() {
      _isListening = isListening;
    });
  }

  void removeTyping(){
    final chats = ref.read(chatProvider.notifier);
    chats.removeTyping();
  }

  void addToChatList(String message,bool isMe,String id){
    final chats = ref.read(chatProvider.notifier);
    chats.add(
      ChatModel(id: id, message: message, isMe: isMe)
    );
  }
}