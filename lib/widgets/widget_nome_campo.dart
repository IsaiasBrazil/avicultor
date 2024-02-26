import 'package:flutter/material.dart';

class NomeCampo extends StatelessWidget {
  final String texto;
  final double paddingSuperior;
  final double paddingInferior;
  final double paddingEsquerda;
  final double paddingDireita;
  final double tamanhoFonte;

  const NomeCampo(
      {super.key,
      required this.texto,
      required this.paddingSuperior,
      required this.paddingInferior,
      required this.paddingEsquerda,
      required this.paddingDireita,
      required this.tamanhoFonte});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingSuperior,
          bottom: paddingInferior,
          left: paddingEsquerda,
          right: paddingDireita),
      child: Text(
        texto,
        style: TextStyle(fontSize: tamanhoFonte),
      ),
    );
  }
}