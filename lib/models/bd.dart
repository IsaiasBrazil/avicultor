import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'producao.dart';
import 'galpao.dart';
import 'lote.dart';
import 'sensor.dart';

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
    await db.execute(_criarTabelaProducao);
    await db.execute(_seed);
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

  String get _criarTabelaProducao => '''
    CREATE TABLE IF NOT EXISTS producoes (
      codigo TEXT PRIMARY KEY,
      fk_cod_lote TEXT,
      quantidade_aves INTEGER,
      peso REAL,
      data TEXT,
      observacao TEXT,
      FOREIGN KEY (fk_cod_lote) REFERENCES lotes (codigo)
    )
  ''';

  String get _seed => '''
    INSERT INTO galpoes (codigo, descricao) 
    VALUES ('asd1', 'dve'), ('asd2', 'ugb'), ('asd3', 'kvr'), ('asd4', 'vbk'), ('asd5', 'qrw'), ('asd6', 'bjx'), ('asd7', 'xwp'), ('asd8', 'dtr'), ('asd9', 'uvd'), ('asd10', 'drr'), ('asd11', 'flz'), ('asd12', 'dte'), ('asd13', 'jxp'), ('asd14', 'yvm'), ('asd15', 'por'), ('asd16', 'kgy'), ('asd17', 'awh'), ('asd18', 'two'), ('asd19', 'qri'), ('asd20', 'xwt'), ('asd21', 'iuc'), ('asd22', 'cdf'), ('asd23', 'agm'), ('asd24', 'wev'), ('asd25', 'jri'), ('asd26', 'kyp'), ('asd27', 'kvl'), ('asd28', 'wwt'), ('asd29', 'xns'), ('asd30', 'qqp')
  ''';

  //, ('asd31', 'dzi'), ('asd32', 'afq'), ('asd33', 'eys'), ('asd34', 'hwj'), ('asd35', 'kxo'), ('asd36', 'zte'), ('asd37', 'dxu'), ('asd38', 'ksu'), ('asd39', 'vyq'), ('asd40', 'afi'), ('asd41', 'jdx'), ('asd42', 'qxv'), ('asd43', 'qfd'), ('asd44', 'bfn'), ('asd45', 'oya'), ('asd46', 'hob'), ('asd47', 'ilu'), ('asd48', 'ymx'), ('asd49', 'pod'), ('asd50', 'rlf'), ('asd51', 'nlb'), ('asd52', 'hnb'), ('asd53', 'bfj'), ('asd54', 'mla'), ('asd55', 'vwt'), ('asd56', 'kur'), ('asd57', 'yrw'), ('asd58', 'mzq'), ('asd59', 'hrv'), ('asd60', 'tlm'), ('asd61', 'zhh'), ('asd62', 'lda'), ('asd63', 'hpl'), ('asd64', 'tew'), ('asd65', 'dop'), ('asd66', 'yhv'), ('asd67', 'oym'), ('asd68', 'bsm'), ('asd69', 'ajv'), ('asd70', 'koj'), ('asd71', 'rxi'), ('asd72', 'fmr'), ('asd73', 'ttd'), ('asd74', 'eix'), ('asd75', 'cnl'), ('asd76', 'fhs'), ('asd77', 'efh'), ('asd78', 'nee'), ('asd79', 'rve'), ('asd80', 'ovh'), ('asd81', 'hdm'), ('asd82', 'kxw'), ('asd83', 'pmb'), ('asd84', 'oxy'), ('asd85', 'qqm'), ('asd86', 'gsg'), ('asd87', 'vft'), ('asd88', 'sxd'), ('asd89', 'flz'), ('asd90', 'xqe'), ('asd91', 'sos'), ('asd92', 'lva'), ('asd93', 'nvh'), ('asd94', 'yvz'), ('asd95', 'kxx'), ('asd96', 'rmt'), ('asd97', 'diu'), ('asd98', 'ext'), ('asd99', 'pfz'), ('asd100', 'fnx')  

  // Queries dos galpões
  Future<int> inserirGalpao(Galpao galpao) async {
    final db = await database;
    final resultadoInsercao = await db.insert('galpoes', galpao.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao;
  }

  Future<int> atualizarGalpao(Galpao galpao) async {
    final db = await database;
    final resultadoAtualizacao = await db.update('galpoes', galpao.toMap(),
        where: 'codigo = ?', whereArgs: [galpao.codigo]);

    return resultadoAtualizacao;
  }

  Future<List<Galpao>> obterGalpoes() async {
    Database db = await instance.database;
    var galpoes = await db.query('galpoes');

    List<Galpao> listaGalpoes = galpoes.isNotEmpty
        ? galpoes.map((g) => Galpao.fromMap(g)).toList()
        : [];
    return listaGalpoes;
  }

  Future<bool> galpaoExiste(String codigo) async {
    Database db = await instance.database;
    var resultado =
        await db.query('galpoes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultado.isNotEmpty ? true : false;
  }

  Future<int> excluirGalpao(Galpao galpao) async {
    Database db = await instance.database;
    var resultadoExclusao =
        await db.delete('galpoes', where: 'codigo = ?', whereArgs: [galpao.codigo]);

    return resultadoExclusao;
  }

  // Queries dos lotes
  Future<bool> inserirLote(Lote lote) async {
    final db = await database;
    final resultadoInsercao = await db.insert('lotes', lote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Lote>> obterLotes() async {
    Database db = await instance.database;
    var lotes = await db.query('lotes');

    List<Lote> listaLotes =
        lotes.isNotEmpty ? lotes.map((l) => Lote.fromMap(l)).toList() : [];
    return listaLotes;
  }

  Future<bool> loteExiste(String codigo) async {
    Database db = await instance.database;
    var resultado =
        await db.query('lotes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultado.isNotEmpty ? true : false;
  }

  Future<bool> excluirLote(String codigo) async {
    Database db = await instance.database;
    var resultadoExclusao =
        await db.delete('lotes', where: 'codigo = ?', whereArgs: [codigo]);

    return resultadoExclusao == 1 ? true : false;
  }

  // Queries dos sensores
  Future<bool> inserirSensor(Sensor sensor) async {
    final db = await database;
    final resultadoInsercao = await db.insert('sensores', sensor.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Sensor>> obterSensores() async {
    Database db = await instance.database;
    var sensores = await db.query('sensores');

    List<Sensor> listaSensores = sensores.isNotEmpty
        ? sensores.map((s) => Sensor.fromMap(s)).toList()
        : [];
    return listaSensores;
  }

  Future<bool> excluirSensor(String codigo) async {
    Database db = await instance.database;
    var resultadoExclusao =
        await db.delete('sensores', where: 'codigo = ?', whereArgs: [codigo]);

    return resultadoExclusao == 1 ? true : false;
  }

  // Queries das produções
  Future<bool> inserirProducao(Producao p) async {
    final db = await database;
    final resultadoInsercao = await db.insert('producoes', p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return resultadoInsercao != -1 ? true : false;
  }

  Future<List<Producao>> obterProducoes() async {
    Database db = await instance.database;
    var producoes = await db.query('producoes');

    List<Producao> listaProducoes = producoes.isNotEmpty
        ? producoes.map((p) => Producao.fromMap(p)).toList()
        : [];
    return listaProducoes;
  }
}
