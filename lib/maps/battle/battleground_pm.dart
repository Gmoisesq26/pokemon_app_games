import 'package:flutter/material.dart';

class BattlegroundPm extends StatelessWidget {
  double x;
  double y;
  String currentMap;

  BattlegroundPm(
      {super.key, required this.x, required this.y, required this.currentMap});

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'battleground') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/pokemom_image/battleground.png',
          width: MediaQuery.of(context).size.width * 0.05,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
