import 'package:flutter/material.dart';

class AttackAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/attackimage.png',
        width: 50,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
