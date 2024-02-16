import 'package:tcc/models/bd.dart';
import '../models/galpao.dart';
import 'dart:developer' as developer;

class GalpaoController {
  String? validar({required Galpao galpao}) {
    if (galpao.codigo.isEmpty) {
      return 'O código do galpão é obrigatório';
    }

    final regexCodigoGalpao = RegExp(r'^[a-zA-Z0-9]+$');
    if (!regexCodigoGalpao.hasMatch(galpao.codigo)) {
      return 'O código do galpão é inválido';
    }

    return null;
  }

  bool galpaoValido(Galpao galp) {
    return galp.codigo.isNotEmpty ? true : false;
  }

  cadastrarGalpao(Galpao galp) async {
    try {
      bool resultadoCadastro;
      String? resultadoValidacao = validar(galpao: galp);

      // Se a validação não retornou nenhum erro
      if (resultadoValidacao == null) {
        BancoDados bd = BancoDados.instance;
        resultadoCadastro = await bd.inserirGalpao(galp) > 0 ? true : false;
      } else {
        resultadoCadastro = false;
      }

      return resultadoCadastro;
    } catch (erro, stack) {
      developer.log('$erro',
          name: 'Avicontrol', error: erro.toString(), stackTrace: stack);
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
      bool resultadoAtualizacao =
          await bd.atualizarGalpao(galp) > 0 ? true : false;

      return resultadoAtualizacao;
    } catch (erro, stack) {
      developer.log('$erro',
          name: 'Avicontrol', error: erro.toString(), stackTrace: stack);
      return null;
    }
  }

  excluirGalpao(Galpao galp) async {
    try {
      BancoDados bd = BancoDados.instance;
      bool resultadoExclusao = await bd.excluirGalpao(galp) > 0 ? true : false;

      return resultadoExclusao;
    } catch (erro, stack) {
      developer.log('$erro',
          name: 'Avicontrol', error: erro.toString(), stackTrace: stack);
      return null;
    }
  }
}
