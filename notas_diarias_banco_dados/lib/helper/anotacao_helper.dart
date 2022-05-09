// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'package:notas_diarias_banco_dados/model/anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper {
  static String tableName = 'anotacao';
  static String columnId = 'id';
  static String columnTitle = 'titulo';
  static String columnDescription = 'descricao';
  static String columnData = 'data';

  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();

  // Para fazer uma validação se é null colocar ? antes da declaração
  Database? _db;

  factory AnotacaoHelper() {
    return _anotacaoHelper;
  }

  AnotacaoHelper._internal();

  get getDB async {
    if (_db == null) {
      _db = await _initDB();
    }

    return _db;
  }

  _initDB() async {
    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();

    String path = join(databasesPath, 'anotacoes.db');

    // open the database
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String sql =
            'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo varchar, descricao TEXT, data DATETIME)';

        await db.execute(sql);
      },
    );

    return database;
  }

  Future<int> salvar(Anotacao anotacao) async {
    final dataBase = await getDB;

    int id = await dataBase.insert(tableName, anotacao.toMap());

    return id;
  }

  recuperarAnotacoes() async {
    final dataBase = await getDB;

    String sql = 'select * from $tableName order by data desc';

    List anotacoes = await dataBase.rawQuery(sql);

    return anotacoes;
  }

  deletarAnotacao(int id) async {
    final db = await getDB;

    await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> atualizar(Anotacao anotacao) async {
    final dataBase = await getDB;

    int id = await dataBase.update(tableName, anotacao.toMap(),
        where: '$columnId = ?', whereArgs: [anotacao.id]);

    return id;
  }
}
