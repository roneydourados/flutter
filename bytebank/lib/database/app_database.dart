import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDataBase() {
  return getDatabasesPath().then(
    (dbPah) {
      final String path = join(dbPah, 'bytebank.db'); //nome e diretório do banco de dados
      return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute(
            'CREATE TABLE contatos('
            'id INTEGER PRIMARY KEY, '
            'nome text, '
            'numero_conta INTEGER) ',
          );
        },
        version: 1,
      );
    },
  );
}

Future<int> save(Contato contato) {
  return createDataBase().then(
    (db) {
      final Map<String, dynamic> mapaContatos = {};
      mapaContatos['nome'] = contato.nomeContato;
      mapaContatos['numero_conta'] = contato.numeroConta;
      return db.insert('contatos', mapaContatos);
    },
  );
}

Future<List<Contato>> findAll() {
  return createDataBase().then(
    (db) {
      return db.query('contatos').then(
        (maps) {
          final List<Contato> contatos = [];
          for (Map<String, dynamic> map in maps) {
            final Contato contato = Contato(
              map['nome'],
              map['numero_conta'],
              map['id'],
            );
            contatos.add(contato);
          }
          return contatos;
        },
      );
    },
  );
}
