import 'package:flutter_test/flutter_test.dart';
import 'package:tcc/controllers/galpao_controller.dart';
import 'package:tcc/models/galpao.dart';

void main() {
  late GalpaoController controlador;

  setUp(() {
    controlador = GalpaoController();
  });

  group('Validação do galpão', () {
    test(
        'deve retornar uma mensagem de erro caso o código do galpão seja vazio',
        () {
      final resultado =
          controlador.validar(galpao: const Galpao(codigo: '', descricao: ''));

      expect(resultado, equals('O código do galpão é obrigatório'));
    });

    test(
        'deve retornar uma mensagem de erro caso o código do galpão seja inválido',
        () {
      final resultado = controlador.validar(
          galpao: const Galpao(codigo: 'galpao!@#.,', descricao: ''));

      expect(resultado, equals('O código do galpão é inválido'));
    });

    test('deve retornar null caso o código do galpão seja válido', () {
      final resultado = controlador.validar(
          galpao: const Galpao(codigo: 'galpao123', descricao: ''));

      expect(resultado, isNull);
    });
  });
}
