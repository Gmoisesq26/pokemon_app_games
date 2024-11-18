import 'package:flutter/material.dart';

class LittleRoot extends StatelessWidget {
  double x;
  double y;
  String currentMap;

  LittleRoot(
      {super.key, required this.x, required this.y, required this.currentMap});

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'littleroot') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/pokemom_image/Littleroot.png',
          width: MediaQuery.of(context).size.width * 0.85,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
