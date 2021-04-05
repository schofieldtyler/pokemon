import 'package:flutter/material.dart';

class ProfOak extends StatelessWidget {
  double x;
  double y;
  String location;
  String oakDirection;

  ProfOak({this.x, this.y, this.location, this.oakDirection});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      if (oakDirection == 'Up') {
        return Container(
          alignment: Alignment(x, y),
          child: Image.asset(
            'lib/images/profoakback.png',
            width: MediaQuery.of(context).size.width *
                0.75, // currently works with 0.75
            fit: BoxFit.cover,
          ),
        );
      } else if (oakDirection == 'Down') {
        return Container(
          alignment: Alignment(x, y),
          child: Image.asset(
            'lib/images/profoakfront.png',
            width: MediaQuery.of(context).size.width *
                0.75, // currently works with 0.75
            fit: BoxFit.cover,
          ),
        );
      } else if (oakDirection == 'Left') {
        return Container(
          alignment: Alignment(x, y),
          child: Image.asset(
            'lib/images/profoakleft.png',
            width: MediaQuery.of(context).size.width *
                0.75, // currently works with 0.75
            fit: BoxFit.cover,
          ),
        );
      } else if (oakDirection == 'Right') {
        return Container(
          alignment: Alignment(x, y),
          child: Image.asset(
            'lib/images/profoakright.png',
            width: MediaQuery.of(context).size.width *
                0.75, // currently works with 0.75
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return Container();
    }
  }
}
