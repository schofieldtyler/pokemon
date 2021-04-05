import 'package:flutter/material.dart';

class HealthBar extends StatelessWidget {
  final int healthbarnumber; // healthbar1.png or healthbar2.png
  final currentLocation;
  final String pokemonName;
  final String pokemonLvl;
  final double charmanderHealth;

  HealthBar(
      {this.healthbarnumber,
      this.currentLocation,
      this.pokemonName,
      this.pokemonLvl,
      this.charmanderHealth});

  @override
  Widget build(BuildContext context) {
    if (currentLocation == 'battleground' ||
        currentLocation == 'attackoptions' ||
        currentLocation == 'battlefinishedscreen') {
      return Stack(
        children: [
          Container(
            child: Image.asset(
              'lib/images/healthbar' + healthbarnumber.toString() + '.png',
              height: 55,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            alignment: Alignment(-0.2, -0.5),
            height: 55,
            width: 100,
            child: Text(
              pokemonName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            ),
          ),

          // black bar health
          Container(
            alignment: healthbarnumber == 1
                ? Alignment(0.5, 0.43)
                : Alignment(0.3, 0.2),
            height: 50,
            width: 165,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey[700],
                height: 9,
                width: healthbarnumber == 1 ? 80 : 67,
              ),
            ),
          ),

          // green bar health
          Container(
            alignment: healthbarnumber == 1
                ? Alignment(0.5, 0.43)
                : Alignment(0.3, 0.2),
            height: 50,
            width: 165,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.grey[700],
                alignment: Alignment.centerLeft,
                height: healthbarnumber == 1 ? 9 : 7,
                width: healthbarnumber == 1 ? 80 : 67,
                child: Container(
                  color: Colors.green[500],
                  width: charmanderHealth,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
