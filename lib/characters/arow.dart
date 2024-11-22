import 'package:flutter/material.dart';

class Arow extends StatelessWidget {
  final int arowSpriteCount;
  final String direction;
  final String location;
  double height = 25;
  Arow(
      {super.key,
      required this.arowSpriteCount,
      required this.direction,
      required this.location});

  @override
  Widget build(BuildContext context) {
    if (location == 'battleground') {
      height = 10;
    } else if (location == 'attackoption') {
      height = 10;
    }
    //  location == 'battlefinishedscreen') {
    // height = 10;

    return Container(
      height: height,
      child: Image.asset(
        'lib/pokemom_image/arrow.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
