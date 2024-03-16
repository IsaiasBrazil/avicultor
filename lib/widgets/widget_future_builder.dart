import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class FutureBuilderCustom<T> extends StatelessWidget {
  final Future<T> future;
  final Function(T dados) aoObterDadosComSucesso;

  const FutureBuilderCustom({
    super.key,
    required this.future,
    required this.aoObterDadosComSucesso,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          dev.log('1 - ConnectionState.waiting = ${ConnectionState.waiting}',
              name: 'Avicontrol');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasError) {
            dev.log('2 - snapshot.hasError', name: 'Avicontrol');
            dev.log('2 - snapshot.data = ${snapshot.data}', name: 'Avicontrol');
            return Center(
                child: Text('Erro: ${snapshot.error.toString()}',
                    style: const TextStyle(fontSize: 24.0)));
          } else if (snapshot.hasData) {
            dev.log('3 - snapshot.hasData', name: 'Avicontrol');
            dev.log('3 - snapshot.data = ${snapshot.data}', name: 'Avicontrol');
            return aoObterDadosComSucesso(snapshot.data as T);
          } else {
            dev.log('4 - else', name: 'Avicontrol');
            dev.log('4 - snapshot.data = ${snapshot.data}', name: 'Avicontrol');
            return const Center(
                child: Text('Nenhum dado foi retornado',
                    style: TextStyle(fontSize: 24.0)));
          }
        }
      },
    );
  }
}
