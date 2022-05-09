import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  Item({Key? key}) : super(key: key);

  String _valor = '';
  String _conta = '';
  String _tipo = '';
  final Map<String, Color> _cores = {
    'debito': Colors.red,
    'credito': Colors.green,
  };

  // Item(this._valor, this._conta, this._tipo); comentei vamos ver se não vai dar pau

  Item.transferencia(this._valor, this._conta, {Key? key}) : super(key: key) {
    _tipo = 'debito';
  }

  Item.deposito(this._valor, {Key? key}) : super(key: key) {
    _tipo = 'credito';
    _conta = '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(
        Icons.monetization_on,
        color: _cores[_tipo],
      ),
      title: Text(_valor),
      subtitle: Text(_conta),
    ));
  }
}
