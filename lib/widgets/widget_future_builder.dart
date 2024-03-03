import 'package:flutter/material.dart';

class NovoFutureBuilder<T> extends StatelessWidget {
  final Future<T> futuro;
  final Widget Function()? carregamento;
  final Widget Function(T dados) carregamentoFinalizado;
  final Widget Function(String erro)? erro;

  const NovoFutureBuilder({
    super.key, 
    required this.futuro, 
    this.carregamento, 
    required this.carregamentoFinalizado,
    this.erro,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: futuro,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return carregamento?.call() ?? 
                 const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              return erro?.call(snapshot.error.toString()) ?? 
                     Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return carregamentoFinalizado(snapshot.data as T);
            } else {
              return const Text('Sem dados');
            }
        }
      },
    );
  }
}