/// aplicativo para salvar dados de usuário
/// como senha, email, imrpessão digital
/// ou algumas configurações básicas

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  _salvar() async {
    final SharedPreferences prefs = await _prefs;

    final String email = _controllerEmail.text;
    final String senha = _controllerSenha.text;

    await prefs.setString('email', email);
    await prefs.setString('senha', senha);
  }

  _recuperar() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      _controllerEmail.text = prefs.getString('email') ?? '';
      _controllerSenha.text = prefs.getString('senha') ?? '';
    });
  }

  _remover() async {
    final SharedPreferences prefs = await _prefs;

    await prefs.remove('email');
    await prefs.remove('senha');

    setState(() {
      _controllerEmail.text = '';
      _controllerSenha.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manipular shared'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Text(
              'Nada salvo!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextField(
              controller: _controllerEmail,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _controllerSenha,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: _salvar,
                    child: const Text('Salvar'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: _recuperar,
                    child: const Text('Ler'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: _remover,
                    child: const Text('Remover'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
