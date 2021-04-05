import 'package:flutter/material.dart';

class MyPikachu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/pikachu.png',
        height: 100,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
