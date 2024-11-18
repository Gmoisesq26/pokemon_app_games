import 'package:flutter/material.dart';

class MyPokeLab extends StatelessWidget {
  double x;
  double y;
  String currentMap;

  MyPokeLab(
      {super.key, required this.x, required this.y, required this.currentMap});

  @override
  Widget build(BuildContext context) {
    if (currentMap == 'PokemonLab') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/pokemom_image/PokemonLab.png',
          width: MediaQuery.of(context).size.width * 0.85,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
