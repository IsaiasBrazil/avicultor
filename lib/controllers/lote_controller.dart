import 'package:tcc/controllers/galpao_controller.dart';
import '../models/bd.dart';
import '../models/lote.dart';
import '../models/galpao.dart';
import 'dart:developer' as developer;

class LoteController {
  bool loteValido(Lote lote) {
    return lote.codigoLote.isNotEmpty ? true : false;
  }

  cadastrarLote(Lote lote, Galpao galp) async {
    try {
      GalpaoController gController = GalpaoController();
      bool resultadoCadastro;
      if (gController.galpaoValido(galp) && loteValido(lote)) {
        BancoDados bd = BancoDados.instance;
        resultadoCadastro = await bd.inserirLote(lote);
      }
      else {
        resultadoCadastro = false;
      }

      return resultadoCadastro;
    }
    catch (erro, stack) {
      developer.log(
        '$erro', 
        name: 'Avicontrol',
        error: erro.toString(),
        stackTrace: stack
      );
      return null;
    }
  }
}