import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon/util/chatbubble.dart';
import 'characters/boy.dart';
import 'characters/charmander.dart';
import 'characters/oak.dart';
import 'characters/pikachu.dart';
import 'maps/battleground.dart';
import 'maps/littleroot.dart';
import 'maps/pokelab.dart';
import 'util/attackanimation.dart';
import 'util/button.dart';
import 'util/healthbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*

    

  */

  // little root
  double mapX = 1.125;
  double mapY = 0.65;

  // pokelab
  double labMapX = 0;
  double labMapY = 0;

  // boy
  int boySpriteCount = 0;
  String boyDirection = 'Down'; // Up Down Left Right
  String currentLocation = 'littleroot';

  // professor oak
  int oakSpriteCount = 0;
  String oakDirection = 'Down'; // Up Down Left Right
  static double oakX = 0.125;
  static double oakY = 0.9;
  bool chatStarted = false;
  int countPressingA = -1;

  // game stuff
  static double step = 0.25; // default is 0.25, pokelab is 0.43
  static double stepLab = 0.43;
  bool boyIsInfrontOfOak = false;

  // battlegroundd
  int playerOption = 0;

  // charmander entering battle
  double charmanderX = 1.5;
  double charmanderY = -0.35;
  double charmanderHealth = 78;

  // pikachu entering battle
  double pikachuX = -1.7;
  double pikachuY = 0.07;

  // attack animation
  Duration duration = Duration(milliseconds: 800);
  bool attacked = false;
  double attackX = 0.5;
  double attackY = -0.3;

  // health bars
  double healthBar1X = -3;
  double healthBar1Y = -0.45;
  double healthBar2X = 3;
  double healthBar2Y = 0.1;

  List<List<double>> noMansLandLab = [
    [0 + stepLab, -2.91],
    [0 + 2 * stepLab, -2.91],
    [0 + 3 * stepLab, -2.91],
    [0 + 4 * stepLab, -2.91],
    [0 + 5 * stepLab, -2.91],
    [0 + 6 * stepLab, -2.91],
    [0 + 7 * stepLab, -2.91 + stepLab],
    [0 + 7 * stepLab, -2.91 + 2 * stepLab],
    [0 + 7 * stepLab, -2.91 + 3 * stepLab],
    [0 + 7 * stepLab, -2.91 + 4 * stepLab],
    [0 + 7 * stepLab, -2.91 + 5 * stepLab],
    [0 + 7 * stepLab, -2.91 + 6 * stepLab],
    [0 + 7 * stepLab, -2.91 + 7 * stepLab],
    [0 + 7 * stepLab, -2.91 + 8 * stepLab],
    [0 + 7 * stepLab, -2.91 + 9 * stepLab],
    [0 - 2 * stepLab, -2.91],
    [0 - 3 * stepLab, -2.91],
    [0 - 4 * stepLab, -2.91],
    [0 - 5 * stepLab, -2.91],
    [0 - 6 * stepLab, -2.91],
    [2.15, -2.05],
    [1.29, -2.48],
    [2.15, -1.62],
    [2.15, -1.19],
    [2.58, -0.33],
    [2.58 - stepLab, -0.33],
    [2.58 - 2 * stepLab, -0.33],
    [2.58 - 3 * stepLab, -0.33],
    [2.58, -0.33 + stepLab],
    [2.58 - stepLab, -0.33 + stepLab],
    [2.58 - 2 * stepLab, -0.33 + stepLab],
    [2.58 - 3 * stepLab, -0.33 + stepLab],
    [2.58, -0.33 + 2 * stepLab],
    [2.58 - stepLab, -0.33 + 2 * stepLab],
    [2.58 - 2 * stepLab, -0.33 + 2 * stepLab],
    [2.58 - 3 * stepLab, -0.33 + 2 * stepLab],
    [2.59, 1.82],
    [2.58, 2.25],
    [2.15, 2.25],
    [1.72, 1.82],
    [1.29, 2.25],
    [1.29 - 1 * stepLab, 2.25],
    [1.29 - 2 * stepLab, 2.25],
    [1.29 - 3 * stepLab, 2.25],
    [1.29 - 4 * stepLab, 2.25],
    [1.29 - 5 * stepLab, 2.25],
    [1.29 - 6 * stepLab, 2.25],
    [1.29 - 7 * stepLab, 2.25],
    [1.29 - 8 * stepLab, 2.25],
    [-2.15, 1.82],
    [-2.58, 1.39],
    [-1.72, 0.96],
    [-1.29, 0.96],
    [-1.29, 1.39],
    [-1.72, 1.39],
    [-3.01, 0.96],
    [-3.01, 0.96 - 1 * stepLab],
    [-3.01, 0.96 - 2 * stepLab],
    [-3.01, 0.96 - 3 * stepLab],
    [-3.01, 0.96 - 4 * stepLab],
    [-3.01, 0.96 - 5 * stepLab],
    [-3.01, 0.96 - 6 * stepLab],
    [-3.01, 0.96 - 7 * stepLab],
    [-3.01, 0.96 - 8 * stepLab],
    [-3.01, 0.96 - 9 * stepLab],
    [-2.58, -2.05],
    [-2.15, -2.05],
    [-2.15, -1.62],
    [-2.58, -1.62],
    [-2.58, -1.19],
    [-2.15, -1.19],
    [-2.58, -0.33],
    [-2.15, -0.33],
    [-1.72, -0.33],
    [-1.72, -0.1],
    [-2.15, 0.1]
  ];

  List<List<double>> noMansLandLittleroot = [
    [oakX, oakY], // prof oak coordinates
    [0.125, 2.9],
    [0.125, 2.65],
    [0.375, 2.65],
    [0.625, 2.65],
    [0.875, 2.65],
    [1.125, 2.65],
    [1.375, 2.65],
    [1.625, 2.65],
    [1.875, 2.65],
    [2.125, 2.65],
    [2.625, 1.9],
    [2.625, 2.15],
    [2.375, 2.15],
    [2.125, 2.15],
    [2.125, 2.4],
    [2.625, 1.65],
    [2.625, 1.4],
    [2.625, 1.15],
    [2.625, 0.9],
    [2.625, 0.65],
    [2.625, 0.4],
    [2.625, 0.15],
    [2.625, -0.1],
    [2.625, -0.35],
    [2.625, -0.6],
    [2.625, -0.85],
    [2.625, -1.1],
    [2.625, -1.35],
    [2.625, -1.6],
    [2.375, -1.6],
    [2.125, -1.6],
    [2.125, -1.85],
    [2.125, -2.1],
    [1.875, -2.1],
    [1.625, -2.1],
    [1.375, -2.1],
    [1.125, -2.1],
    [0.875, -2.1],
    [0.625, -2.1],
    [0.375, -2.1],
    [0.125, -2.1],
    [-0.125, -2.1],
    [-0.375, -2.1],
    [-0.625, -2.1],
    [-0.875, -2.1],
    [-1.125, -2.1],
    [-1.375, -2.1],
    [-1.625, -2.1],
    [-0.875, -2.1],
    [-1.125, -2.1],
    [-1.375, -2.1],
    [-1.625, -2.1],
    [-1.875, -1.6],
    [-2.125, -1.6],
    [-2.375, -1.1],
    [-2.625, -1.1],
    [-2.625, -0.85],
    [-2.625, -0.6],
    [-2.625, -0.35],
    [-2.625, -0.1],
    [-2.625, 0.15],
    [-2.625, 0.4],
    [-2.625, 0.65],
    [-2.625, 0.9],
    [-2.625, 1.15],
    [-2.625, 1.4],
    [-2.625, 1.65],
    [-2.625, 1.9],
    [-2.625, 2.15],
    [-2.375, 2.15],
    [-2.125, 2.15],
    [-2.125, 2.4],
    [-2.125, 2.65],
    [-1.875, 2.65],
    [-1.625, 2.65],
    [-1.375, 2.65],
    [-1.125, 2.65],
    [-0.875, 2.65],
    [-0.625, 2.65],
    [-0.625, 0.9],
    [-0.875, 0.9],
    [-1.125, 0.9],
    [-1.375, 0.9],
    [-1.625, 0.9],
    [-1.875, 0.9],
    [-1.875, 1.15],
    [-1.625, 1.15],
    [-1.375, 1.15],
    [-1.125, 1.15],
    [-0.875, 1.15],
    [-1.875, 1.4],
    [-1.625, 1.4],
    [-1.375, 1.4],
    [-1.125, 1.4],
    [-0.875, 1.4],
    [-1.875, 1.65],
    [-1.625, 1.65],
    [-1.375, 1.65],
    [-1.125, 1.65],
    [-0.875, 1.65],
    [-1.875, 1.9],
    [-1.625, 1.9],
    [-1.375, 1.9],
    [-1.125, 1.9],
    [-0.875, 1.9],
    [0.625, 0.9],
    [0.875, 0.9],
    [1.125, 0.9],
    [1.375, 0.9],
    [1.625, 0.9],
    [1.875, 0.9],
    [0.875, 1.15],
    [1.125, 1.15],
    [1.375, 1.15],
    [1.625, 1.15],
    [1.875, 1.15],
    [0.875, 1.4],
    [1.125, 1.4],
    [1.375, 1.4],
    [1.625, 1.4],
    [1.875, 1.4],
    [0.875, 1.65],
    [1.125, 1.65],
    [1.375, 1.65],
    [1.625, 1.65],
    [1.875, 1.65],
    [0.875, 1.9],
    [1.125, 1.9],
    [1.375, 1.9],
    [1.625, 1.9],
    [1.875, 1.9],
    [1.625, -0.1],
    [1.375, -0.1],
    [1.125, -0.1],
    [0.875, -0.1],
    [0.625, -0.1],
    [0.375, -0.1],
    [0.125, -0.1],
    [1.625, -0.35],
    [1.375, -0.35],
    [1.125, -0.35],
    [0.875, -0.35],
    [0.625, -0.35],
    [0.375, -0.35],
    [0.125, -0.35],
    [1.625, -0.6],
    [1.375, -0.6],
    [1.125, -0.6],
    [0.875, -0.6],
    [0.625, -0.6],
    [0.375, -0.6],
    [0.125, -0.6],
    [1.625, -0.85],
    [1.375, -0.85],
    [1.125, -0.85],
    [0.875, -0.85],
    [0.625, -0.85],
    [0.375, -0.85],
    [0.125, -0.85],
    [1.625, -1.1],
    [1.375, -1.1],
    [1.125, -1.1],
    [0.875, -1.1],
    [0.375, -1.1],
    [0.125, -1.1],
    [0.875, -1.35],
    [-1.375, -0.35],
    [-1.625, -1.85],
    [-1.625, -1.6],
    [-2.125, -1.35],
    [-2.125, -1.1],
    [-0.625, 2.9],
    [-0.125, 3.15],
    [-0.375, 3.15]
  ];

  void animateWalk() {
    print('x: ' +
        double.parse(mapX.toStringAsFixed(4)).toString() +
        ', y: ' +
        double.parse(mapY.toStringAsFixed(4)).toString());
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });

      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }
    });

    setState(() {
      if (mapY < 0.9) {
        boyIsInfrontOfOak = true;
      } else {
        boyIsInfrontOfOak = false;
      }

      if (chatStarted) {
        pressedButtonB();
      }
    });
  }

  double cleanNum(double num) {
    return double.parse(num.toStringAsFixed(4));
  }

  bool canMoveTo(String direction, var noMansLand, double x, double y) {
    double stepX = 0;
    double stepY = 0;

    if (direction == 'Left') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    for (int i = 0; i < noMansLand.length; i++) {
      if ((cleanNum(noMansLand[i][0]) == cleanNum(x + stepX)) &&
          (cleanNum(noMansLand[i][1]) == cleanNum(y + stepY))) {
        return false;
      }
    }
    return true;
  }

  void moveLeft() {
    boyDirection = 'Left';

    // no mans land for littleroot
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX += step;
        });
      }
      animateWalk();
    }

    // no mans land for pokelab
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapX += step;
        });
      }
      animateWalk();
    }

    // battleground
    setState(() {
      if (currentLocation == 'battleground') {
        if (playerOption == 1) {
          playerOption = 0;
        } else if (playerOption == 3) {
          playerOption = 2;
        }
      }
    });
  }

  void moveRight() {
    boyDirection = 'Right';

    // no mans land for littleroot
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
      animateWalk();
    }

    // no mans land for pokelab
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapX -= step;
        });
      }
      animateWalk();
    }

    // battleground
    setState(() {
      if (currentLocation == 'battleground') {
        if (playerOption == 0) {
          playerOption = 1;
        } else if (playerOption == 2) {
          playerOption = 3;
        }
      }
    });
  }

  void moveUp() {
    boyDirection = 'Up';

    // no mans land for littleroot
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY += step;
        });
      }

      // enter pokelab
      if (double.parse((mapX).toStringAsFixed(4)) == 0.6250 &&
          double.parse((mapY).toStringAsFixed(4)) == -1.1) {
        setState(() {
          currentLocation = 'pokelab';
          labMapX = 0;
          labMapY = -2.73;
        });
      }
      animateWalk();
    }

    // no mans land for pokelab
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapY += step;
        });
      }
      animateWalk();
    }

    // battleground
    setState(() {
      if (currentLocation == 'battleground') {
        if (playerOption == 2) {
          playerOption = 0;
        } else if (playerOption == 3) {
          playerOption = 1;
        }
      }
    });
  }

  void moveDown() {
    boyDirection = 'Down';

    // no mans land for littleroot
    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY -= step;
        });
      }
      animateWalk();
    }

    // no mans land for pokelab
    if (currentLocation == 'pokelab') {
      if (canMoveTo(boyDirection, noMansLandLab, labMapX, labMapY)) {
        setState(() {
          labMapY -= step;
        });
      }
      // exit pokelab -> enter littleroot
      if ((cleanNum(labMapX) == 0.0 && cleanNum(labMapY) == -2.91) ||
          (cleanNum(labMapX) == -0.43 && cleanNum(labMapY) == -2.91)) {
        setState(() {
          currentLocation = 'littleroot';
          mapX = 0.625;
          mapY = -1.35;
        });
      }

      animateWalk();
    }

    // battleground
    setState(() {
      if (currentLocation == 'battleground') {
        if (playerOption == 0) {
          playerOption = 2;
        } else if (playerOption == 1) {
          playerOption = 3;
        }
      }
    });
  }

  void printCoordinates() {
    print('mapX = ' + mapX.toString());
    print('mapY = ' + mapY.toString());

    print('oakX = ' + oakX.toString());
    print('oakY = ' + oakY.toString());
    print('step = ' + step.toString());
  }

  void pressedButtonA() {
    if (currentLocation == 'battleground') {
      switch (playerOption) {
        case 0:
          {
            setState(() {
              currentLocation = 'attackoptions';
            });
          }
          break;

        case 1:
          {
            //statements;
          }
          break;

        case 2:
          {
            //statements;
          }
          break;

        case 3:
          {
            setState(() {
              currentLocation = 'littleroot';
              countPressingA = -1;
              playerOption = 0;
              chatStarted = false;
            });
          }
          break;

        default:
          {
            //statements;
          }
          break;
      }
    } else if (currentLocation == 'attackoptions') {
      pikachuAttack();
    } else if (currentLocation == 'battlefinishedscreen') {
      setState(() {
        currentLocation = 'littleroot';
      });
    } else {
      /*

    if we are facing profoak and we press A, he will talk to us.
    there are 4 situations to consider:

    UP, DOWN, LEFT, RIGHT

    */

      // if we are facing UP and the next step is prof oak, we can talk
      if (boyDirection == 'Up' &&
          cleanNum(mapX) == cleanNum(oakX) &&
          cleanNum(mapY + step) == cleanNum(oakY)) {
        talkProfOak();
        setState(() {
          oakDirection = 'Down';
        });
      }

      // if we are facing DOWN and the next step is prof oak, we can talk
      if (boyDirection == 'Down' &&
          cleanNum(mapX) == cleanNum(oakX) &&
          cleanNum(mapY - step) == cleanNum(oakY)) {
        talkProfOak();
        setState(() {
          oakDirection = 'Up';
        });
      }

      // if we are facing LEFT and the next step is prof oak, we can talk
      if (boyDirection == 'Left' &&
          cleanNum(mapX + step) == cleanNum(oakX) &&
          cleanNum(mapY) == cleanNum(oakY)) {
        talkProfOak();
        setState(() {
          oakDirection = 'Right';
        });
      }

      // if we are facing RIGHT and the next step is prof oak, we can talk
      if (boyDirection == 'Right' &&
          cleanNum(mapX - step) == cleanNum(oakX) &&
          cleanNum(mapY) == cleanNum(oakY)) {
        talkProfOak();
        setState(() {
          oakDirection = 'Left';
        });
      }
    }
  }

  void pressedButtonB() {
    setState(() {
      chatStarted = false;
      countPressingA = -1;
      if (currentLocation == 'attackoptions') {
        currentLocation = 'battleground';
        playerOption = 0; // set this back to 'fight' option
      }
    });
  }

  void talkProfOak() {
    setState(() {
      chatStarted = true;
      countPressingA++;

      // chat ends after 2 lines, now enter battle ground
      if (countPressingA == 2) {
        currentLocation = 'battleground';

        enterPokemonsToBattle();
      }
    });
  }

  void enterPokemonsToBattle() {
    setState(() {
      charmanderX = 0.6;
      pikachuX = -0.5;
    });
    enterHealthBars();
  }

  void enterHealthBars() {
    setState(() {
      healthBar1X = -0.7;
      healthBar2X = 0.7;
    });
  }

  void pikachuAttack() {
    int animationStep = 1;
    double initialPikachuPos = pikachuX;
    double initialCharmanderPos = charmanderX;
    duration = Duration(milliseconds: 50);

    if (attacked == false) {
      setState(() {
        attacked = true;
        if (charmanderHealth - 25 < 0) {
          charmanderHealth = 0;
          finishBattle();
        } else {
          charmanderHealth -= 25;
        }
      });

      Timer.periodic(duration, (timer) {
        if (animationStep == 1) {
          setState(() {
            pikachuX = initialPikachuPos + 0.2;
            charmanderX = initialCharmanderPos + 0.02;
          });
          animationStep++;
        } else if (animationStep == 2) {
          setState(() {
            pikachuX = initialPikachuPos;
            charmanderX = initialCharmanderPos;
          });
          animationStep = 1;
          attacked = false;
          timer.cancel();
        }
      });
    }
  }

  void finishBattle() {
    setState(() {
      charmanderY = 1.5;
      currentLocation = 'battlefinishedscreen';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == 'littleroot') {
      step = 0.25;
    } else if (currentLocation == 'pokelab') {
      step = 0.43;
    }

    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            moveDown();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            moveUp();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          } else if (event.isKeyPressed(LogicalKeyboardKey.keyA)) {
            pressedButtonA();
          } else if (event.isKeyPressed(LogicalKeyboardKey.keyB)) {
            pressedButtonB();
          }
        },
        autofocus: true,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    // battleground
                    BattleGround(
                      currentLocation: currentLocation,
                      playerOption: playerOption,
                    ),

                    // littleroot
                    LittleRoot(
                      x: mapX,
                      y: mapY,
                      currentMap: currentLocation,
                    ),

                    // pokelab
                    MyPokeLab(
                      x: labMapX,
                      y: labMapY,
                      currentMap: currentLocation,
                    ),

                    // prof oak when boy is infront of oak
                    boyIsInfrontOfOak
                        ? Container(
                            alignment: Alignment(0, 0),
                            child: ProfOak(
                              x: mapX,
                              y: mapY - 0.05,
                              location: currentLocation,
                              oakDirection: oakDirection,
                            ),
                          )
                        : Container(),

                    // boy
                    Container(
                      alignment: Alignment(0, 0),
                      child: MyBoy(
                        boySpriteCount: boySpriteCount,
                        direction: boyDirection,
                        location: currentLocation,
                      ),
                    ),

                    // prof oak when boy is behind/left/right of oak
                    boyIsInfrontOfOak
                        ? Container()
                        : Container(
                            alignment: Alignment(0, 0),
                            child: ProfOak(
                              x: mapX,
                              y: mapY - 0.05,
                              location: currentLocation,
                              oakDirection: oakDirection,
                            ),
                          ),

                    // chat bubble when prof oak speaks
                    Container(
                      alignment: Alignment(0, 0.9),
                      child: ChatBubble(
                        countPressingA: countPressingA,
                        chatStarted: chatStarted,
                      ),
                    ),

                    // charmander
                    AnimatedContainer(
                        duration: duration,
                        alignment: Alignment(charmanderX, charmanderY),
                        child: (currentLocation == 'battleground' ||
                                currentLocation == 'attackoptions' ||
                                currentLocation == 'battlefinishedscreen')
                            ? MyCharmander()
                            : Container()),

                    // pikachu
                    AnimatedContainer(
                        duration: duration,
                        alignment: Alignment(pikachuX, pikachuY),
                        child: (currentLocation == 'battleground' ||
                                currentLocation == 'attackoptions' ||
                                currentLocation == 'battlefinishedscreen')
                            ? MyPikachu()
                            : Container()),

                    // health bar 1
                    AnimatedContainer(
                      duration: duration,
                      alignment: Alignment(healthBar1X, healthBar1Y),
                      child: HealthBar(
                        currentLocation: currentLocation,
                        healthbarnumber: 1,
                        pokemonName: 'Charmander',
                        pokemonLvl: '1',
                        charmanderHealth: charmanderHealth,
                      ),
                    ),

                    // health bar 2
                    AnimatedContainer(
                      duration: duration,
                      alignment: Alignment(healthBar2X, healthBar2Y),
                      child: HealthBar(
                        currentLocation: currentLocation,
                        healthbarnumber: 2,
                        pokemonName: 'Pikachu',
                        pokemonLvl: '5',
                      ),
                    ),

                    // attack
                    Container(
                      alignment: Alignment(attackX, attackY),
                      child: attacked ? AttackAnimation() : Container(),
                    ),

                    // border
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 20, color: Colors.black)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'G A M E B O Y',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            '  ♥  ',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                          Text(
                            'F L U T T E R',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                    MyButton(
                                      function: moveUp,
                                      text: '↑',
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      function: moveLeft,
                                      text: '←',
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                    MyButton(
                                      function: moveRight,
                                      text: '→',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                    MyButton(
                                      function: moveDown,
                                      text: '↓',
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                    MyButton(
                                      function: pressedButtonA,
                                      text: 'a',
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      function: pressedButtonB,
                                      text: 'b',
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        'C R E A T E D B Y K O K O',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
