import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];

  void _carregarItens() {
    _itens = [];

    for (int i = 0; i < 20; i++) {
      Map<String, dynamic> item = {};

      item['titulo'] = 'Item $i criado...';
      item['descricao'] =
          'Este é um exemplo de como se montar uma listagem do item $i';

      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarItens();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              return ListTile(
                title: Text('Item ' + _itens[indice]['titulo']),
                subtitle: Text(_itens[indice]['descricao']),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Item ' + _itens[indice]['titulo']),
                          titlePadding: const EdgeInsets.all(20),
                          titleTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                          ),
                          content: Text(_itens[indice]['descricao']),
                          contentTextStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Confirmar'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                            ),
                          ],
                        );
                      });
                },
                // onLongPress: () {},
              );
            },
          ),
        ));
  }
}
