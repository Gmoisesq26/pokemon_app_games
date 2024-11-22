import 'package:flutter/material.dart';

class Attackoption extends StatelessWidget {
  double x;
  double y;
  String currentMap;

  Attackoption(
      {super.key, required this.x, required this.y, required this.currentMap});

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'attackoption') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/pokemom_image/attackoption.png',
          width: MediaQuery.of(context).size.width * 0.75,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
