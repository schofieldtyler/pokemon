import 'package:flutter/material.dart';

class MyCharmander extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/charmander.png',
        height: 100,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
