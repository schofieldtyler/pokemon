import 'package:flutter/material.dart';

class BattleGround extends StatelessWidget {
  final String currentLocation;

  // 0 -> FIGHT, 1 -> BAG, 2 -> POKEMON, 3 -> RUN
  final int playerOption;

  double arrowXCoordinate() {
    if (playerOption == 0) {
      return 0.03;
    } else if (playerOption == 1) {
      return 0.5;
    } else if (playerOption == 2) {
      return 0.03;
    } else if (playerOption == 3) {
      return 0.5;
    } else {
      return null;
    }
  }

  double arrowYCoordinate() {
    if (playerOption == 0) {
      return 0.375;
    } else if (playerOption == 1) {
      return 0.375;
    } else if (playerOption == 2) {
      return 0.515;
    } else if (playerOption == 3) {
      return 0.515;
    } else {
      return null;
    }
  }

  BattleGround({this.playerOption, this.currentLocation});

  @override
  Widget build(BuildContext context) {
    if (currentLocation == 'battleground') {
      return Stack(
        children: [
          Container(
            alignment: Alignment(0, 0),
            child: Image.asset(
              'lib/images/battleground.png',
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            alignment: Alignment(arrowXCoordinate(), arrowYCoordinate()),
            child: Image.asset(
              'lib/images/arrow.png',
            ),
          ),
          Container(
            alignment: Alignment(-0.7, 0.4),
            child: Text('What will Pikachu do?',
                style: TextStyle(color: Colors.white)),
          )
        ],
      );
    } else if (currentLocation == 'attackoptions') {
      return Stack(
        children: [
          Container(
            alignment: Alignment(0, 0),
            child: Image.asset(
              'lib/images/attackoptions.png',
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            alignment: Alignment(-0.8, 0.37),
            child: Image.asset(
              'lib/images/arrow.png',
            ),
          ),

          // attack 1
          Container(
            alignment: Alignment(-0.7, 0.38),
            child: Text(
              'Tackle',
              style: TextStyle(),
            ),
          ),

          // attack 2
          Container(
            alignment: Alignment(-0.7, 0.5),
            child: Text(
              '-',
              style: TextStyle(),
            ),
          ),

          // attack 3
          Container(
            alignment: Alignment(-0.2, 0.5),
            child: Text(
              '-',
              style: TextStyle(),
            ),
          ),

          // attack 4
          Container(
            alignment: Alignment(-0.2, 0.38),
            child: Text(
              '-',
              style: TextStyle(),
            ),
          ),
        ],
      );
    } else if (currentLocation == 'battlefinishedscreen') {
      return Stack(
        children: [
          Container(
            alignment: Alignment(0, 0),
            child: Image.asset(
              'lib/images/battlefinishedscreen.png',
              width: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            alignment: Alignment(-0.7, 0.4),
            child: Text('Charmander fainted..',
                style: TextStyle(color: Colors.white)),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
