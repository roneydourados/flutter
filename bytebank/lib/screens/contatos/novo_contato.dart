import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_validator_dart/flux_validator_dart.dart';

class NovoContatoForm extends StatefulWidget {
  const NovoContatoForm({Key? key}) : super(key: key);

  @override
  State<NovoContatoForm> createState() => _NovoContatoFormState();
}

class _NovoContatoFormState extends State<NovoContatoForm> {
  final _formContactData = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroContaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color backColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo contato',
        ),
        backgroundColor: backColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formContactData,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                  ),
                  style: const TextStyle(fontSize: 20.0),
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  maxLength: 100,
                  validator: (value) {
                    if (value == null) {
                      return 'Nome inválido!';
                    }

                    if (value.length < 3) {
                      return 'Nome inválido!';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Número da conta',
                  ),
                  style: const TextStyle(fontSize: 20.0),
                  controller: _numeroContaController,
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  validator: (value) => Validator.number(value) ? 'Conta Inválida' : null,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final String name = _nomeController.text;
                      final int? numberConta = int.tryParse(_numeroContaController.text);

                      final Contato novoContato = Contato(name, numberConta!, 0);
                      save(novoContato).then((id) => Navigator.pop(context));
                    },
                    child: const Text('Salvar contato'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
