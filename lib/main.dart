import 'dart:async';

import 'package:pokemon_app_games/characters/arow.dart';
import 'package:pokemon_app_games/characters/oak.dart';
import 'package:pokemon_app_games/maps/arowboundaries.dart';
import 'package:pokemon_app_games/maps/attacaboundarues.dart';
import 'package:pokemon_app_games/maps/battle/attackoption.dart';
import 'package:pokemon_app_games/maps/battle/battleground_pm.dart';
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

  //battleground_arow
  double battlemapX = 0.1;
  double battlemapY = 0.32;

  //attaca

  double attacamapX = 0;
  double attacamapY = 0;

  //professor oak
  String oakDirection = 'Down';
  static double oakX = 0.1;
  static double oakY = 0.35;
  bool chatStarted = false;
  int countPressingA = -1;

  //boycharacter
  int boySpriteCount = 0;
  String boyDirection = 'Down';
// Arowcharcter
  int arowSpriteCount = 0;
  String arowDirection = 'Down';

  //game stuff
  String currentLocation = 'littleroot';
  double step = 0.20;

  //no mans land for littleroot(package:pokemon_app_games/maps/boundaries.dart)
  int aClickCount = 0;
  Timer? _clickTimer;

// move -------------------------------------------------------------------------------------------------------------------------------

  void moveUp() {
    boyDirection = 'Up';
    arowDirection = 'Up';

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
    } else if (currentLocation == 'battleground') {
      if (canMoveTo(
          boyDirection, noMansLandBatttleGround, battlemapX, battlemapY)) {
        setState(() {
          battlemapY -= step;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.22) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.45 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.22) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.12) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.42;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.45 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.12) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.42;
        });
      }
    } else if (currentLocation == 'attackoption') {
      if (canMoveTo(
          boyDirection, noMansLandAttackOption, attacamapX, attacamapY)) {
        setState(() {
          attacamapY -= step;
        });
      }
      if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
          double.parse((attacamapY).toStringAsFixed(4)) == 0.1) {
        setState(() {
          attacamapX = -0.7; // Asegúrate de que estas variables estén definidas
          attacamapY = 0.3;
        });
      }
    }
    animateWalk();
  }

  void moveDown() {
    boyDirection = 'Down';
    arowDirection = 'Down';

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
          showImage = false;
        });
      }
    } else if (currentLocation == 'battleground') {
      if (canMoveTo(
          boyDirection, noMansLandBatttleGround, battlemapX, battlemapY)) {
        setState(() {
          battlemapY += step;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.52) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.42;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.45 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.52) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.42;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.62) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.45 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.62) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.32;
        });
      }
    } else if (currentLocation == 'attackoption') {
      if (canMoveTo(
          boyDirection, noMansLandAttackOption, attacamapX, attacamapY)) {
        setState(() {
          attacamapY += step;
        });
      }
      if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
          double.parse((attacamapY).toStringAsFixed(4)) == 0.5) {
        setState(() {
          attacamapX = -0.7; // Asegúrate de que estas variables estén definidas
          attacamapY = 0.3;
        });
      }
    }

    animateWalk();
  }

  void moveLeft() {
    boyDirection = 'Left';
    arowDirection = 'Left';

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
    } else if (currentLocation == 'battleground') {
      if (canMoveTo(
          boyDirection, noMansLandBatttleGround, battlemapX, battlemapY)) {
        setState(() {
          battlemapX -= step;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.25 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.32) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.25 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.42) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.42;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == -0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.32) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == -0.1 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.42) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.42;
        });
      }
    } else if (currentLocation == 'attackoption') {
      if (canMoveTo(
          boyDirection, noMansLandAttackOption, attacamapX, attacamapY)) {
        setState(() {
          attacamapX -= step;
        });
      }
      if (double.parse((attacamapX).toStringAsFixed(4)) == -0.9 &&
          double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
        setState(() {
          attacamapX = -0.7; // Asegúrate de que estas variables estén definidas
          attacamapY = 0.3;
        });
      }
    }
    animateWalk();
  }

  void moveRight() {
    boyDirection = 'Right';
    arowDirection = 'Right';

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
    } else if (currentLocation == 'battleground') {
      if (canMoveTo(
          boyDirection, noMansLandBatttleGround, battlemapX, battlemapY)) {
        setState(() {
          battlemapX += step;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.3 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.32) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.3 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.42) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.45;
          battlemapY = 0.42;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.65 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.32) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.32;
        });
      }
      if (double.parse((battlemapX).toStringAsFixed(4)) == 0.65 &&
          double.parse((battlemapY).toStringAsFixed(4)) == 0.42) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.42;
        });
      }
    } else if (currentLocation == 'attackoption') {
      if (canMoveTo(
          boyDirection, noMansLandAttackOption, attacamapX, attacamapY)) {
        setState(() {
          attacamapX += step;
        });
      }
      if (double.parse((attacamapX).toStringAsFixed(4)) == -0.5 &&
          double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
        setState(() {
          attacamapX = -0.7; // Asegúrate de que estas variables estén definidas
          attacamapY = 0.3;
        });
      }
    }

    animateWalk();
  }
//-------------------------------------------------------------------------------------------------------------------------------------

  bool showImage = false; // Variable para rastrear si se debe mostrar la imagen
  //variables de vida-------------------------------------------------------------------------------------------------------------------
  //char-------------------
  bool showImage1 = false;
  bool showImage2 = false;

  bool showImage3 = false;
  bool showImage4 = false;

  bool showImage5 = false;
  bool showImage6 = false;
  //pika---------------------
  bool showImageap = false;
  bool showImagep1 = false;

  bool showImagep2 = false;

  bool showImagep3 = false;
  bool showImagep4 = false;

//battlefinish
  bool showImageF = false;
// action button------------------------------------------------------------------------------------------------------------------------
  void pressedB() {
    if (currentLocation == 'littleroot') {
      setState(() {
        showImage = false; // Cambia el estado para ocultar la imagen
      });
    }
    if (currentLocation == 'attackoption') {
      if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
          double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
        setState(() {
          currentLocation = 'battleground';
          battlemapX = 0.1;
          battlemapY = 0.32;
        });
      }
    }
  }

  void pressedA() {
    aClickCount++;
    if (_clickTimer != null && _clickTimer!.isActive) {
      _clickTimer!.cancel();
    }
    _clickTimer = Timer(Duration(seconds: 1), () {
      aClickCount = 0;
    });

    if (currentLocation == 'littleroot') {
      if (aClickCount == 1) {
        double interactionRange = 0.1;

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
              String oakDirection =
                  direction; // Asigna la dirección directamente

              // Muestra la imagen y actualiza la dirección
              setState(() {
                showImage = true;
                this.oakDirection =
                    oakDirection; // Actualiza la dirección de Oak
              });
            }
          }
        }
      } else if (aClickCount == 2) {
        double interactionRange =
            0.2; // Recorre cada dirección y sus posiciones
        for (var entry in oakPositions.entries) {
          String direction = entry.key; // Obtiene la dirección
          List<List<double>> positions = entry.value;
          for (var position in positions) {
            double battlemapX = position[0];
            double battlemapY = position[1];
            if ((cleanNum(mapX - battlemapX).abs() < interactionRange) &&
                (cleanNum(mapY - battlemapY).abs() < interactionRange)) {
              setState(() {
                currentLocation = 'battleground';
                mapX = 0;
                mapY = 0;
              });
            }
          }
        }
      }
    }
    if (currentLocation == 'battleground') {
      if (aClickCount == 1) {
        if (double.parse((battlemapX).toStringAsFixed(4)) == 0.45 &&
            double.parse((battlemapY).toStringAsFixed(4)) == 0.42) {
          setState(() {
            currentLocation = 'littleroot';
            mapX = 0.1000000000000002;
            mapY = 0.15000000000000002;
            showImage = false;
          });
        }
      }
    }
    if (currentLocation == 'battleground') {
      if (aClickCount == 1) {
        if (double.parse((battlemapX).toStringAsFixed(4)) == 0.1 &&
            double.parse((battlemapY).toStringAsFixed(4)) == 0.32) {
          setState(() {
            currentLocation = 'attackoption';
            attacamapX = -0.7;
            attacamapY = 0.3;
            showImage = false;
          });
        }
      }
    }
    if (currentLocation == 'attackoption') {
      if (aClickCount == 1) {
        if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
            double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
          setState(() {
            attacamapX =
                -0.7; // Asegúrate de que estas variables estén definidas
            attacamapY = 0.3;
            showImage = true; // Cambia el estado para mostrar la imagen
          });
          Timer(Duration(seconds: 1), () {
            setState(() {
              showImage = false; // Ocultar la imagen después de 1 segundo
            });
          });

          // Código para agregar las imágenes(daño a char)
          Timer(Duration(seconds: 2), () {
            setState(() {
              showImage1 = true;
              showImage2 = true;
            });
          });
          Timer(Duration(seconds: 3), () {
            //atacar a pika
            setState(() {
              showImageap = true;
            });
          });
          Timer(Duration(seconds: 4), () {
            setState(() {
              showImageap = false;
            });
          });
          Timer(Duration(seconds: 5), () {
            //daño a pika
            setState(() {
              showImagep1 = true;
            });
          });
        }
      }
    }
    // Aquí puedes llamar a una función que agregue las imágenes }
    //   'lib/pokemom_image/blackbar.png'
    if (currentLocation == 'attackoption') {
      if (aClickCount == 2) {
        if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
            double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
          setState(() {
            attacamapX =
                -0.7; // Asegúrate de que estas variables estén definidas
            attacamapY = 0.3;
            showImage = true; // Cambia el estado para mostrar la imagen
          });
          Timer(Duration(seconds: 1), () {
            setState(() {
              showImage = false; // Ocultar la imagen después de 1 segundo
            });
          });

          showImage3 = true;
          showImage4 = true;
          Timer(Duration(seconds: 1), () {
            setState(() {
              showImageap = true;
            });
          });
          Timer(Duration(seconds: 2), () {
            setState(() {
              showImageap = false;
            });
          });
          Timer(Duration(seconds: 3), () {
            setState(() {
              showImagep2 = true;
            });
          });
        }
      }
    } //--------------------------------------------------------------
    if (currentLocation == 'attackoption') {
      if (aClickCount == 3) {
        if (double.parse((attacamapX).toStringAsFixed(4)) == -0.7 &&
            double.parse((attacamapY).toStringAsFixed(4)) == 0.3) {
          setState(() {
            attacamapX =
                -0.7; // Asegúrate de que estas variables estén definidas
            attacamapY = 0.3;
            showImage = true; // Cambia el estado para mostrar la imagen
          });
          Timer(Duration(seconds: 1), () {
            setState(() {
              showImage = false; // Ocultar la imagen después de 1 segundo
            });
          });

          showImage5 = true;
          showImage6 = true;
          Timer(Duration(seconds: 1), () {
            setState(() {
              showImageap = true;
            });
          });
          Timer(Duration(seconds: 2), () {
            setState(() {
              showImageap = false;
            });
          });
          Timer(Duration(seconds: 3), () {
            setState(() {
              showImagep3 = true;
              showImagep4 = true;
            });
          });
          Timer(Duration(seconds: 5), () {
            setState(() {
              showImageF = true;
            });
          });
          Timer(Duration(seconds: 6), () {
            setState(() {
              currentLocation = 'littleroot';
              mapX = 0.1000000000000002;
              mapY = 0.15000000000000002;
              showImage = false;
              showImageF = false;
              showImage1 = false;
              showImage2 = false;

              showImage3 = false;
              showImage4 = false;

              showImage5 = false;
              showImage6 = false;
              //pika---------------------

              showImagep1 = false;

              showImagep2 = false;

              showImagep3 = false;
              showImagep4 = false;
            });
          });
        }
      }
    }
  }

//-----------------------------------------------------------------------------------------------------------------------------------------

  void animateWalk() {
    print('x: ' + mapX.toString() + ', y: ' + mapY.toString());
    print('x: ' + LabmapX.toString() + ', y: ' + LabmapY.toString());
    print('x: ' + battlemapX.toString() + ', y: ' + battlemapY.toString());
    print('x: ' + attacamapX.toString() + ', y: ' + attacamapY.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySpriteCount++;
        arowSpriteCount++;
      });

      if (boySpriteCount == 3) {
        boySpriteCount = 0;
        timer.cancel();
      }

      if (arowSpriteCount == 3) {
        arowSpriteCount = 0;
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

                  // battleground
                  BattlegroundPm(x: 0, y: 0, currentMap: currentLocation),

                  //attackoption
                  Attackoption(x: 0, y: 0, currentMap: currentLocation),

                  //MyBoy
                  Container(
                    alignment: const Alignment(0, 0),
                    child: MyBoy(
                      location: currentLocation,
                      boySpriteCount: boySpriteCount,
                      direction: boyDirection,
                    ),
                  ),

                  //Arow battleground
                  if (currentLocation == 'battleground')
                    Container(
                      alignment: Alignment(battlemapX, battlemapY),
                      child: Arow(
                        location: currentLocation,
                        arowSpriteCount: arowSpriteCount,
                        direction: arowDirection,
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
                  if (currentLocation == 'littleroot' && showImage)
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'lib/pokemom_image/text.png', // Muestra la imagen
                      ),
                    ),

//imagenes de la barra de vida--------------------------------------------------------------------------------------------------------
//charmander-------------------------------------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImage1)
                    Container(
                      alignment: const Alignment(-0.6, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  if (currentLocation == 'attackoption' && showImage1)
                    Container(
                      alignment: const Alignment(-0.7, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  //---------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImage3)
                    Container(
                      alignment: const Alignment(-0.8, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  if (currentLocation == 'attackoption' && showImage4)
                    Container(
                      alignment: const Alignment(-0.9, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  //----------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImage5)
                    Container(
                      alignment: const Alignment(-1, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  if (currentLocation == 'attackoption' && showImage6)
                    Container(
                      alignment: const Alignment(-1.1, -0.75),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
//pikachu-------------------------------------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImagep1)
                    Container(
                      alignment: const Alignment(1.35, 0.22),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  //----------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImagep2)
                    Container(
                      alignment: const Alignment(1.25, 0.22),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  //---------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImagep3)
                    Container(
                      alignment: const Alignment(1.15, 0.22),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
                  if (currentLocation == 'attackoption' && showImagep4)
                    Container(
                      alignment: const Alignment(1.05, 0.22),
                      child: Image.asset(
                        'lib/pokemom_image/blackbar.png', // Muestra la imagen
                        width: 200, // Ancho de la imagen en píxeles
                        height: 200,
                      ),
                    ),
//----------------Attack to pikachu-------------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImageap)
                    Container(
                      alignment: const Alignment(-0.4, 0.05),
                      child: Image.asset(
                        'lib/pokemom_image/attackimage.png', // Muestra la imagen
                      ),
                    ),
//----------esto me ayuda a la creacion de la barra de vida--------------------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption')
                    Container(
                      alignment: const Alignment(0, 0),
                      child: Image.asset(
                        'lib/pokemom_image/attackoption_2.png', // Muestra la imagen
                        width: 275, // Ancho de la imagen en píxeles
                        height: 275,
                      ),
                    ),
//----------------Attack to charmander-------------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption' && showImage)
                    Container(
                      alignment: const Alignment(0.4, -0.3),
                      child: Image.asset(
                        'lib/pokemom_image/attackimage.png', // Muestra la imagen
                      ),
                    ),
                  //Arow attackoption------------------------------------------------------------------------------------------------
                  if (currentLocation == 'attackoption')
                    Container(
                      alignment: Alignment(attacamapX, attacamapY),
                      child: Arow(
                        location: currentLocation,
                        arowSpriteCount: arowSpriteCount,
                        direction: arowDirection,
                      ),
                    ),
                  //battlefinsh
                  if (currentLocation == 'attackoption' && showImageF)
                    Container(
                      alignment: const Alignment(0, 0),
                      child: Image.asset(
                        'lib/pokemom_image/battlefinishedscreen.png', // Muestra la imagen
                        width: 275, // Ancho de la imagen en píxeles
                        height: 275,
                      ),
                    ),
                ], //-0.6, -0.75
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
