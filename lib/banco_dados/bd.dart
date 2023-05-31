import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/galpao.dart';

class BancoDados {
  BancoDados._();

  static final BancoDados instance = BancoDados._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    return _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'dados.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(_createGalpaoTable);
  }

  String get _createGalpaoTable => '''
    CREATE TABLE galpoes (
      codigo TEXT PRIMARY KEY,
      descricao TEXT
    );
  ''';

  Future<bool> inserirGalpao(Galpao galpao) async {
    final db = await database;
    final resultado = await db.insert('galpoes', galpao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    debugPrint('Código do galpão: ${galpao.codigo}');
    debugPrint('Descrição do galpão: ${galpao.descricao}');
    if (resultado != -1) {
      debugPrint('Galpão inserido com sucesso!');
      return true;
    } else {
      debugPrint('Falha ao inserir galpão!');
      return false;
    }
  }

  Future<List<Galpao>> obterGalpoes() async {
    Database db = await instance.database;
    var galpoes = await db.query('galpoes');

    List<Galpao> listaGalpoes = galpoes.isNotEmpty
        ? galpoes.map((c) => Galpao.fromMap(c)).toList()
        : [];
    return listaGalpoes;
  }
}
