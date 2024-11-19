import 'dart:async';
import 'package:pokemon_app_games/characters/oak.dart';
import 'package:pokemon_app_games/maps/boundaries.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app_games/button.dart';
import 'package:pokemon_app_games/characters/boy.dart';
import 'package:pokemon_app_games/maps/littleroot.dart';
import 'package:pokemon_app_games/maps/pokelab.dart';
import 'package:pokemon_app_games/maps/pokelabboundaries.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
  VARIABLES
  */

  //literoot
  double mapX = 1.7;
  double mapY = 0.55;

  //pokelab
  double LabmapX = 0;
  double LabmapY = 0;

  //professor oak
  String oakDirection = 'Down';
  static double oakX = 0.1;
  static double oakY = 0.35;
  bool chatStarted = false;
  int countPressingA = -1;

  //boycharacter
  int boySpriteCount = 0;
  String boyDirection = 'Down';

  //game stuff
  String currentLocation = 'littleroot';
  double step = 0.20;

  //no mans land for littleroot(package:pokemon_app_games/maps/boundaries.dart)

  void moveUp() {
    boyDirection = 'Up';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY += step;
        });
      }
      if (double.parse((mapX).toStringAsFixed(4)) == 0.9 &&
          double.parse((mapY).toStringAsFixed(4)) == -1.05) {
        setState(() {
          currentLocation = 'PokemonLab';
          LabmapX = -0.4;
          LabmapY = -4.8;
        });
      }
    } else if (currentLocation == 'PokemonLab') {
      if (canMoveTo(boyDirection, noMansLandPokeLab, LabmapX, LabmapY)) {
        setState(() {
          LabmapY += step;
        });
      }
    }

    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapY -= step;
        });
      }
    } else if (currentLocation == 'PokemonLab') {
      if (canMoveTo(boyDirection, noMansLandPokeLab, LabmapX, LabmapY)) {
        setState(() {
          LabmapY -= step;
        });
      }
      if (double.parse((LabmapX).toStringAsFixed(4)) == -0.4 &&
          double.parse((LabmapY).toStringAsFixed(4)) == -5.0) {
        setState(() {
          currentLocation = 'littleroot';
          mapX = 0.9;
          mapY = -1.25;
        });
      }
    }

    animateWalk();
  }

  void moveLeft() {
    boyDirection = 'Left';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX += step;
        });
      }
    } else if (currentLocation == 'PokemonLab') {
      if (canMoveTo(boyDirection, noMansLandPokeLab, LabmapX, LabmapY)) {
        setState(() {
          LabmapX += step;
        });
      }
    }

    animateWalk();
  }

  void moveRight() {
    boyDirection = 'Right';

    if (currentLocation == 'littleroot') {
      if (canMoveTo(boyDirection, noMansLandLittleroot, mapX, mapY)) {
        setState(() {
          mapX -= step;
        });
      }
    } else if (currentLocation == 'PokemonLab') {
      if (canMoveTo(boyDirection, noMansLandPokeLab, LabmapX, LabmapY)) {
        setState(() {
          LabmapX -= step;
        });
      }
    }

    animateWalk();
  }

  bool showImage = false; // Variable para rastrear si se debe mostrar la imagen

  void pressedB() {
    setState(() {
      showImage = false; // Cambia el estado para ocultar la imagen
    });
  }

  void pressedA() {
    double interactionRange = 0.1;

    if (currentLocation == 'littleroot') {
      // Recorre cada dirección y sus posiciones
      for (var entry in oakPositions.entries) {
        String direction = entry.key; // Obtiene la dirección
        List<List<double>> positions = entry.value;

        for (var position in positions) {
          double oakX = position[0];
          double oakY = position[1];

          // Verifica si el jugador está cerca de Oak
          if ((cleanNum(mapX - oakX).abs() < interactionRange) &&
              (cleanNum(mapY - oakY).abs() < interactionRange)) {
            // Aquí ya tenemos la dirección directamente de la entrada
            String oakDirection = direction; // Asigna la dirección directamente

            // Muestra la imagen y actualiza la dirección
            setState(() {
              showImage = true;
              this.oakDirection = oakDirection; // Actualiza la dirección de Oak
            });
          }
        }
      }
    }
  }

  void animateWalk() {
    print('x: ' + mapX.toString() + ', y: ' + mapY.toString());
    print('x: ' + LabmapX.toString() + ', y: ' + LabmapY.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
      });

      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  //Littleroot
                  LittleRoot(
                    x: mapX,
                    y: mapY,
                    currentMap: currentLocation,
                  ),

                  //Pokelab
                  MyPokeLab(
                      x: LabmapX, y: LabmapY, currentMap: currentLocation),

                  //MyBoy
                  Container(
                    alignment: const Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),

                  //ProfessorOak
                  Container(
                    alignment: const Alignment(0, 0),
                    child: ProfOak(
                      x: mapX,
                      y: mapY + 0.05,
                      location: currentLocation,
                      oakDirection: oakDirection,
                    ),
                  ),
                  // Mostrar la imagen si showImage es true
                  if (showImage)
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                          'lib/pokemom_image/text.png'), // Muestra la imagen
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[800],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'G A M E B O Y',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          '❤️',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        Text(
                          'F L U T T E R',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: ' ◁ ',
                                  function: moveLeft,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(
                                  text: ' △ ',
                                  function: moveUp,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: ' ▽ ',
                                  function: moveDown,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: ' ▷ ', //▲▼▶◀
                                  function: moveRight,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                                MyButton(
                                  text: 'B',
                                  function: pressedB,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyButton(
                                  text: 'A',
                                  function: pressedA,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'C R E A T E D B Y K O K O',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
