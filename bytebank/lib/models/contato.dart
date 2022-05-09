import 'package:flutter/material.dart';

class Contato extends ChangeNotifier {
  final String nomeContato;
  final int numeroConta;
  final int id;

  Contato(this.nomeContato, this.numeroConta, this.id);

  @override
  String toString() {
    return 'Contato{nomeContato: $nomeContato, numeroConta: $numeroConta, id: $id}';
  }
}
