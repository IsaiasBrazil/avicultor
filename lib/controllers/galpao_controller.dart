import 'package:tcc/models/bd.dart';
import '../models/galpao.dart';
import 'dart:developer' as developer;

class GalpaoController {
  bool galpaoValido(Galpao galp) {
    return galp.codigo.isNotEmpty ? true : false;
  }

  cadastrarGalpao(Galpao galp) async {
    try {
      bool resultadoCadastro;
      if (galpaoValido(galp)) {
        BancoDados bd = BancoDados.instance;
        resultadoCadastro = await bd.inserirGalpao(galp) > 0 ? true : false;
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

  Future<List<Galpao>> obterGalpoes() async {
    BancoDados bd = BancoDados.instance;
    return bd.obterGalpoes();
  }

  atualizarGalpao(Galpao galp) async {
    try {
      BancoDados bd = BancoDados.instance;
      bool resultadoAtualizacao = await bd.atualizarGalpao(galp) > 0 ? true : false;

      return resultadoAtualizacao;
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

  excluirGalpao(Galpao galp) async {
    try {
      BancoDados bd = BancoDados.instance;
      bool resultadoExclusao = await bd.excluirGalpao(galp) > 0 ? true : false;

      return resultadoExclusao;
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