import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../classes/galpao.dart';
import '../classes/lote.dart';
import '../classes/sensor.dart';

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
    await db.execute(_criarTabelaGalpao);
    await db.execute(_criarTabelaLote);
    await db.execute(_criarTabelaSensor);
  }

  String get _criarTabelaGalpao => '''
    CREATE TABLE IF NOT EXISTS galpoes (
      codigo TEXT PRIMARY KEY,
      descricao TEXT
    );
  ''';

  String get _criarTabelaLote => '''
    CREATE TABLE IF NOT EXISTS lotes (
      codigo TEXT PRIMARY KEY,
      descricao TEXT,
      idade INTEGER,
      data_chegada TEXT,
      fk_cod_galpao TEXT,
      FOREIGN KEY (fk_cod_galpao) REFERENCES galpoes (codigo)
    );
  ''';

  String get _criarTabelaSensor => '''
    CREATE TABLE IF NOT EXISTS sensores (
      codigo TEXT PRIMARY KEY,
      descricao TEXT,
      fk_cod_galpao TEXT,
      tipo TEXT
    )
  ''';

  // Queries dos galpões
  Future<bool> inserirGalpao(Galpao galpao) async {
    final db = await database;
    final resultadoInsercao = await db.insert('galpoes', galpao.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Galpao>> obterGalpoes() async {
    Database db = await instance.database;
    var galpoes = await db.query('galpoes');

    List<Galpao> listaGalpoes = galpoes.isNotEmpty ? galpoes.map((g) => Galpao.fromMap(g)).toList() : [];
    return listaGalpoes;
  }

  Future<bool> galpaoExiste(String codigo) async {
    Database db = await instance.database;
    var resultado = await db.query('galpoes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultado.isNotEmpty ? true : false;
  }

  Future<bool> excluirGalpao(String codigo) async {
    Database db = await instance.database;
    var resultadoExclusao = await db.delete('galpoes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultadoExclusao == 1 ? true : false;
  }

  // Queries dos lotes
  Future<bool> inserirLote(Lote lote) async {
    final db = await database;
    final resultadoInsercao = await db.insert('lotes', lote.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Lote>> obterLotes() async {
    Database db = await instance.database;
    var lotes = await db.query('lotes');

    List<Lote> listaLotes = lotes.isNotEmpty ? lotes.map((l) => Lote.fromMap(l)).toList() : [];
    return listaLotes;
  }

  Future<bool> excluirLote(String codigo) async {
    Database db = await instance.database;
    var resultadoExclusao = await db.delete('lotes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultadoExclusao == 1 ? true : false;
  }

  // Queries dos sensores
  Future<bool> inserirSensor(Sensor sensor) async {
    final db = await database;
    final resultadoInsercao = await db.insert('sensores', sensor.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Sensor>> obterSensores() async {
    Database db = await instance.database;
    var sensores = await db.query('sensores');

    List<Sensor> listaSensores = sensores.isNotEmpty ? sensores.map((s) => Sensor.fromMap(s)).toList() : [];
    return listaSensores;
  }

  Future<bool> excluirSensor(String codigo) async {
    Database db = await instance.database;
    var resultadoExclusao = await db.delete('sensores', where: 'codigo = ?', whereArgs: [codigo]);

    return resultadoExclusao == 1 ? true : false;
  }
}
