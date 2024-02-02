import 'package:flutter/material.dart';

import '../widgets/widget_caixa_dialog.dart';

void mostrarDialog(BuildContext context, String tituloJanela, String mensagem, String tituloBotao, Color corFundo, Color corTexto) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CaixaDialog(
      titulo: tituloJanela,
      mensagem: mensagem,
      tituloBotao: tituloBotao,
      corFundo: corFundo,
      corTexto: corTexto,
    ),
    barrierDismissible: false
  );
}