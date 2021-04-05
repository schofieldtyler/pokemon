import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  bool chatStarted;
  int countPressingA;

  List<String> profOakSentences = [
    'Hi there, I\'m Professor Oak.',
    'Let\'s fight bitch!',
  ];

  ChatBubble({this.chatStarted, this.countPressingA});

  @override
  Widget build(BuildContext context) {
    if (chatStarted == false) {
      return Container();
    } else if (countPressingA < 2) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,
          color: Colors.white,
          child: Text(profOakSentences[countPressingA]),
        ),
      );
    } else {
      return Container();
    }
  }
}
