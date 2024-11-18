import 'package:flutter/material.dart';

class MyBoy extends StatelessWidget {
  final int boySpriteCount;
  final String direction;
  final String location;
  double height = 25;
  MyBoy(
      {super.key,
      required this.boySpriteCount,
      required this.direction,
      required this.location});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      height = 15;
    } else if (location == 'PokemonLab') {
      height = 30;
    } else if (location == 'battleground' ||
        location == 'attackoption' ||
        location == 'battlefinishedscreen') {
      height = 0;
    }

    return Container(
      height: height,
      child: Image.asset(
        'lib/pokemom_image/Boy' +
            direction +
            boySpriteCount.toString() +
            '.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
