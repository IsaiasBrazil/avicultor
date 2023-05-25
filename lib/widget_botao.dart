import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final VoidCallback aoSerPressionado;

  const Botao({
    required this.texto,
    required this.aoSerPressionado,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Color.fromRGBO(60, 179, 113, 1)),
      ),
      onPressed: aoSerPressionado,
      child: Text(
        texto,
        style: TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}