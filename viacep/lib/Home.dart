// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = 'Resultado';
  final TextEditingController _controllerCep = TextEditingController();

  _recupearCEP() async {
    String cep = _controllerCep.text;
    var baseUrl = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    var response = await http.get(baseUrl);

    Map<String, dynamic> retorno = jsonDecode(response.body);

    String logradouro = retorno['logradouro'];
    String cepRetorno = retorno['cep'];
    String cidade = retorno['localidade'];
    String uf = retorno['uf'];
    String bairro = retorno['bairro'];

    setState(() {
      _resultado =
          'Logradouro: ${logradouro} cep: ${cepRetorno} cidade: ${cidade} bairro: ${bairro} estado: ${uf}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CEP'),
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              controller: _controllerCep,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ex. 79010320'),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            OutlinedButton(
              onPressed: _recupearCEP,
              child: const Text('Buscar CEP'),
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
