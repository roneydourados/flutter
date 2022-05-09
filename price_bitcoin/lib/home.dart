import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = '0,00';

  void _recupearPrecoBitCon() async {
    var baseUrl = Uri.parse('https://blockchain.info/ticker');

    var response = await http.get(baseUrl);

    Map<String, dynamic> retorno = jsonDecode(response.body);

    setState(() {
      _preco = retorno['BRL']['buy'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/bitcoin.png'),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  'R\$' + _preco,
                  style: const TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                ),
                onPressed: _recupearPrecoBitCon,
                child: const Text(
                  'Atualizar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
