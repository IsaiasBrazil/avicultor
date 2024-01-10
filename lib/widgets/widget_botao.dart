import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final VoidCallback aoSerPressionado;
  final Color corFundo;
  final Color corTexto;
  final double tamanhoFonte;

  const Botao(
      {super.key,
      required this.texto,
      required this.aoSerPressionado,
      required this.corFundo,
      required this.corTexto,
      required this.tamanhoFonte});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: aoSerPressionado,
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(corFundo)),
      child: Text(texto, style: TextStyle(fontSize: tamanhoFonte, color: corTexto)),
    );
  }
}