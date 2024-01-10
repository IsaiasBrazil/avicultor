import 'package:flutter/material.dart';

class CaixaDialog extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final String tituloBotao;
  final Color? corTexto;
  final Color? corFundo;

  const CaixaDialog(
      {super.key,
      required this.titulo,
      required this.mensagem,
      required this.tituloBotao,
      this.corTexto,
      this.corFundo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo, style: TextStyle(fontSize: 32, color: corTexto)),
      content: Text(mensagem, style: TextStyle(fontSize: 24, color: corTexto)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, tituloBotao),
          child: Text(tituloBotao, style: TextStyle(fontSize: 24, color: corTexto)),
        )
      ],
      backgroundColor: corFundo,
    );
  }
}
