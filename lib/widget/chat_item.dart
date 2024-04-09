import 'package:flutter/material.dart';
import 'package:flutter_chatapp/widget/ProfileContainer.dart';

class ChatItem extends StatelessWidget {
  final String text;
  final bool isMe;
  const ChatItem({super.key,required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isMe) ProfileContainer(isMe : isMe),
          if(!isMe) const SizedBox(width: 15),
          //以下をprofilecontainerにしたい

          // Container(
          //   alignment: Alignment.center,
          //   width: 40,
          //   height: 40,
          //   decoration: BoxDecoration(
          //     color: isMe? Theme.of(context).colorScheme.onPrimary : Colors.grey.shade800,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(10),
          //       topRight: Radius.circular(10),
          //       bottomLeft: Radius.circular(isMe ? 0 : 15),
          //       bottomRight: Radius.circular(isMe ? 15 : 0),
          //     ),
          //   ),
          //   child: Icon(
          //     isMe ? Icons.person : Icons.computer,

          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
            decoration: BoxDecoration(
              color : isMe? Theme.of(context).colorScheme.secondary : Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: Radius.circular(isMe ? 0 : 15),
                bottomRight: Radius.circular(isMe ? 15 : 0),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
          if(isMe) const SizedBox(width: 15),
          if(isMe) ProfileContainer(isMe : isMe),
        ],
      )
    );
  }
}