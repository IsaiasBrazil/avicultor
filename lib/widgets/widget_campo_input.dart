import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoInput extends StatelessWidget {
  final TextEditingController controlador;
  final double paddingSuperior;
  final double paddingInferior;
  final double paddingEsquerda;
  final double paddingDireita;
  final TextInputType tipoTeclado;
  final List<TextInputFormatter>? formatadorInput;

  const CampoInput(
      {super.key,
      required this.controlador,
      required this.paddingSuperior,
      required this.paddingInferior,
      required this.paddingEsquerda,
      required this.paddingDireita,
      required this.tipoTeclado,
      this.formatadorInput});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            top: paddingSuperior,
            bottom: paddingInferior,
            left: paddingEsquerda,
            right: paddingDireita),
        child: TextFormField(
          controller: controlador,
          keyboardType: tipoTeclado,
          inputFormatters: formatadorInput,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}