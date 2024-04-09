import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final bool isMe;

  const ProfileContainer({super.key,required this.isMe});
  
  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isMe? Theme.of(context).colorScheme.onPrimary : Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(isMe ? 0 : 15),
          bottomRight: Radius.circular(isMe ? 15 : 0),
        ),
      ),
      child: Icon(
        isMe ? Icons.person : Icons.computer,

      ),
    );
  }
}