import 'package:flutter/material.dart';

class ProfOak extends StatelessWidget {
  double x;
  double y;
  String location;
  String oakDirection;

  ProfOak(
      {super.key,
      required this.x,
      required this.y,
      required this.location,
      required this.oakDirection});

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      return Container(
        alignment: Alignment(x, y),
        child: Image.asset(
          'lib/pokemom_image/profoak' + oakDirection + '.png',
          width: MediaQuery.of(context).size.width * 0.85,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }
}
