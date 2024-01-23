import 'package:flutter/material.dart';

import '../widgets/widget_caixa_dialog.dart';

void mostrarDialog(BuildContext context, tituloJanela, mensagem, tituloBotao, corFundo, corTexto) {
  showDialog(
    context: context,
    builder: (BuildContext context) => CaixaDialog(
      titulo: tituloJanela,
      mensagem: mensagem,
      tituloBotao: tituloBotao,
      corFundo: corFundo,
      corTexto: corTexto,
    )
  );
}