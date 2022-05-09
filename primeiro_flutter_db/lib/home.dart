import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // _salvar();
    // _listar();
    // _atualizar();
    // _deletar();
    return Container();
  }

  Future<Database> _recuperarBancoDados() async {
    final databasesPath = await getDatabasesPath();

    final String path = join(databasesPath, 'banco.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int recentVersion) {
        String sql =
            'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR, idade INTEGER)';
        db.execute(sql);
      },
    );

    return database;
  }

  void _salvar() async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> mapUserData = {'name': 'Roney Melo', 'idade': 39};
    await db.insert('users', mapUserData);
    _listar();
  }

  _listar() async {
    Database db = await _recuperarBancoDados();
    List users = await db.rawQuery('select * from users');

    print('Usuários: ' + users.toString());
  }

  _atualizar() async {
    Database db = await _recuperarBancoDados();
    Map<String, dynamic> mapUserUpdate = {'name': 'Reinaldo Jose', 'idade': 58};
    await db.update('users', mapUserUpdate, where: 'id = ?', whereArgs: [1]);
    _listar();
  }

  _deletar() async {
    Database db = await _recuperarBancoDados();
    await db.delete('users', where: 'id = ?', whereArgs: [5]);
    _listar();
  }
}
